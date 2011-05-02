From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH 08/10] ALSA: hda - Add support for Line-Out
 automute to Realtek auto-parser
Date: Mon, 2 May 2011 08:56:07 +0800
Message-ID: <BANLkTin2pTvxskpUTAN8EVvhmsNB95EpaQ@mail.gmail.com>
References: <1304097516-7258-1-git-send-email-tiwai@suse.de>
	<1304097516-7258-9-git-send-email-tiwai@suse.de>
	<4DBBB1CA.8020508@canonical.com> <s5hliysavi0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id A377F1037E3
	for <alsa-devel@alsa-project.org>;
	Mon,  2 May 2011 02:56:08 +0200 (CEST)
Received: by fxm5 with SMTP id 5so3950454fxm.38
	for <alsa-devel@alsa-project.org>; Sun, 01 May 2011 17:56:07 -0700 (PDT)
In-Reply-To: <s5hliysavi0.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/4/30 Takashi Iwai <tiwai@suse.de>

> At Sat, 30 Apr 2011 08:52:58 +0200,
> David Henningsson wrote:
> >
> > On 2011-04-29 19:18, Takashi Iwai wrote:
> > > By popular demands, I add the functionality to mute / unmute the
> > > line-out jacks per the headphone plug / unplug.  For achieving this
> > > and keeping the compatibility with the old behavior, the new mixer
> > > enum "Auto-Mute Mode" is added.  With this, user can control the
> > > auto-mute behavior either disabled, speaker-only or lineout+speaker.
> >
> > Hi Takashi,
> >
> > Great to see these improvements! I have a question about this patch:
> >
> > There are three ways we can auto-mute:
> >
> > Headphones might mute Internal Speakers.
> > Headphones might mute Line out.
>

Why just only HPs just mute one line out ?

as all HDA codec except ad1986 use copy-front mode, stereo are copy to all
output jacks at rear panel for a motherboard with a 6 , 8 or 10 channel HDA
codec





> > Line out might mute Internal Speakers.
> >
> > Are we considering the third option here or is that still unsupported?
>
> Yes, it'll behave so.  Now we have "Auto-Mute Mode" enum control, and
> it provides "Disable", "Speaker only" and "Line-Out+Speaker" choice in
> the case of LO+HP+SPK case.  When only HP+LO, LO+SPK  or HP+SPK are
> present, this enum gives only "Disable" and "Enable" choice.
>

For desktop if the computer chassis does not has a HDA Front Audio panel,
you need to set Front Audio Panel from [HD] to [AC97] in BIOS setup

The BIOS set the Jack Detect Override bit to 1 to indicate the jack has no
presence detect capability


7.3.3.31 Configuration Default

Misc[3:0] is a bit field used to indicate other information about the jack.
Currently, only bit 0 is defined. If bit 0 is set, it indicates that the
jack has no presence detect capability, so even if a Pin Complex indicates
that the codec hardware supports the presence detect functionality on the
jack, the external circuitry is not capable of supporting the functionality.
The bit definitions for the Misc field are in Table 106.



>
> > Also, it might be slightly confusing for the end-user to have options
> > that are irrelevant, e g if there are no internal speakers (or line-out
> > for that matter), that option will still show up. Right?
>
> If there is only one output type, this enum won't appear.
>

Do you mean there will be no "auto mute" control if the desktop has no HD
compilant front audio panel ?


> I guess this should cover most of use-cases, and flexible enough for
> covering both old and new behavior.
>
>
> thanks,
>
> Takashi
>
