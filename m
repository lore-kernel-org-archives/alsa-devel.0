From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] Audigy + FX8010 capture (hw:x,2)
Date: Mon, 21 Jun 2004 19:26:52 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1087860356.8203.2.camel@debian>
References: <200406210745.i5L7j585017902@www3.pobox.sk>
	 <s5hy8mgn4or.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hy8mgn4or.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Peter Zubaj <pzad@pobox.sk>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

FWIW, here is what happens when trying to capture hw:x,2 using the 
current CVS, without applying Peter's patch:

debian:/home/rlrevell# jackd --realtime -d alsa -d hw:0,2
jackd 0.98.1
Copyright 2001-2003 Paul Davis and others.
jackd comes with ABSOLUTELY NO WARRANTY
This is free software, and you are welcome to redistribute it
under certain conditions; see the file COPYING for details

loading driver ..
creating alsa driver ...
hw:0,2|hw:0,2|1024|2|48000|0|0|nomon|swmeter|-|32bit
ALSA lib pcm_hw.c:1056:(snd_pcm_hw_open) open /dev/snd/pcmC0D2p failed:
No such device
jackd: pcm.c:690: snd_pcm_nonblock: Assertion `pcm' failed.
Aborted

Here is my /proc/asound/pcm:

debian:/home/rlrevell# cat /proc/asound/pcm
00-00: emu10k1 : EMU10K1 : playback 32 : capture 1
00-01: emu10k1 mic : EMU10K1 MIC : capture 1
00-02: emu10k1 efx : EMU10K1 EFX : playback 8 : capture 1

Lee

On Mon, 2004-06-21 at 14:31, Takashi Iwai wrote:
> At Mon, 21 Jun 2004 09:45:05 +0200,
> Peter Zubaj wrote:
> > 
> > Hi,
> > 
> > This patch fixes capture problems from hw:x,2 on Audigy
> > 
> > I tested 4 channel recrding and it was OK.
> > 
> > hw:x,2 records outputs from FX8010 (not FX buses)
> > 
> > Using "EFX voices mask" you can set channels what you want record.
> > 
> > use alsactl store to store config
> > edit this config (set true for needed channel for "EFX voices mask"
> > control) - I recorded channels 8,9,14,15 (front and rear output).
> > use alsactl restore to restore config
> > 
> > Looks like channel count must be power of 2 (1, 2, 4, 8, ...).
> 
> Oh, shortly before, I changed the EFX-related code a bit to merge
> playback and capture streams.
> 
> Could you regenerate the patch based on CVS?  (But wait for a while
> until anon cvs is sync'ed.)
> 
> 
> thanks,
> 
> Takashi
> 
> 
> -------------------------------------------------------
> This SF.Net email sponsored by Black Hat Briefings & Training.
> Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
> digital self defense, top technical experts, no vendor pitches, 
> unmatched networking opportunities. Visit www.blackhat.com
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
