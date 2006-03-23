From: Pieter Palmers <pieterp@joow.be>
Subject: Re: Need help developing an ALSA plugin for FreeBob
 (firewire audio)
Date: Thu, 23 Mar 2006 10:23:33 +0100
Message-ID: <44226915.1090906@joow.be>
References: <441F3CDB.7040906@joow.be> <s5hr74ujlp6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hr74ujlp6.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, linux-audio-developers@lists.sourceforge.net, freebob-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>At Tue, 21 Mar 2006 00:38:03 +0100,
>Pieter Palmers wrote:
>  
>
>>Hi all,
>>
>>I could use some help implementing an ALSA plugin for the FreeBob 
>>project (firewire audio).
>>I started off by tearing down the jack plugin for ALSA and managed to 
>>get some understanding about the generic structure of a userspace ALSA 
>>plugin. The problem at this point is that I'm a little confused about 
>>the buffer format & layout I have available for the audio samples.
>>
>>The freebob library provides functions to depacketize the firewire 
>>packets directly into user audio buffers (ALSA buffers in this case).
>>A rough illustration to implement a freebob-lib using app would be:
>>
>>... init stuff ...
>>
>>    //assign the user-provided buffers to the channels
>>    for (i=0;i<nb_out_channels;i++) {
>>        switch (freebob_streaming_get_playback_stream_type(dev,i)) {
>>            case freebob_stream_type_audio:            
>>                /* assign the audiobuffer to the stream */
>>                freebob_streaming_set_playback_stream_buffer(dev, i, 
>>(char *)audiobuffers[i], freebob_buffer_type_uint24);
>>                break;
>>            case freebob_stream_type_midi:
>>            default:
>>                break;
>>        }
>>    }
>>
>>    while(run) {
>>        // wait for one period of samples
>>        retval = freebob_streaming_wait(dev);
>>
>>        if (retval < 0) {
>>            fprintf(stderr,"Xrun\n");
>>            freebob_streaming_reset(dev);
>>            continue;
>>        }
>>       
>>        // transfer the samples to the buffer
>>        freebob_streaming_transfer_playback_buffers(dev);
>>
>>    }
>>
>>
>>The sample format currently provided is unsigned 24bit, host-endian 
>>packed into a 32bit integer. On the bus the actual sample format is 
>>unsigned 24 bit big endian, so that could be provided too (would be even 
>>more efficient).
>>
>>My first idea is to implement a 'basic' plugin, supporting only the 
>>SND_PCM_FORMAT_U24 or SND_PCM_FORMAT_U24_BE format. I assume that the 
>>plug layer will take care of all other stuff.
>>    
>>
>
>I guesss U24 is not what you want.  It's a 4-bytes foramt, which has
>24bit data in the lower 3 bytes.  Also, it's unsigned.
>
>The formt with 24bit in 3bytes is S24_3LE/BE (signed, 24bit in
>3bytes).  Or, S32_LE/BE, which is 4 bytes format.
>
>  
>
The firewire native format is S32_BE, so probably I'll use that.

>>I would also think that in this case noninterleaved buffers would be 
>>optimal, because that's the way they are internally stored for the 
>>moment (the FW packetization doesn't favor the use of interleaved buffers).
>>
>>Now my questions:
>>- what is the buffer structure layout (areas) when I implement something 
>>like
>>    snd_pcm_freebob_write(snd_pcm_ioplug_t *io,
>>                   const snd_pcm_channel_area_t *areas,
>>                   snd_pcm_uframes_t offset,
>>                   snd_pcm_uframes_t size)
>>    
>>
>
>It could be assigned freely in the plugin side (in theory), but, so
>far, it's allocated automatically via snd_pcm_mmap().  (snd_pcm_mmap()
>is always used because ioplug plugin reads/write via a pseudo mmap
>mode.)  In snd_pcm_mmap(), a local buffer is allocated for each
>channel via malloc().
>
>These addresses are set in snd_pcm_channel_area_t arrays.  The areas[]
>above is that.  For non-interleaved format, areas[ch].addr keeps the
>address of the buffer.  areas[ch].first should be normally zero, and
>areas[ch].step has the sample bit size for non-iterleaved case.
>
>  
>
That's exactly the answer I was looking for. Thanks.

