From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000862]: emu10k1 always has random clicks in wavetable MIDI synth playback but never in PCM playback
Date: Sat, 31 Dec 2005 03:30:46 +0100
Message-ID: <9d175c057c5317349343e88bf7c0a8af@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A9BF512B
	for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2005 03:30:46 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=862> 
======================================================================
Reported By:                Will
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   862
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     acknowledged
Distribution:               
Kernel Version:             2.6.10
======================================================================
Date Submitted:             01-30-2005 15:24 CET
Last Modified:              12-31-2005 03:30 CET
======================================================================
Summary:                    emu10k1 always has random clicks in wavetable MIDI
synth playback but never in PCM playback
Description: 
An Audigy 2 LS 5.1 PCI soundcard with emu10k1 chipset (the PCI id is
1102:0004 (rev 04)) always has random clicks in wavetable MIDI synth
playback but never in PCM playback using any version of alsa-driver. I
think this clicking is probably an emu10k1 driver bug.

It makes no difference which driver or kernel is used; the problem exists
with alsa-driver-CVS, alsa-driver-1.0.8, and all previous versions since
before alsa-driver-0.9.7 and with all mainline kernel versions of Linux
2.4.x and Linux 2.6.x including 2.6.10. 

It makes no difference which kernel is used (2.4.x or 2.6.x). I recently
started using CONFIG_ACPI_* with CONFIG_PCI_[GO]BIOS in 2.6.10 but it
makes no difference. I use the default PCI latencies.

It makes no difference whether or not the emu10k1 IRQ is shared and the
clicking is exactly the same regardless of which other device shares the
IRQ, e.g. "IRQ 17: 78129 IO-APIC-level  libata, EMU10K1" or "IRQ 16: 9554 
IO-APIC-level  eth0, EMU10K1".

From: Lee Revell <rlrevell AT ...>
Subject: Re: [Alsa-devel] [PATCH] emu10k1 multichannel support
Date: Sat, 29 Jan 2005 16:28:47 -0500
To: William <walsac3 AT ...>
Message-Id: <1107034127.24676.55.camel@krustophenia.net>
Content-Type: text/plain

(sorry for the late reply)

On Wed, 2005-01-19 at 19:16 +0000, William wrote:
>
> I'll mention the following in case you might be interested to look at
it.
> An issue that's been around since the very beginning of the emu10k1
driver
> is that playing a MIDI file on the wavetable often produces a
> rapid but irregular sequence of very noticeable clicks at a
> rate of 2 or 3 per second continuing for up to about 10 seconds.
> The clicking starts happening once every minute or so but without any
> clear pattern - it doesn't seem to be depend much on the contents of the
MIDI
> files.
>
> Interestingly I never hear any clicks when using the PCM and
> a soft synth like fluidsynth or timidity as an alternative method
> of MIDI playback, which is why I think it might be a bug (haven't
checked
> whether something similar has already been logged on the bugtracker).
> I had a brief look into it, but didn't find anything conclusive in the
code.
> One possibly interesting feature was I notice that I could trigger lots
of
> clicks if I tried doing real-time variable attenuation of already
playing
> notes via update_voice(vp, SNDRV_EMUX_UPDATE_VOLUME) in
emu10k1_callback.c

I would actually be interested in looking at this.  I have noticed some
areas in the code where things are commented out for odd reasons.
Specifically the samples cache is not cleared like it is for PCM voices.
If you have time please file an ALSA bug report (you can just copy and
paste this message).

> By the way, do you know the original purpose of
snd_emu10k1_sum_vol_attn()
> in emu10k1/io.c which has just been removed in alsa-driver-1.0.8?
> The cumulative volume conversion algorithm in that function
> seems like it would probably have been based on the original emu10k1
chipset
> documentation provided by Creative during its open-source era.
> It seems like a useful function to keep around for future extensions of
> the emu10k1 driver.  Maybe it should be re-instated.
>
> >From the 1.0.8 announcement:
>
>     - Summary: ALSA PCI drivers: misc cleanups
>       The patch below does the following cleanups under sound/pci/ :
>       - remove the following unused global functions:
>         - emu10k1/io.c: snd_emu10k1_sum_vol_attn
>

Yes, I asked Takashi about this and he said it just does some simple
calculation.  Check the alsa-devel archive.  But, maybe there's
something to it.  It could be related to your clicking problem.

I have heard something similar when using PCM at really low latencies.

Lee

======================================================================

----------------------------------------------------------------------
 Will - 08-08-05 17:32 
----------------------------------------------------------------------
I think the problem you are describing is probably different because the
clicks I hear during wavetable MIDI playback are random. If the soundfont
samples had been corrupted when they were first loaded by asfxload, I
would expect repeated playbacks of a fixed sequence of notes to produce
the same non-random pattern of clicks every time but it doesn't in my
case.

One new observation is that the clicking seems to depend slightly on the
tempo and on the "density" of notes -- random clicking is more likely,
though still not certain, to happen during fast passages which have lots
of short notes but it can also happen during slow passages with only
melody notes (one note at a time playing).

----------------------------------------------------------------------
 rlrevell - 12-31-05 03:30 
----------------------------------------------------------------------
Any improvement in later releases?  There have been a few bug fixes to the
wavetable synth.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-30-05 15:24 Will           New Issue                                    
01-30-05 15:24 Will           Kernel Version            => 2.6.10          
04-13-05 22:01 jdthood        Note Added: 0004480                          
04-13-05 22:26 rlrevell       Note Added: 0004484                          
04-14-05 15:20 Will           Note Added: 0004493                          
04-14-05 22:01 jdthood        Status                   new => acknowledged 
08-08-05 15:11 agoode         Issue Monitored: agoode                      
08-08-05 15:20 agoode         Note Added: 0005709                          
08-08-05 15:21 agoode         File Added: asfxload.trace                    
08-08-05 17:32 Will           Note Added: 0005710                          
12-31-05 03:30 rlrevell       Note Added: 0007329                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
