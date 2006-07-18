From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000862]: emu10k1 always has random
	clicks in wavetable MIDI synth playback but never in PCM playback
Date: Tue, 18 Jul 2006 14:39:16 +0200
Message-ID: <e2e5a9fd2fcbcc48990eb9e8fc7ec697@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2B3AB176
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Jul 2006 14:39:17 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been ASSIGNED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=862> 
======================================================================
Reported By:                Will
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   862
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.10
======================================================================
Date Submitted:             01-30-2005 15:24 CET
Last Modified:              07-18-2006 14:39 CEST
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
 jdthood - 04-13-05 22:01 
----------------------------------------------------------------------
Submitter: Do you have any new information about the problem?

----------------------------------------------------------------------
 rlrevell - 04-13-05 22:26 
----------------------------------------------------------------------
This is probably still an issue.  The wavetable synth has not changed in a
long time.

It does work for me though, I don't get the clicks or dropped notes that
many people report.

----------------------------------------------------------------------
 Will - 04-14-05 15:20 
----------------------------------------------------------------------
No, no change!

----------------------------------------------------------------------
 agoode - 08-08-05 15:20 
----------------------------------------------------------------------
I have this problem with a current Fedora Core 4 kernel on x86-64 (version
2.6.12-1.1398_FC4). It seems to be something with loading of the
soundfont. asfxload or sfxload always appears to succeed, but it silently
corrupts random samples. The particular samples corrupted are often the
same ones from load to load, but not always. Different sequential runs of
asfxload may corrupt different samples.

Corrupted samples may lead to clicks that you are hearing, or it may be a
completely different problem.

It appears that asfxload is working correctly, though I am still trying to
verify it. It looks like it is basically doing a simple ioctl, and things
are getting messed up in the kernel.

Hardware: 05:02.0 Multimedia audio controller: Creative Labs SB Audigy
(rev 04)
 Class 0401: 1102:0004

I will attach an strace of asfxload. It appears some ioctl calls are
failing? (Not sure if this is normal behavior.)

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

----------------------------------------------------------------------
 Will - 03-16-06 11:56 
----------------------------------------------------------------------
It seems the problem may still exist. I'll need to do more detailed tests
to confirm this, but will not have access in the next month or so.

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
03-16-06 11:56 Will           Note Added: 0008601                          
07-18-06 14:39 jcdutton       Status                   acknowledged => assigned
07-18-06 14:39 jcdutton       Assigned To               => jcdutton        
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
