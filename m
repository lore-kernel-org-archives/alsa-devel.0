From: Pieter Palmers <pieter.palmers@student.kuleuven.ac.be>
Subject: Re: [Survey] headphone <-> master volume swap -- which
 codec chip?
Date: Fri, 24 Jan 2003 13:41:29 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E313479.5080501@student.kuleuven.ac.be>
References: <s5hu1fyyi9a.wl@alsa2.suse.de>	<Pine.LNX.4.44.0301241213200.1448-100000@pnote.perex-int.cz> <s5hn0lqyeh9.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@suse.cz>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I took a look at the Intel AC97 2.2 specs. It seems that the behaviour
described here is a AC97 2.2 recommendation. take a look at 1 & 2 of 5.2.1.

Pieter

--------------------------------------------

AC `97 Component Specification  Revision 2.2   September 2000

5.2 LINE_OUT and AUX_OUT

AC `97 audio Codecs support two independently controlled stereo outputs:
     1. The master output, labeled LINE_OUT, uses pins 35, 36 for L and R
(48 pin QFP package) and is controlled by the Master Volume Register
02h.  No changes have been made to LINE_OUT definitions.
     2. A second output, originally defined as HP_OUT, uses pins 39, 40,
and 41 for L, Common, and R (48-pin QFP  package) was re-defined as
LNLVL_OUT for AC `97 2.1, and is controlled by optional volume Register
04h.  In addition to the HP and LNLVL definitions, 4-channel Codecs
typically utilize pins 39 and 41 for the  additional (i.e. L & R
Surround) outputs.

5.2.1 AUX_OUT Options
As identified in the previous section, there are three common uses for
AC `97's second output.  AC `97 2.2  addresses all three uses by
renaming the second output as AUX_OUT, Register 04h as Aux Out Volume,
and the pins as AUX_OUT_L, AUX_OUT_C, and AUX_OUT_R.

Driver developers should be aware that the AC `97 AUX_OUT may be
implemented in one of three ways:

     1.True line level out.Support for a true consumer
equipment-compatible (10 k\Omega ) line level output that does not
change with master volume settings. Either fixed or fixable via the
independent volume controls in Register 04h, the output level provides a
1V RMS (2.8 V peak-to-peak) output level for a 0 dB gain PCM output
stream. When implemented this way, AUX_OUT is equivalent to AC `97 2.1's
LNLVL_OUT definitions.

     2.Headphone out.  AUX_OUT can be implemented to support integrated
headphone amplifier with 32 \Omega  drive capability and independent
volume control via Register 04h.  When implemented this way, AUX_OUT is
equivalent to AC `97 1.03 original HP_OUT definitions

     3. 4-Channel out.  In Codecs that support 4-channel operation,
AUX_OUT can be implemented to support the  additional (i.e. L&R
Surround) outputs. When implemented this way, AUX_OUT will be referred
to 4CH_OUT.  In 4CH_OUT implementations, L and R Surround output is
controlled via Surround Volume  Register 38h, not Aux Out Volume 04h,
and powered down via the PRJ (SDAC) bit in Register 2Ah.

AUX_OUT defaults to be LNLVL_OUT unless HP_OUT or 4CH_OUT support is
detected.  Unless the specific  Codec configuration is indicated via INF
file, driver writers should use the following methods for detecting a
specialized Codec with HP_OUT or 4CH_OUT capabilities:

* HP_OUT capability can be detected via Reset/ID Register 00h, ID bit 4
and the Aux Out Volume Register 04h default value reads "8000h" (i.e.
implemented). ID4 is no longer used to indicate LNLVL support.
* 4CH output capability can be detected via the Extended Audio ID
Register 28h, SDAC ID bit 7, and a Surround Volume Register 38h default
of "8080h" (i.e. implemented).

HP and LNLVL implementations of AUX_OUT external output are powered down
via bit PR6 in Register 26h.

--------------------------------------



Takashi Iwai wrote:

 >At Fri, 24 Jan 2003 12:16:00 +0100 (CET),
 >Jaroslav wrote:
 >
 >
 >>On Fri, 24 Jan 2003, Takashi Iwai wrote:
 >>
 >>
 >>
 >>>Hi all,
 >>>
 >>>there have been bug-reports regarding to the swapping of headphone
 >>>and master volumes.
 >>>i'd like to ask you to check which AC97 codec chip is used on which
 >>>board (or laptop) if you have such a problem.  if this happens only on
 >>>a certain chip model, we can add a quirk for that.
 >>>
 >>>
 >>Takashi, this quirk can be done only by detection of subvendor and
 >>subsystem from the PCI ID space.
 >>
 >>
 >
 >yeah, the lspci output is on the query list.
 >
 >
 >
 >>It's absolutely irrelevant which AC97
 >>chip is used.
 >>
 >>
 >
 >really?  i believe this happens only on certain ac97 chips.
 >for example, ALC202 spec says that ALC202A uses the headphone volume
 >as the "true line out" volume.  so, apparently, some ac97 chips
 >"recommend" this behavior.  let's see...
 >
 >
 >
 >>Vendor might wire codec in any way. Also, some codecs may
 >>swap line-out / headphone out via registers.
 >>
 >>
 >
 >this is a different case, imo.
 >the problem is that we have no chance to detect/switch them, either
 >manually or automatically.
 >
 >a general solution would be to add an ac97 control switch to swap
 >them.  then the accssed registers are exchanged internally according
 >to this control.
 >
 >but it isn't bad to know which chips and which machines have this
 >problem, so that we can add quirks to turn on this switch
 >automatically.
 >
 >
 >Takashi
 >
 >
 >-------------------------------------------------------
 >This SF.NET email is sponsored by:
 >SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
 >http://www.vasoftware.com
 >_______________________________________________
 >Alsa-devel mailing list
 >Alsa-devel@lists.sourceforge.net
 >https://lists.sourceforge.net/lists/listinfo/alsa-devel
 >
 >
 >






-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
