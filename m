From: Rick Wright <riwright@vt.edu>
Subject: Re: emu10k1 multichannel issue/observation
Date: Mon, 07 Nov 2005 13:19:41 -0500
Message-ID: <436F9ABD.4080901@vt.edu>
References: <434E7646.3000507@poeticstudios.com> <5bdc1c8b0510221502v28a2cbe0ybfe049be2f34e186@mail.gmail.com> <200510230053.44479.Martin.Wohlleben@gmx.de> <5bdc1c8b0510221655r4d28430fr7b80f5403d8daaa4@mail.gmail.com> <435AF023.70903@woh.rr.com> <5bdc1c8b0510221957s278a28a7n8ead2de1e0760cf6@mail.gmail.com> <435B74E9.20308@woh.rr.com> <20051023180312.GA4544@mobilat.informatik.uni-bremen.de> <5bdc1c8b0510231123h5ed64b38nd178ce9dfcb13f87@mail.gmail.com> <1130097599.11980.54.camel@mindpipe> <5bdc1c8b0510231318j4e9db7b0x1106e9b240329249@mail.gmail.com> <435CFC95.6000703@vt.edu> <1130170444.16563.22.camel@mindpipe> <4362CBD7.8080606@vt.edu> <1130552828.32367.66.camel@mindpipe> <43656175.3040303@vt.edu> <1130719826.32101.2.camel@mindpipe> <43664057.3000205@vt.edu> <1131218656.13627.12.camel@mindpipe>
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="------------040807080800060904020301"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1131218656.13627.12.camel@mindpipe>
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
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, James Courtier-Dutton <James@superbug.co.uk>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040807080800060904020301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



Lee Revell wrote:

>On Mon, 2005-10-31 at 11:03 -0500, Rick Wright wrote:
>  
>
>>>>These machines are basically clones and the Audigy2 card is in the
>>>>same PCI slot in both machines.
>>>>
>>>>    
>>>>        
>>>>
>>>Sorry I should have been more specific.  I need 
>>>"lspci -vn | grep -A1 0401" output for both machines.
>>>
>>>  
>>>      
>>>
>>Ok, here they are.
>>
>>Rick
>>plain text document attachment (lspci-output-no-side-channels.txt)
>>00:0b.0 Class 0401: 1102:0004 (rev 04)
>>	Subsystem: 1102:1005
>>plain text document attachment
>>(lspci-output-side-channels-working.txt)
>>00:0b.0 Class 0401: 1102:0004 (rev 04)
>>	Subsystem: 1102:2001
>>    
>>
>
>The driver currently detects the card with the non-working side channels
>as an Audigy 2 EX.  Is this correct?  Do you know whether all Audigy2 EX
>cards have side channels?
>
>Anyway, here's a patch to enable the side channels.
>
>Enable side surround channels for Audigy2 EX.  Tested by Rick Wright
><riwright@vt.edu>.
>
>Signed-Off-By: Lee Revell <rlrevell@joe-job.com>
>
>--- alsa-kernel/pci/emu10k1/emu10k1_main.c~	2005-10-28 17:20:22.000000000 -0400
>+++ alsa-kernel/pci/emu10k1/emu10k1_main.c	2005-11-05 14:22:34.000000000 -0500
>@@ -680,6 +680,7 @@
> 	 .emu10k2_chip = 1,
> 	 .ca0102_chip = 1,
> 	 .ca0151_chip = 1,
>+	 .spk71 = 1,
> 	 .spdif_bug = 1} ,
> 	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x10021102,
> 	 .driver = "Audigy2", .name = "Audigy 2 Platinum [SB0240P]", 
>
>
>
>  
>
Lee,

I've given you some incorrect information about the card with the 
non-working side channels.  My appologies.  However, there is still 
value to all of this.

