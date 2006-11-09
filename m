From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Rawmidi device naming
Date: Thu, 09 Nov 2006 15:39:01 -0500
Message-ID: <1163104741.16030.8.camel@mindpipe>
References: <1158946723.1097.90.camel@mindpipe>
	<1158948259.1036.271601876@webmail.messagingengine.com>
	<1163104597.16030.6.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1163104597.16030.6.camel@mindpipe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2006-11-09 at 15:36 -0500, Lee Revell wrote:
> 212 
> 213         if ((err = snd_dream_midi_init(dream, midi2, 1, "MIDI Out")) < 0)
> 214                 return err;
> 215         midi2->port = MPU1_DATA;
> 216 
> 217         if ((err = snd_dream_midi_init(dream, midi1, 0, "GM Synth")) < 0)
> 218                 return err;
> 219         midi1->port = MPU1_DATA;
> 220 
> 

Here is snd_dream_midi_init:

static int __devinit snd_dream_midi_init(struct snd_card_dream *dream, struct snd_card_dream_midi *midi, int device, char *name)
{
        snd_rawmidi_t *rmidi;
        int err;

        if ((err = snd_rawmidi_new(dream->card, name, device, 1, 1, &rmidi)) < 0)
                return err;
        midi->dream = dream;
        strcpy(rmidi->name, name);
        snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT, &snd_dream_midi_output);
        snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_INPUT, &snd_dream_midi_input);
        rmidi->info_flags |= SNDRV_RAWMIDI_INFO_OUTPUT |
                             SNDRV_RAWMIDI_INFO_INPUT |
                             SNDRV_RAWMIDI_INFO_DUPLEX;
        rmidi->private_data = midi;
//      rmidi->private_free = snd_dream_midi_free;
        midi->rmidi = rmidi;
        return 0;
}

Why does the client get the port name ?!?!?!?!?

Lee


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
