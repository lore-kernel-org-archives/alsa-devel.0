From: "Wei Ni" <wni@nvidia.com>
Subject: Re: Nvidia hdmi problems
Date: Wed, 22 Oct 2008 10:42:01 +0800
Message-ID: <15F501D1A78BD343BE8F4D8DB854566B3563A208@hkemmail01.nvidia.com>
References: <9b2db90b0810200735g61cad43dr538c3afc495398ec@mail.gmail.com><s5hskqq8lh7.wl%tiwai@suse.de><9b2db90b0810210030g6a800618q9cab6ac99809d8ab@mail.gmail.com><s5hr66a8kr7.wl%tiwai@suse.de><9b2db90b0810210039y223adcd7nd94053274b6eae18@mail.gmail.com><s5hod1e8jz8.wl%tiwai@suse.de><9b2db90b0810210052o6b2720f4h37a67e3cc0eeae49@mail.gmail.com><s5hiqrm8j2b.wl%tiwai@suse.de><9b2db90b0810210428q2dd16d94va85a0cb5594ec15d@mail.gmail.com><s5hskqq15px.wl%tiwai@suse.de><9b2db90b0810210546i67d54038rcbfe0f356109c545@mail.gmail.com>
	<s5hprlu15bv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.112.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 73F1424381
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Oct 2008 04:42:29 +0200 (CEST)
In-Reply-To: <s5hprlu15bv.wl%tiwai@suse.de>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Nir Tzachar <nir.tzachar@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi, Takshi
We have no official plan to support this nforce 630i HDMI audio in linux
now, 
and we didn't do any test on it yet. So we can't provide the official
patch for this addition.

I think if someone interest in it and do some test, he can generate
patch and submit it.

Thanks
Wei

-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de] 
Sent: Tuesday, October 21, 2008 8:49 PM
To: Nir Tzachar
Cc: Wei Ni; alsa-devel@alsa-project.org
Subject: Re: Nvidia hdmi problems

At Tue, 21 Oct 2008 14:46:19 +0200,
Nir Tzachar wrote:
> 
> Hello
> 
> On Tue, Oct 21, 2008 at 2:40 PM, Takashi Iwai <tiwai@suse.de> wrote:
> > At Tue, 21 Oct 2008 13:28:25 +0200,
> > Nir Tzachar wrote:
> >>
> >> Hello.
> >>
> >> Updated to the latest linus-git tree, and pulled in the sound-2.6
tree.
> >>
> >> The good news are that by following Wei's instructions (adding the
> >> device id in patch_nvhdmi.c), I managed to get audio through the
hdmi.
> >> Goodie.
> >
> > Could you give details?
> >
> 
> I just did this:
> 
> > You can try to add device id (0x10de8001)  to snd_hda_preset_nvhdmi
> > table in patch_nvhdmi.c.
> > You also need to install latest display driver.
> 
> and told alsa to play through the third pcm device.

Thanks.  So it's just a missing entry.

Wei, do you have a patch for this addition?


> >> The bad news are that mplayer misbehaves and will get stuck every
time
> >> I try to change the volume. However, this does not happen in vlc.
Any
> >> ideas?
> >
> > Well, we need to sort out where the problem comes from.
> > Try the vanilla Linus tree without sound-2.6 whether the problem
> > persists.
> 
> I'll try to remove the sound-2.6 tree and report.

That'll be helpful.  Thanks.


Takashi
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
