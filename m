From: Olivier Langlois <olivier@trillion01.com>
Subject: Re: [PATCH v3 0/5] ALSA: hda - hdmi: ATI/AMD
 multi-channel and HBR support
Date: Tue, 12 Nov 2013 01:35:11 -0500
Message-ID: <1384238111.21913.12.camel@Wailaba2>
References: <1382638238-25055-1-git-send-email-anssi.hannula@iki.fi>
 <5269665E.9050102@iki.fi> <1383887323.6455.37.camel@Wailaba2>
 <527CBC7F.4000805@iki.fi> <1383934622.22680.2.camel@Wailaba2>
 <1383946119.1089.4.camel@Wailaba2> <527D5FB4.6090603@iki.fi>
 <1384062124.29274.8.camel@Wailaba2> <527F2126.50006@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from oproxy17-pub.mail.unifiedlayer.com
 (oproxy17-pub.mail.unifiedlayer.com [74.220.201.171])
 by alsa0.perex.cz (Postfix) with SMTP id 022C0260840
 for <alsa-devel@alsa-project.org>; Tue, 12 Nov 2013 07:35:14 +0100 (CET)
In-Reply-To: <527F2126.50006@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anssi Hannula <anssi.hannula@iki.fi>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Peter =?ISO-8859-1?Q?Fr=FChberger?= <fritsch@xbmc.org>
List-Id: alsa-devel@alsa-project.org

Anssi,

With your speaker-test patch (v1), I have been able to make sure that I
could use the 8 channels with my AMD card.

for the ramp up/down testing. I have the same result than with v2 of
your patch.

eld#0.0 file content is identical as well.

DTS-HD and Dolby True-HD are sent correctly and recognized by the
receiver by using the files from:

http://phoronix.com/forums/showthread.php?27348-TrueHD-DTS-HD-E-AC3-Over-HDMI-On-Linux

with the command:s

aplay -Dhdmi:CARD=HDMI,DEV=0,AES0=6 -c8  -r192000 -f s16_le thd.spdif
aplay -Dhdmi:CARD=HDMI,DEV=0,AES0=6 -c8  -r192000 -f s16_le dts.spdif



> >>
> >>
> > Sure, here is the output:
> > 
> > [   78.384821] ALSA sound/pci/hda/patch_hdmi.c:1167 HDMI hot plug event:
> > Codec=0 Pin=3 Device=0 Inactive=0 Presence_Detect=0 ELD_Valid=1
> > [   78.384834] ALSA sound/pci/hda/patch_hdmi.c:1512 HDMI status: Codec=0
> > Pin=3 Presence_Detect=1 ELD_Valid=1
> > [  128.437676] ALSA sound/pci/hda/patch_hdmi.c:678 HDMI: select CA 0x13
> > for 8-channel allocation:  FL/FR LFE FC RL/RR RLC/RRC
> > [  128.437797] CA XX 19 => 8
> > [  128.437799] XX hdmi_map 00
> > [  128.437801] XX hdmi_map 11
> > [  128.437802] XX hdmi_map 26
> > [  128.437804] XX hdmi_map 37
> > [  128.437806] XX hdmi_map 43
> > [  128.437807] XX hdmi_map 52
> > [  128.437809] XX hdmi_map 64
> > [  128.437810] XX hdmi_map 75
> > [  128.437957] ALSA sound/pci/hda/patch_hdmi.c:3108
> > atihdmi_pin_hbr_setup: NID=0x3, hbr-ctl=0x1
> > 
> > This is looking good. Maybe this is coming from how the channel mapping
> > is communicated to speaker-test through ALSA API but I don't know much
> > about that.
> > 
> > I'll try to understand as well on my side what is going on.
> 
> Hmm seems I can reproduce this issue just fine on my side now on
> non-AMD, so I'm going to look into this myself as well. Looks a bit like
> a speaker-test bug to me (since the printed channel numbers are
> duplicated, and amixer shows proper chmap), though if that is the case I
> wonder why I didn't see this before... I'll take a look.
> 
