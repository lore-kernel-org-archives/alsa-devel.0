From: Rick Wright <riwright@vt.edu>
Subject: Re: emu10k1 multichannel issue/observation
Date: Sun, 30 Oct 2005 19:12:37 -0500
Message-ID: <43656175.3040303@vt.edu>
References: <434E7646.3000507@poeticstudios.com> <5bdc1c8b0510221502v28a2cbe0ybfe049be2f34e186@mail.gmail.com> <200510230053.44479.Martin.Wohlleben@gmx.de> <5bdc1c8b0510221655r4d28430fr7b80f5403d8daaa4@mail.gmail.com> <435AF023.70903@woh.rr.com> <5bdc1c8b0510221957s278a28a7n8ead2de1e0760cf6@mail.gmail.com> <435B74E9.20308@woh.rr.com> <20051023180312.GA4544@mobilat.informatik.uni-bremen.de> <5bdc1c8b0510231123h5ed64b38nd178ce9dfcb13f87@mail.gmail.com> <1130097599.11980.54.camel@mindpipe> <5bdc1c8b0510231318j4e9db7b0x1106e9b240329249@mail.gmail.com> <435CFC95.6000703@vt.edu> <1130170444.16563.22.camel@mindpipe> <4362CBD7.8080606@vt.edu> <1130552828.32367.66.camel@mindpipe>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070801040205040007020308"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1130552828.32367.66.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070801040205040007020308
Content-Type: multipart/alternative;
 boundary="------------030604060303040505030501"


--------------030604060303040505030501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Lee Revell wrote:

>On Fri, 2005-10-28 at 21:09 -0400, Rick Wright wrote:
>  
>
>>My questions are:
>>1) Was there an early version(s) of this card where the side channels
>>aren't supported by the ALSA driver?
>>    
>>
>
>Possible.
>
>  
>
>>2) Could this be made to work?
>>    
>>
>
>Yes.
>
>  
>
>>3) If so, what info is needed and who needs it?
>>    
>>
>
>Please provide lspci output for the new card (working side channels) and
>the old one (non working side channels).
>
>  
>
Attached are the outputs of lspci for both working/non-working side 
channel machines.

These machines are basically clones and the Audigy2 card is in the same 
PCI slot in both machines.

Let me know how else to help.

Rick


--------------030604060303040505030501
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<br>
Lee Revell wrote:
<blockquote cite="mid1130552828.32367.66.camel@mindpipe" type="cite">
  <pre wrap="">On Fri, 2005-10-28 at 21:09 -0400, Rick Wright wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">My questions are:
1) Was there an early version(s) of this card where the side channels
aren't supported by the ALSA driver?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Possible.

  </pre>
  <blockquote type="cite">
    <pre wrap="">2) Could this be made to work?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Yes.

  </pre>
  <blockquote type="cite">
    <pre wrap="">3) If so, what info is needed and who needs it?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Please provide lspci output for the new card (working side channels) and
the old one (non working side channels).

  </pre>
</blockquote>
Attached are the outputs of lspci for both working/non-working side
channel machines.<br>
<br>
These machines are basically clones and the Audigy2 card is in the same
PCI slot in both machines.<br>
<br>
Let me know how else to help.<br>
<br>
Rick<br>
<br>
</body>
</html>

--------------030604060303040505030501--

--------------070801040205040007020308
Content-Type: text/plain;
 name="lspci-output-side-channels-working.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci-output-side-channels-working.txt"

00:00.0 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
00:00.1 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
00:00.2 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
00:00.3 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
00:00.4 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
00:00.7 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge [K8T800/K8T890 South]
00:07.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46)
00:08.0 VGA compatible controller: nVidia Corporation NV4 [RIVA TNT] (rev 04)
00:0b.0 Multimedia audio controller: Creative Labs SB Audigy (rev 04)
00:0b.1 Input device controller: Creative Labs SB Audigy MIDI/Game port (rev 04)
00:0b.2 FireWire (IEEE 1394): Creative Labs SB Audigy FireWire Port (rev 04)
00:0e.0 Ethernet controller: VIA Technologies, Inc. VT6120/VT6121/VT6122 Gigabit Ethernet Adapter (rev 11)
00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID Controller (rev 80)
00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [KT600/K8T800/K8T890 South]
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control

--------------070801040205040007020308
Content-Type: text/plain;
 name="lspci-output-no-side-channels.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci-output-no-side-channels.txt"

00:00.0 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
00:00.1 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
00:00.2 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
00:00.3 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
00:00.4 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
00:00.7 Host bridge: VIA Technologies, Inc. K8T800Pro Host Bridge
00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge [K8T800/K8T890 South]
00:07.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46)
00:0b.0 Multimedia audio controller: Creative Labs SB Audigy (rev 04)
00:0b.1 Input device controller: Creative Labs SB Audigy MIDI/Game port (rev 04)
00:0b.2 FireWire (IEEE 1394): Creative Labs SB Audigy FireWire Port (rev 04)
00:0e.0 Ethernet controller: VIA Technologies, Inc. VT6120/VT6121/VT6122 Gigabit Ethernet Adapter (rev 11)
00:0f.0 IDE interface: VIA Technologies, Inc. VIA VT6420 SATA RAID Controller (rev 80)
00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [KT600/K8T800/K8T890 South]
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 PF/PRO AGP 4x TMDS

--------------070801040205040007020308--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
