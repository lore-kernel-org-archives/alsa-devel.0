From: Tim Blechmann <TimBlechmann@gmx.net>
Subject: Re: [linux-audio-user] snd-hdsp+cardbus=distortion -- the
 sagacontinues (cardbus driver=culprit?) MORE UPDATE
Date: Sun, 4 Apr 2004 11:49:02 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040404114902.2c1664cc@laptop>
References: <20040403041732.FAYW17964.smtp2.fuse.net@64BitBadass>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040403041732.FAYW17964.smtp2.fuse.net@64BitBadass>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: linux-pcmcia@lists.infradead.org
Cc: ritsch@iem.at, Thomas Charbonnel <thomas@undata.org>, Paul Davis <paul@linuxaudiosystems.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

hi ico,

you did a good job in documenting this problem ... 

> TODO:
> 1) Log the Jack -R output (likely to be ridden with xrun's)
i suppose, we will get the same result as me, with jack complaining
about latency problems...

> 2) You tell me :-)
i suppose, what we are able to do, has been done ... now we'll need the
right people to talk to each other ...
mainly the alsa guys who wrote the driver and know, how they access the
bus system and the hardware, have to tell the pcmcia guys, who know,
what's going on in the bus ... i CC'd this mail to the thomas
charbonnel, paul davis and winfried ritsch, who wrote or maintain this
driver and the alsa-devel list ...
i doubt that i'm able to understand either the cardbus or the alsa side
of the driver in a reasonable time ... 

as russell king pointed out ... for him it's an unknown hardware that
accesses the bus in an unknown way and without these information he
can't be of any help ... so we'll have to give him this information and
i hope that the alsa guys can help us with that ...

cheers...

 Tim                          mailto:TimBlechmann@gmx.de
                              ICQ: 96771783
--
The only people for me are the mad ones, the ones who are mad to live,
mad to talk, mad to be saved, desirous of everything at the same time,
the ones who never yawn or say a commonplace thing, but burn, burn,
burn, like fabulous yellow roman candles exploding like spiders across
the stars and in the middle you see the blue centerlight pop and
everybody goes "Awww!"
                                                          Jack Kerouac

On Fri, 2 Apr 2004 23:17:29 -0500
"Ivica Ico Bukvic" <ico@fuse.net> wrote:

> Hi all,
> 
> I've tinkered even further with the stuff and I do have my lspci and
> other logs (will post them shortly). I've tried now runnning card with
> the external Word Clock -- the results are the same (distortion
> persists).
> 
> At this point what I know for a fact:
> 
> 1) Soundcard is distorted no matter what app/framework (i.e. direct
> Alsa access vs. Jack) I use in Linux
> 2) Likely culprit is either PCMCIA cardbus driver or the audio driver
> itself 3) External Word clock does not fix the issue
> 4) Changing sample rate does not fix the issue
> 5) Apparently sound has gaps that are comparable in size to the sound
> data buffers (apparently 32 points)
> 6) I've updated BIOS and that did not fix it (yet the DSDT table is
> still trashed on my notebook but that should not affect the
> operability of the PCMCIA card -- see next point)
> 7) Tried using the card without ACPI and APIC and the IRQ was 11
> together with the cardbus as well as with ACPI (patched 2.6.3 kernel)
> and APIC, having IRQ 17 for both the cardbus and the soundcard. Both
> sounded the same(distorted). Using only APIC without ACPI fails to
> allocate proper IRQ to cardbus (IRQ 0) resulting in failed modprobing
> of the soundcard. 8) In Win32, the card works fine on the same
> hardware and using the same IRQ 17 like in Linux, however, upon
> suspending/hibernating and resuming, the soundcard produces a similar
> but different kind of distortion than in Linux except when using
> 32000Hz sampling rate (???). 9) The color of the distortion changes in
> Linux when changing sampling rates of the card on-the-fly (Will post
> the link to the sound shortly). The sound plays slower and slower in
> Win32 when the distortion is present and higher sampling rates are
> being used 10) RME has officially ok-ed my cardbus ENE CB1410 for use
> in Win32 since they tested it in their labs and it worked ok (so all
> they talked about its problems before is not true any more)
> 11) The throughput is not the issue since I stressed the card in Win32
> and it worked ok (16 outputs at 44100Hz sampling rate at 3ms latency
> is flawless using Directx and Cool Edit Pro/Adobe Audacity, as well as
> 8 outputs at 96000Hz at 6ms latency using ASIO in Max/MSP).
> 12) Even after resuming in Win32 DirectX and MME drivers still work
> ok, it's only that ASIO drivers crap-out.
> 13) At least one more person reported similar behavior as mine on
> RME-audio news server
> 14) At least one more person has the same problem in Linux like me
> 15) Once I resume from hibernate/standby in Win32, successive
> disconnects eventually result in weird stuff, even a BSOD.
> 
> Here is the additional info regarding my notebook:
> 
> Boot log using ACPI&APIC on 2.6.3 patched kernel that fixes IRQ
> misallocation and freezes when inserting PCMCIA card:
> http://meowing.ccm.uc.edu/~ico/eMachines/boot-with-acpi&apic.log
> 
> Boot log without using ACPI&APIC on the same kernel:
> http://meowing.ccm.uc.edu/~ico/eMachines/boot-without-acpi&apic.log
> 
> Detailed view of the "distorted" sound that reveals 32-points of sound
> followed by 32-points of silence:
> http://meowing.ccm.uc.edu/~ico/eMachines/Distortion.jpg
> 
> Simple lspci output:
> http://meowing.ccm.uc.edu/~ico/eMachines/lspci-simple.log
> 
> 
> Complex lspci output (lspci -vvv)
> http://meowing.ccm.uc.edu/~ico/eMachines/lspi-complex.log
> 
> Recorded sound with the aforementioned distortion (towards the end of
> it, namely last second I actually change the sampling rate on-the-fly
> using hdspconf)(WARNING: the sound is normalized at 50% but was
> recorded clipping, so there is some artifacts just from the clipping,
> but they are simply an addon on top of what is already wrong):
> http://meowing.ccm.uc.edu/~ico/eMachines/test.wav (1.7MB)
> 
> TODO:
> 1) Log the Jack -R output (likely to be ridden with xrun's)
> 2) You tell me :-)
> 
> Any help is greatly appreciated!
> 
> Best wishes,
> 
> Ivica Ico Bukvic, composer & multimedia sculptor
> http://meowing.ccm.uc.edu/~ico/
> 
> 
> 
> 
> _______________________________________________
> Linux PCMCIA reimplementation list
> http://lists.infradead.org/mailman/listinfo/linux-pcmcia
> 



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