The older card is an Audigy2 Platinum eX (model: SB0280) 
(http://www.digit-life.com/articles2/creative-audigy2-platinum-ex/index.html), 
not an Audigy2 Platinum Pro ZS (model: SB0360) as I previously 
reported.  This card appearently was the predecessor to the Platinum Pro 
ZS, complete with identical external chassis, etc. - leading to my 
incorrect model assumption.  This makes sense considering I knew this 
was a dated card, but top-of-the-line when purchased.  I appologize for 
not checking explicitly before reporting the issue.  There is an article 
on the ZS release with an excellent comparison photo of my 2 cards here: 
http://www.digit-life.com/articles2/creative-audigy2-zs/

That said, this Platinum eX card is a 6.1 channel card where there is a 
"center rear" channel (mono) in addition to the typical 5.1 channels.  
This "standard" was an intermediate step to 7.1, as you probably know.  
So now my reported "problem" has shifted from "why can't I see my PCM 
Side channel volume controls?" to "why doesn't the PCM Center Rear 
volume slider appear?"


I've just tested your patch, here are the results:

The new (1.0.10rc2) patched alsa-driver detects this card as an "Audigy 
2 EX [1005]".  There are still no PCM Side channel sliders (though now 
we know the card doesn't support these), which suprises me since that 
was the patch, no?  At any rate, the patch should be changed to remove 
7.1 and add 6.1, assuming there is support for this.  I would expect a 
"PCM Center Rear" volume slider to appear and be functional for this card.

FYI, The ZS Platinum Pro card is detected as an "Audigy 2 ZS [2001]" in 
my other identical machine with the latest FC4 ALSA (1.0.9rf) installed 
via yum/rpm.  Looking at the source file your patch was applied to, I 
didn't see an entry specific to this card model.  If there should be a 
configuration entry specific to the ZS Platinum Pro (SB0360), I'd be 
happy to help by providing all necessary info/test results.  Please let 
me know.  This also applies for the Platinum EX model (SB0280).

Observation:  with the FC4 ALSA version, I noticed that upon initial 
boot with both of these cards (i.e. both machines), there would usually 
be a low level noise (hiss) coming from all output channels.  The fix 
for this was to unplug/replug the firewire-type connector to the 
external chassis and then the noise was gone - 100% success rate.  I'm 
curious as to whether this was a known issue in my dated version of ALSA 
and if this has been fixed.  It seemed to me like a problem with the 
first initialization, but the unplug/replug forced a successful 
initialization?  I've only rebooted once since upgrading my alsa-driver 
with your patch and I haven't noticed the low level hiss.

Lastly, there is one remaining annoyance common to both of these cards 
where the L/R output volume controls (sliders) are backwards wrt a 
standard 1/8" stereo-to-RCA's (red/white) cable.  I reported this 
behavior to the alsa-bugtracker back in Feb 
(https://bugtrack.alsa-project.org/alsa-bug/view.php?id=904), though now 
it appears I had the card model wrong...  This bug report is still 
open.  This behavior persists (on at least the EX card) through the 
latest version (1.0.10rc2) downloaded, patched, and tested today.  I 
know this is minor and my fix has been simply plugging the RCA cables in 
backwards, but shouldn't this work properly?  Until this testing today, 
I've been using a stock FC4 system/ALSA install, but if this is a 
configuration error on my end would you please advise?


Sorry for the long mail, but I wanted to cover everything I've noticed 
and be thorough.  I look forward to your input.

Rick

--------------040807080800060904020301
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
<br>
<br>
Lee Revell wrote:
<blockquote cite="mid1131218656.13627.12.camel@mindpipe" type="cite">
  <pre wrap="">On Mon, 2005-10-31 at 11:03 -0500, Rick Wright wrote:
  </pre>
  <blockquote type="cite">
    <blockquote type="cite">
      <blockquote type="cite">
        <pre wrap="">These machines are basically clones and the Audigy2 card is in the
same PCI slot in both machines.

    
        </pre>
      </blockquote>
      <pre wrap="">Sorry I should have been more specific.  I need 
"lspci -vn | grep -A1 0401" output for both machines.

  
      </pre>
    </blockquote>
    <pre wrap="">Ok, here they are.

Rick
plain text document attachment (lspci-output-no-side-channels.txt)
00:0b.0 Class 0401: 1102:0004 (rev 04)
	Subsystem: 1102:1005
plain text document attachment
(lspci-output-side-channels-working.txt)
00:0b.0 Class 0401: 1102:0004 (rev 04)
	Subsystem: 1102:2001
    </pre>
  </blockquote>
  <pre wrap=""><!---->
The driver currently detects the card with the non-working side channels
as an Audigy 2 EX.  Is this correct?  Do you know whether all Audigy2 EX
cards have side channels?

Anyway, here's a patch to enable the side channels.

Enable side surround channels for Audigy2 EX.  Tested by Rick Wright
<a class="moz-txt-link-rfc2396E" href="mailto:riwright@vt.edu">&lt;riwright@vt.edu&gt;</a>.

Signed-Off-By: Lee Revell <a class="moz-txt-link-rfc2396E" href="mailto:rlrevell@joe-job.com">&lt;rlrevell@joe-job.com&gt;</a>

--- alsa-kernel/pci/emu10k1/emu10k1_main.c~	2005-10-28 17:20:22.000000000 -0400
+++ alsa-kernel/pci/emu10k1/emu10k1_main.c	2005-11-05 14:22:34.000000000 -0500
@@ -680,6 +680,7 @@
 	 .emu10k2_chip = 1,
 	 .ca0102_chip = 1,
 	 .ca0151_chip = 1,
+	 .spk71 = 1,
 	 .spdif_bug = 1} ,
 	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x10021102,
 	 .driver = "Audigy2", .name = "Audigy 2 Platinum [SB0240P]", 



  </pre>
</blockquote>
Lee,<br>
<br>
I've given you some incorrect information about the card with the
non-working side channels.&nbsp; My appologies.&nbsp; However, there is still
value to all of this.<br>
<br>
The older card is an Audigy2 Platinum eX (model: SB0280)
(<a class="moz-txt-link-freetext" href="http://www.digit-life.com/articles2/creative-audigy2-platinum-ex/index.html">http://www.digit-life.com/articles2/creative-audigy2-platinum-ex/index.html</a>),
not an Audigy2 Platinum Pro ZS (model: SB0360) as I previously
reported.&nbsp; This card appearently was the predecessor to the Platinum
Pro ZS,
complete with identical external chassis, etc. - leading to my
incorrect model assumption.&nbsp; This makes sense considering I knew this
was a dated card, but top-of-the-line when purchased.&nbsp; I appologize for
not checking explicitly before reporting the issue.&nbsp; There is an
article on the ZS release with an excellent comparison photo of my 2
cards here:
<a class="moz-txt-link-freetext" href="http://www.digit-life.com/articles2/creative-audigy2-zs/">http://www.digit-life.com/articles2/creative-audigy2-zs/</a><br>
<br>
That said, this Platinum eX card is a 6.1 channel card where there is a
"center rear" channel (mono) in addition to the typical 5.1 channels.&nbsp;
This "standard" was an intermediate step to 7.1, as you probably know.&nbsp;
So now my reported "problem" has shifted from "why can't I see my PCM
Side channel volume controls?" to "why doesn't the PCM Center Rear
volume slider appear?"<br>
<br>
<br>
I've just tested your patch, here are the results:<br>
<br>
The new (1.0.10rc2) patched alsa-driver detects this card as an "Audigy
2 EX [1005]".&nbsp; There are still no PCM Side channel sliders (though now
we know the card doesn't support these), which suprises me since that
was the patch, no?&nbsp; At any rate, the patch should be changed to remove
7.1 and add 6.1, assuming there is support for this.&nbsp; I would expect a
"PCM Center Rear" volume slider to appear and be functional for this
card.<br>
<br>
FYI, The ZS Platinum Pro card is detected as an "Audigy 2 ZS [2001]" in
my other identical machine with the latest FC4 ALSA (1.0.9rf) installed
via yum/rpm.&nbsp; Looking at the source file your patch was applied to, I
didn't see an entry specific to this card model.&nbsp; If there should be a
configuration entry specific to the ZS Platinum Pro (SB0360), I'd be
happy to help by providing all necessary info/test results.&nbsp; Please let
me know.&nbsp; This also applies for the Platinum EX model (SB0280).<br>
<br>
Observation:&nbsp; with the FC4 ALSA version, I noticed that upon initial
boot with both of these cards (i.e. both machines), there would usually
be a low level noise (hiss) coming from all output channels.&nbsp; The fix
for this was to unplug/replug the firewire-type connector to the
external chassis and then the noise was gone - 100% success rate.&nbsp; I'm
curious as to whether this was a known issue in my dated version of
ALSA and if this has been fixed.&nbsp; It seemed to me like a problem with
the first initialization, but the unplug/replug forced a successful
initialization?&nbsp; I've only rebooted once since
upgrading my alsa-driver with your patch and I haven't noticed the low
level hiss.<br>
<br>
Lastly, there is one remaining annoyance common to both of these cards
where the L/R output volume controls (sliders) are backwards wrt a
standard 1/8" stereo-to-RCA's (red/white) cable.&nbsp; I reported this
behavior to the alsa-bugtracker back in Feb
(<a class="moz-txt-link-freetext" href="https://bugtrack.alsa-project.org/alsa-bug/view.php?id=904">https://bugtrack.alsa-project.org/alsa-bug/view.php?id=904</a>), though
now it appears I had the card model wrong...&nbsp; This bug report is still
open.&nbsp; This behavior persists
(on at least the EX card) through the latest version (1.0.10rc2)
downloaded, patched, and tested today.&nbsp; I know this is minor and my fix
has been simply plugging the RCA cables in backwards, but shouldn't
this work properly?&nbsp; Until this testing today, I've been using a stock
FC4 system/ALSA install, but if this is a configuration error on my end
would you please advise?<br>
<br>
<br>
Sorry for the long mail, but I wanted to cover everything I've noticed
and be thorough.&nbsp; I look forward to your input.<br>
<br>
Rick<br>
</body>
</html>

--------------040807080800060904020301--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
