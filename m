From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH] ALSA: hda: Disable 4/6 channels on some
 NVIDIA	GPUs.
Date: Wed, 12 Jan 2011 08:42:22 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0310568276@HQMAIL01.nvidia.com>
References: <1294676371-1401-1-git-send-email-ndaga@nvidia.com>
	<4D2C8F59.4040507@iki.fi>
	<74CDBE0F657A3D45AFBB94109FB122FF03105680D9@HQMAIL01.nvidia.com>
	<4D2D29FD.6040008@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id AD205245EE
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2011 17:42:36 +0100 (CET)
In-Reply-To: <4D2D29FD.6040008@iki.fi>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Anssi Hannula <anssi.hannula@iki.fi>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Nitin Daga <ndaga@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Anssi Hannula wrote:
> 
> On 11.01.2011 19:41, Stephen Warren wrote:
> > Anssi Hannula wrote:
> >> On 10.01.2011 18:19, Nitin Daga wrote:
> >>> Added hardware constraint in patch_hdmi.c to disable
> >>> channels 4/6 which are not supported by some older
> >>> NVIDIA GPUs.
> >>
> >> And 3/5/7, which do not seem to work either with my 0x0007.
> >
> > Are 3/5/7 channels supported by any vendor?
>...
> 
> Actually, I just tested and just transmitting 3-channel data with extra
> 4th dummy channel while setting the Audio InfoFrame fields to indicate a
> 3 channel stream makes it work.
> 
> So it would seem (to me) like the best approach would be:
> 1. Add a hw_constraint to prevent odd channel counts (easy)

That seems enough to me. I'm not sure that 3/5/7 channels are a format
that there is much use-case for?

> 2. Provide some way for alsa plug (and the user application) to indicate
>    the "actual/original" channel count/layout without dummy channels,
>    so that the infoframe can be set correctly.
>    This is harder, and I guess should probably be implemented so that
>    the channel remapping issue on older nvidia hw will be fixed as well.

Hmm. That sounds kinda complex. If constraints prevent the application
from using e.g. 3-channel, then implementing (2) means the plugin would
have to also modify the constraints to re-allow 3-channel, so the
application could actually use it, no?

-- 
nvpublic