>If non-local buffers are required, we'd need to extend the ioplug API
>and a bit some internals in alsa-lib, too.  It won't be hard, though.
>  
>
The freebob API allows the use of buffers allocated by the client (in 
this case the ALSA API). That is the most efficient case. The flow I 
discribed in my mail used fixed buffers for audio I/O, but that isn't 
nescessary. One can also set new buffer addresses each 'period'. 
Something like this would probably do the trick:

snd_pcm_freebob_write(snd_pcm_ioplug_t *io,
                   const snd_pcm_channel_area_t *areas,
                   snd_pcm_uframes_t offset,
                   snd_pcm_uframes_t size) {

    for (i=0;i<nb_out_channels;i++) {
        switch (freebob_streaming_get_playback_stream_type(dev,i)) {
            case freebob_stream_type_audio:            
                /* assign the audiobuffer to the stream */
                freebob_streaming_set_playback_stream_buffer(dev, i, 
			(char *) areas[i], freebob_buffer_type_uint24);
                break;
            case freebob_stream_type_midi:
            default:
                break;
        }
    }

    // transfer the samples to the buffer
    freebob_streaming_transfer_playback_buffers(dev);


}


Assuming that the buffer locations can change every call to the plugin 
_write callback.


>>- what would be the best type of SND_PCM_IOPLUG_HW_ACCESS mode?
>>    
>>
>
>SND_PCM_ACCESS_RW_NONINTERLEAVED looks best.  Later we can add a
>support of pseudo mmap (SND_PCM_ACCESS_MMAP_NONITERLEAVED).
>  
>
What would be the difference?

>>- where do I put the freebob_streaming_wait(dev) call that blocks until 
>>a period of samples is present?
>>    
>>
>
>It's a good question.
>Basically, the style like freebob_streaming_wait() isn't preferred for
>the driver since apps use poll/select in normal cases.  If freebob API
>doesn't provide a poll/select interface, we might need a workaround
>using a thread with a pipe as jack plugin does.
>  
>
Do you mean that the plugin should provide some file descriptor that 
apps can directly use to poll on?

>>- in firewire audio, midi and audio streams are interleaved, meaning 
>>that you can't have one without the other. therefore I would like to 
>>know if there is a possibility to implement midi I/O into the same plugin.
>>    
>>
>
>Currently, no midi plugin SDK is provided (yet).  So, we'll need to
>create such one.
>  
>
At present I'll probably implement a workaround like I did for the jackd 
backend: just spawn a thread that exports the physical midi ports as 
alsa seq devices. The midi would only be available when the plugin is 
open, but that beats not having MIDI.

If you would design/implement a midi plugin SDK, please make sure it can 
be implemeted in the same plugin as PCM and that it accepts raw MIDI 
bytes. thx;)

>>- can I implement both capture and playback in the same plugin? it would 
>>be possible to implement them as separate plugins (no technical problems 
>>on the firewire side) but it would be easier if that wouldn't be nescessary.
>>    
>>
>
>Yes, a plugin supports usually both directions.  But note that each
>PCM open is always non-duplex, a single direction.  For full-duplex,
>two separate PCM streams are always opened.
>
>  
>
OK.

I also see that I'll have to change the freebob API because it doesn't 
allow separately controlling playback and capture streams, whilst that 
is supported by the firewire devices. WIP.

>>Is somebody interested in helping me out with this? I know the freebob 
>>API, but I don't know the ALSA Plugin API. Maybe someone with the 
>>opposite knowledge can free up some time to get me going? After all, the 
>>ALSA userspace plugin is all that is keeping us from going to the beta 
>>stage ;)
>>    
>>
>
>Just post any questions to here alsa-devel ML.  I have so far no
>firewire hardware, thus little knowledge about it, but I'll try to
>answer as much as possible (when my free time allows :)
>  
>
Ok, thanks.

Pieter


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
