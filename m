From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [RFC PATCH 1/2] ALSA: hda - Fix "PCM" name being
 used on one DAC when there are two DACs
Date: Mon, 20 Oct 2014 12:15:37 +0200
Message-ID: <5444E0C9.70200@canonical.com>
References: <1413466426-2672-1-git-send-email-david.henningsson@canonical.com>	<CAN8cciZAteQAaG9GAxwLWyF6u5xH_fGtRDOTq5j+4LNoj_d_jA@mail.gmail.com>	<543FDFDE.7040800@canonical.com>	<CAN8cciaUo7BOxSMBtiysYi9MsW=ZAWn0s3tHTc5-YmpWWvEJNg@mail.gmail.com>	<s5hlhodteq7.wl-tiwai@suse.de>	<CAN8ccib4fhvvtYW7sjDZXA9QETgOTL+wA=u6iSv0yRHtwWPfwQ@mail.gmail.com>	<5444ABDA.7070207@canonical.com>	<CAN8cciYCSd8QqHNZ=7ip_-YnG1ru9jJ3rjW8S_YjyrhRLGBFzA@mail.gmail.com>	<5444DD02.1070608@canonical.com>
 <s5hiojf3vqb.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030602010502050007090506"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id C04942605A2
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 12:15:37 +0200 (CEST)
In-Reply-To: <s5hiojf3vqb.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Raymond Yau <superquad.vortex2@gmail.com>, alsa-devel@alsa-project.org, ruedi@battle-eggs.de
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030602010502050007090506
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit



On 2014-10-20 12:02, Takashi Iwai wrote:
> At Mon, 20 Oct 2014 11:59:30 +0200,
> David Henningsson wrote:
>>
>>
>>
>> On 2014-10-20 11:55, Raymond Yau wrote:
>>>
>>>   >>
>>>   >>
>>>   >>  > >
>>>   >>  > > >> >
>>>   >>  > > >> > In the scenario where there is one "Line Out", one "Speaker"
>>>   >> and one
>>>   >>  > > >> > "Headphone", and there are only two DACs, two outputs will
>>>   >> share a DAC.
>>>   >>  > > >> > Currently any mixer on such a DAC will get the "PCM" name,
>>>   >> which is
>>>   >>  > > >> > misleading. Instead use "Headphone+LO" or "Speaker+LO" to
>>> better
>>>   >>  > > >> > specify what the volume actually controls.
>>>   >>  > > >>
>>>   >>  > > >> Are there any examples ?
>>>   >>  > > >>
>>>   >>  > > >
>>>   >>  > > > I used "hda-emu
>>>   >>  > > codecs/canonical/alc3226-dell-precision-m2800-ccert-201404-14986 -i
>>>   >> 1" when
>>>   >>  > > developing the patches.
>>>   >>  > > >
>>>   >>  > > > I don't have any hardware available myself that exposes this
>>>   >> behavior,
>>>   >>  > > but I can maybe fake one with hdajackretask, if that counts...
>>>   >>  > > >
>>>   >>  > >
>>>   >>  > > How about adding these names to slaves of virtual master
>>>   >> volume/switch ?
>>>   >>  > >
>>>   >>  > > hdajackretask won't help if the topology of the codecs are
>>> different
>>>   >>  > >
>>>   >>  > > Seem the badness still prevent the driver to support surround
>>> 5.1 with
>>>   >>  > > three rear panel jacks, internal speaker and front panel
>>> headphone for
>>>   >>  > > Thinkcenter A58 using alc662
>>>   >>  > >
>>>   >>  > >
>>>   >>
>>> https://www.mail-archive.com/alsa-user@lists.sourceforge.net/msg29203.html
>>>   >>  > >
>>>   >>  > > Why 3stack desktops with 6 channels codecs not using
>>>   >> "Headphone+LO"  or
>>>   >>  > > "Speaker+LO" ?
>>>   >>  >
>>>   >>  > The problem is just the lack of DACs, so it cannot cover all three
>>>   >>  > outputs, no matter how the pins are chosen.  That is, it's no 6
>>>   >>  > channels at all but 4 channels at most.
>>>   >>  >
>>>   >>  >
>>>   >>
>>>   >> http://shop.lenovo.com/us/en/desktops/thinkcentre/a-series/a58/
>>>   >>
>>>   >> The technical specification of a58
>>>   >>
>>>   >> 2 pin internal speaker connector
>>>   >> Alc662 5.1
>>>   >>
>>>   >> https://bbs.archlinux.org/viewtopic.php?id=156433
>>>   >>
>>>   >> Seem windows support surround 5.1
>>>   >
>>>   >
>>>   > Raymond, there can certainly be cases which this patch does not cover
>>> - after all, it's mostly a band aid given the lack of topology
>>> information - but do you see cases where this patch actually causes a
>>> *regression*? If so, could you point me to alsa-info for the machine
>>> where this patch causes a regression?
>>>   >
>>>
>>> www.realtek.com.tw/products/productsView.aspx?Langid=1&PNid=24&PFid=27&Level=5&Conn=4
>>> <http://www.realtek.com.tw/products/productsView.aspx?Langid=1&PNid=24&PFid=27&Level=5&Conn=4>
>>>
>>> I expect those desktop with 2+2 HD Audio codec support independent headphone
>>>
>>> This mean the driver should not create "Lineout+HP" Playback volume
>>>
>>> Line out and headphone cannot share same DAC
>>
>> I doubt that, but if they cannot share the same DAC, that needs to be
>> addressed in a separate patch. This patch just deals with the naming,
>> given that the previous logic has determined that headphone and Line out
>> should share the same DAC.
>>
>> Takashi, are you planning to apply this patch? Or are you looking for
>> more testing first?
>
> I'll test a bit more.  I have a machine that is affected by this
> issue, so I can test on a real machine.
>
> How about the changes in PA side, BTW?  Is it ready?

