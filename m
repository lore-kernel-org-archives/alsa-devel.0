From: Pieter Palmers <pieterp@joow.be>
Subject: Need help developing an ALSA plugin for FreeBob (firewire audio)
Date: Tue, 21 Mar 2006 00:38:03 +0100
Message-ID: <441F3CDB.7040906@joow.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net, linux-audio-developers@lists.sourceforge.net
Cc: freebob-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,

I could use some help implementing an ALSA plugin for the FreeBob 
project (firewire audio).
I started off by tearing down the jack plugin for ALSA and managed to 
get some understanding about the generic structure of a userspace ALSA 
plugin. The problem at this point is that I'm a little confused about 
the buffer format & layout I have available for the audio samples.

The freebob library provides functions to depacketize the firewire 
packets directly into user audio buffers (ALSA buffers in this case).
A rough illustration to implement a freebob-lib using app would be:

... init stuff ...

    //assign the user-provided buffers to the channels
    for (i=0;i<nb_out_channels;i++) {
        switch (freebob_streaming_get_playback_stream_type(dev,i)) {
            case freebob_stream_type_audio:            
                /* assign the audiobuffer to the stream */
                freebob_streaming_set_playback_stream_buffer(dev, i, 
(char *)audiobuffers[i], freebob_buffer_type_uint24);
                break;
            case freebob_stream_type_midi:
            default:
                break;
        }
    }

    while(run) {
        // wait for one period of samples
        retval = freebob_streaming_wait(dev);

        if (retval < 0) {
            fprintf(stderr,"Xrun\n");
            freebob_streaming_reset(dev);
            continue;
        }
       
        // transfer the samples to the buffer
        freebob_streaming_transfer_playback_buffers(dev);

    }


The sample format currently provided is unsigned 24bit, host-endian 
packed into a 32bit integer. On the bus the actual sample format is 
unsigned 24 bit big endian, so that could be provided too (would be even 
more efficient).

My first idea is to implement a 'basic' plugin, supporting only the 
SND_PCM_FORMAT_U24 or SND_PCM_FORMAT_U24_BE format. I assume that the 
plug layer will take care of all other stuff.

I would also think that in this case noninterleaved buffers would be 
optimal, because that's the way they are internally stored for the 
moment (the FW packetization doesn't favor the use of interleaved buffers).

Now my questions:
- what is the buffer structure layout (areas) when I implement something 
like
    snd_pcm_freebob_write(snd_pcm_ioplug_t *io,
                   const snd_pcm_channel_area_t *areas,
                   snd_pcm_uframes_t offset,
                   snd_pcm_uframes_t size)
- what would be the best type of SND_PCM_IOPLUG_HW_ACCESS mode?
- where do I put the freebob_streaming_wait(dev) call that blocks until 
a period of samples is present?
- in firewire audio, midi and audio streams are interleaved, meaning 
that you can't have one without the other. therefore I would like to 
know if there is a possibility to implement midi I/O into the same plugin.
- can I implement both capture and playback in the same plugin? it would 
be possible to implement them as separate plugins (no technical problems 
on the firewire side) but it would be easier if that wouldn't be nescessary.

Is somebody interested in helping me out with this? I know the freebob 
API, but I don't know the ALSA Plugin API. Maybe someone with the 
opposite knowledge can free up some time to get me going? After all, the 
ALSA userspace plugin is all that is keeping us from going to the beta 
stage ;)

Thanks,

Pieter Palmers
FreeBob Developer
http://freebob.sf.net

PS: my current alsa plugin try-out code is in our CVS repo at 
sourceforge as alsa-plugin, should anyone want to take a look at the mess.
cvs -z3 -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/freebob co -P 
/alsa-plugin

/


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
