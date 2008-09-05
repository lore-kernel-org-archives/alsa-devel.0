From: "Wei Ni" <wni@nvidia.com>
Subject: RE: [alsa-devel] [PATCH] add the nvidia HDMI codec driver for	MCP77/79
Date: Fri, 5 Sep 2008 16:28:15 +0800
Message-ID: <15F501D1A78BD343BE8F4D8DB854566B32241EB0@hkemmail01.nvidia.com>
References: <200809031558156739794@gmail.com><s5hhc8xpq6z.wl%tiwai@suse.de><15F501D1A78BD343BE8F4D8DB854566B31F8F744@hkemmail01.nvidia.com><s5h4p4xph6x.wl%tiwai@suse.de><48BE7EE4.8020800@insite.cz> <s5habeoo0ia.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755216AbYIEI2o@vger.kernel.org>
In-Reply-To: <s5habeoo0ia.wl%tiwai@suse.de>
Content-class: urn:content-classes:message
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, Pavel Hofman <pavel.hofman@insite.cz>
Cc: Peer Chen <pchen@nvidia.com>, alsa-devel <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>, akpm <akpm@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

Thanks for your reply, I will generate the pach based on the latest
sound git tree.

Wei

-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de] 
Sent: Thursday, September 04, 2008 3:04 PM
To: Pavel Hofman
Cc: Wei Ni; Peer Chen; alsa-devel; linux-kernel; akpm
Subject: Re: [alsa-devel] [PATCH] add the nvidia HDMI codec driver for
MCP77/79

At Wed, 03 Sep 2008 14:11:16 +0200,
Pavel Hofman wrote:
> 
> 
> >> ......
> >> According to these codes, It only can get the realtek codec and can
not
> >> get hdmi codec, if just change azx_max_codecs[AZX_DRIVER_NVIDIA] to
4
> >> I think if remove "if (!audio_codecs)", it will be better, and I
only
> >> need to chang azx_max_codecs[AZX_DRIVER_NVIDIA] to 4
> > 
> > Well, the check is there for a good reason.
> > 
> > There are many machines with broken BIOS reporting the 4th slot
> > available although it isn't actually.  It's a workaround to skip
such
> > a bogus information.  So, it cannot be changed so easily.
> > 
> > We need to sort out this in a better way...  Oh well.
> 
> 
> Please, please, put the above information as a comment to the
respective 
> place. These "hacks" should be commented :)

I changed that code yesterday with a little bit more comment.

Wei, Peer, could you regenerate the patch based on the latest sound
git tree?

    git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git

or use the snapshot tarball from

    ftp://ftp.kernel.org/pub/linux/tiwai/snapshot/

This already contains the fix for the 4th slot probe on Nvidia
chipset.


thanks,

Takashi
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