I will cook up a quick patch once you have merged. But there will not be 
any big regression: we already control the vmaster, which in turn 
controls the hw volume of the DAC. So I will expect things to just work, 
assume the new controls will be initialized correctly. I'm attaching an 
(untested) alsa-utils patch for that.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic

--------------030602010502050007090506
Content-Type: text/x-patch;
 name="0001-alsactl-init-Add-init-of-Headphone-LO-and-Speaker-LO.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-alsactl-init-Add-init-of-Headphone-LO-and-Speaker-LO.pa";
 filename*1="tch"

>From 002353dd6cba2622da748e91f9d8848ed2dc68d3 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Mon, 20 Oct 2014 12:12:57 +0200
Subject: [PATCH] alsactl init: Add init of "Headphone+LO" and "Speaker+LO"
 controls

These two were recently added to the HDA driver, so make sure they
are initialized correctly.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 alsactl/init/default | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/alsactl/init/default b/alsactl/init/default
index 5fb0113..fe0511a 100644
--- a/alsactl/init/default
+++ b/alsactl/init/default
@@ -104,6 +104,16 @@ CTL{name}="Headphone Playback Switch",CTL{index}="1",CTL{do_search}=="1", \
   CTL{values}="on"
 
 CTL{reset}="mixer"
+CTL{name}="Headphone+LO Playback Volume",PROGRAM!="__ctl_search",GOTO=""
+# if master volume control is present, turn headphone+LO volume to max
+ENV{has_pmaster_vol}=="true",CTL{write}=="0dB",GOTO=""
+ENV{has_pmaster_vol}=="true",CTL{write}=="100%",GOTO=""
+CTL{write}!="$env{pvolume}",CTL{values}="$env{ppercent}"
+LABEL=""
+CTL{name}="Headphone+LO Playback Switch",CTL{do_search}=="1", \
+  CTL{values}="on"
+
+CTL{reset}="mixer"
 CTL{name}="Speaker Playback Volume",PROGRAM!="__ctl_search",GOTO=""
 # if master volume control is present, turn speaker volume to max
 ENV{has_pmaster_vol}=="true",CTL{write}=="0dB",GOTO=""
@@ -114,6 +124,16 @@ CTL{name}="Speaker Playback Switch",CTL{do_search}=="1", \
   CTL{values}="on"
 
 CTL{reset}="mixer"
+CTL{name}="Speaker+LO Playback Volume",PROGRAM!="__ctl_search",GOTO=""
+# if master volume control is present, turn speaker+LO volume to max
+ENV{has_pmaster_vol}=="true",CTL{write}=="0dB",GOTO=""
+ENV{has_pmaster_vol}=="true",CTL{write}=="100%",GOTO=""
+CTL{write}!="$env{pvolume}",CTL{values}="$env{ppercent}"
+LABEL=""
+CTL{name}="Speaker+LO Playback Switch",CTL{do_search}=="1", \
+  CTL{values}="on"
+
+CTL{reset}="mixer"
 CTL{name}="Front Speaker Playback Volume",PROGRAM!="__ctl_search",GOTO=""
 # if master volume control is present, turn speaker volume to max
 ENV{has_pmaster_vol}=="true",CTL{write}=="0dB",GOTO=""
-- 
1.9.1


--------------030602010502050007090506
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030602010502050007090506--
