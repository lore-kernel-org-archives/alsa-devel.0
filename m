From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: emu10k1 multichannel playback design (was Re:
	[PATCH] emu10k1: add interval timer support)
Date: Sat, 25 Sep 2004 22:51:46 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1096167105.1357.5.camel@krustophenia.net>
References: <Pine.LNX.4.58.0409241546570.2289@pnote.perex-int.cz>
	 <200409241453.i8OErtVR029650@localhost.localdomain>
	 <s5hk6uj3dko.wl@alsa2.suse.de> <1096059735.11589.45.camel@krustophenia.net>
	 <1096160120.3697.35.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1096160120.3697.35.camel@krustophenia.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Jaroslav Kysela <perex@suse.cz>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 2004-09-25 at 20:55, Lee Revell wrote:
> Looks good, until it Oops'es.  This is because currently the voice
> allocator only handles one or two voices at a time, it blows up as soon
> as I go to initialize the third voice.  I am working on this.

OK, I fixed the voice allocator to handle multichannel PCM.  Now it
looks like the prepare callback is being called over and over in a loop.

Here is the debug output from the prepare callback:

in snd_emu10k1_efx_playback_prepare - start_addr 0x1000 end_addr 0x11000
init voice - master 1 extra 0 start_addr 0x1000 end_addr 0x2000
init voice - master 1 extra 0 start_addr 0x2000 end_addr 0x3000
init voice - master 1 extra 0 start_addr 0x3000 end_addr 0x4000
init voice - master 1 extra 0 start_addr 0x4000 end_addr 0x5000
init voice - master 1 extra 0 start_addr 0x5000 end_addr 0x6000
init voice - master 1 extra 0 start_addr 0x6000 end_addr 0x7000
init voice - master 1 extra 0 start_addr 0x7000 end_addr 0x8000
init voice - master 1 extra 0 start_addr 0x8000 end_addr 0x9000
init voice - master 1 extra 0 start_addr 0x9000 end_addr 0xa000
init voice - master 1 extra 0 start_addr 0xa000 end_addr 0xb000
init voice - master 1 extra 0 start_addr 0xb000 end_addr 0xc000
init voice - master 1 extra 0 start_addr 0xc000 end_addr 0xd000
init voice - master 1 extra 0 start_addr 0xd000 end_addr 0xe000
init voice - master 1 extra 0 start_addr 0xe000 end_addr 0xf000
init voice - master 1 extra 0 start_addr 0xf000 end_addr 0x10000
init voice - master 1 extra 0 start_addr 0x10000 end_addr 0x11000
in snd_emu10k1_efx_playback_prepare - start_addr 0x1000 end_addr 0x11000
init voice - master 1 extra 0 start_addr 0x1000 end_addr 0x2000
init voice - master 1 extra 0 start_addr 0x2000 end_addr 0x3000

When I start jack, the above repeats endlessly.

Here is the prepare callback:

static int snd_emu10k1_efx_playback_prepare(snd_pcm_substream_t * substream)
{
        emu10k1_t *emu = snd_pcm_substream_chip(substream);
        snd_pcm_runtime_t *runtime = substream->runtime;
        emu10k1_pcm_t *epcm = runtime->private_data;
        unsigned int start_addr, end_addr;

        start_addr = epcm->start_addr;
        end_addr = epcm->start_addr + snd_pcm_lib_buffer_bytes(substream);
        printk("in snd_emu10k1_efx_playback_prepare - start_addr 0x%x end_addr 0x%x\n", start_addr,end_addr);

        /*
         * now we need to divide the buffer into 16 chunks and initialize
         * 16 voices to make the noninterleaved 16 channel stream
         */
        unsigned int channel_size;
        int i;
        channel_size = ( end_addr - start_addr ) / 16;
        for (i = 0; i < 16; i++) {
            snd_emu10k1_pcm_init_voice(emu, 1, 0, epcm->voices[i],
                                   start_addr, start_addr+channel_size);
            start_addr += channel_size;
        }
   
        return 0;
}

I am still missing parts of the driver, like the interrupt handler.  But
it seems like the prepare callback should not loop this way.  Am I doing
something wrong?

Lee



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
