From: "Ivica Ico Bukvic" <ico@fuse.net>
Subject: Major problem with RME HDSP/Multiface and a 64-bit AMD laptop
Date: Sat, 20 Mar 2004 00:35:02 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040320053504.PWNE22400.smtp2.fuse.net@64BitBadass>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: george@synthax.com, support@synthax.de, linux-audio-dev@music.columbia.edu, linux-audio-user@music.columbia.edu, alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

First off I would like to extend my sincere apologies for my atrocious
cross-posting. I am currently in a rather desperate situation and would
highly appreciate any help I can get in this matter.

<Begin long blurb>

I recently got my hands on the eMachines M6807 64-bit Athlon 3000+ and I
must say that the notebook is very nice. The gripes I do have about it are
mostly of cosmetic nature. The performance is in many ways unmatched. After
owning the notebook for just about a month I finally found some free time to
install the Multiface/HDSP on it. I was immediately very unpleasantly
surprised by the fact that the sound output using the ASIO drivers (and
Linux ALSA drivers) yielded similar results -- distorted audio.

Now here's the catch. When I use the soundcard in mme, DirectX, or any other
driver form, the soundcard works perfectly (albeit no multichannel
capability). But when I use ALSA in Linux or ASIO in Windoze (XP Home
version), the sound plays as if it's interpreted slower than it should be (2
whole steps, or 4 semitones lower and comparably slower) with a bad
distortion, as if one is using a very lousy vocoder. There are no drop-outs
or choppiness (I did not try JACK, though, so I don't know about the
explicit xruns) which leads me to believe that the throughput is not the
culprit, but the output simply is useless.

Here's some additional info/problems I am aware of:

1) The manufacturer of the notebook is Arima (company that supplies many
other companies with the same chipset/chasis) has shipped this notebook with
a crappy BIOS (Linux at boot time complains about DSDT being all fubared and
fails to properly allocate IRQ's with the acpi turned on; also apic seems to
be fubared as well). Some of these issues have been addressed in the 2.6.2
kernels via several patches with a spotty success and currently I need to
boot with no acpi or apic to get everything working properly (otherwise
almost no peripheral works properly). So, I know for a fact that BIOS is
sucking rather bad... Contacting support so far has only suggested that
there should be some bios updates coming up soon, but I'll believe it when I
see it (OTOH this model is supposedly selling rather well as it has been
apparently licensed by at least 6 different companies across the world
including the voodoopc, so I guess that should provide some leverage).

2) I am using Mdk 10.0 Community release. No problems there that I can
notice. Installed the hdsp utils and everything worked like a charm, except
of course for the sound output.

3) The pcmcia card in XP is detected as the generic pcmcia and is using
default XP drivers without any conflicts and/or apparent problems.

4) The pcmcia card (at least in Windows) is sharing its IRQ only with the
HDSP when plugged in (IRQ 17 -- there are total of 24 due to APIC being
enabled in XP), but I don't think that should be considered a conflict
(please correct me if I am wrong).

5) In Linux due to fact that the computer boots without APCI and APIC
enabled, my guess is that it is using only first 15 IRQ's (like the old
APM-based PC), although I need to further investigate this. To the best of
my knowledge no IRQ conflicts have been reported by the syslog when using
this setup.

6) The pcmcia cardbus is using the yenta_socket driver in Linux, but
curiously cannot be used with the APCI (most likely due to fubared BIOS), as
that immediately freezes the system.

7) In Windows, I tried 2.53 and 2.62 drivers, with the latest firmware (11).
Using different drivers made no difference. I tried several ASIO-capable
applications in order to make sure this was the case.

8) No errors during use of Multiface are reported in either Linux nor
Windows.

Finally, having used Multiface on Inspiron laptops, I am quite familiar with
the sound that is being generated by the lousy throughput (crackly stuff)
and I must say that while this sounds very similar, there are couple of
things that make this sound different:

1) No matter which latency I select in hdsp configuration tool, the sound
remains the same.

2) When overclocking the laptop (this beast that runs at 1.8GHz oc's via
software without a hitch to 2GHz with no overheating and no instability
whatsoever), the pitch and the speed of the output rises (wtf?). At 2GHz
it's about 2 semitones higher (and comparably faster). I am having a feeling
that if I could oc it for another 200MHz, I would have the right playback
speed :-). OTOH, when the laptop downclocks to preserve battery (800MHz) the
sound playback remains at approx. the same speed but with a timbrally
somewhat different artifacts like the one at 1800MHz.

3) When using mme, or DirectX or any other non-ASIO playback format in
Windows, no matter what the latency in the hdsp config tool, the sound
output is flawless.

4) I also read that some of the 2.6.2 Linux kernel patches were incorporated
to fix the fact that Bios represents the CPU speed (via ACPI?) as 1600MHz
which is apparent in the Windows if one right-clicks on the My Computer icon
and clicks on Properties. However, programs like CpuID read the frequency
properly as 1800MHz.

5) FSB on this beast to the best of my knowledge should be plenty fast
(200MHz x ? -- I heard it's like 1600MHz (8x), but I find that hard to
believe). Hence, I would be seriously surprised that it is a case of a lousy
cardbus implementation... Although, I guess everything is possible...

<end long blurb>

Whew! That should be about it. If you need any syslogs or any other info,
please contact me and I will gladly provide them. I would simply appreciate
any insight at this point as I have purchased this laptop primarily for the
music-making purposes and not being able to use it with the expensive
Multiface makes either this laptop or the Multiface an expensive brick (I
say this as I did hear that M-Audio Firewire 410 runs just fine in
combination with this notebook).

Cc: 	RME support US/international
	LAD/LAU
	Alsa-dev/user

I would also appreciate any help from the RME tech department as this may
potentially stem from the fact that the system is 64-bit (although I am NOT
running 64-bit versions of either Windows or Linux) and that the drivers are
somehow not taking that into account.

Best wishes,

Ivica Ico Bukvic, composer & multimedia sculptor
http://meowing.ccm.uc.edu/~ico/
 





-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
