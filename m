From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: link between HDMI ELD and PCM devices
Date: Tue, 20 Sep 2011 19:58:30 -0500
Message-ID: <1316566711.3872.24.camel@pbossart-Dell-N7010>
References: <1316560363.3872.14.camel@pbossart-Dell-N7010>
	<74CDBE0F657A3D45AFBB94109FB122FF04B73217D2@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 8624524BBC
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Sep 2011 02:58:54 +0200 (CEST)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF04B73217D2@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "; Takashi Iwai" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "; Wu Fengguang" <fengguang.wu@intel.com>
List-Id: alsa-devel@alsa-project.org


> > There is some existing code such as pin_nid_to_pin_index() in
> > patch_hdmi.c, but I can't figure out what this pin_idx is, and how to
> > find the related PCM device number.
> > Any suggestions?
> 
> That function simply returns the index into the array spec->pins[] that
> refers to that pin NID.
> 
> Judging by hinfo_to_pin_index() (e.g. used near the start ofhdmi_pcm_open),
> that same index is valid  for spec->pcm_rec[] too, which I assume will
> give you access to what you want, possibly through the .stream[0] field.

Looks like the device number is assigned in hda_codec.c and there's no
hooks to create the ELD control then...
Instead of creating a PCM_IFACE control, it's probably simpler to create
a MIXER control in the build_pcms routines, using the same name for the
control and the device, eg:

>amixer -c0 controls
numid=1,iface=MIXER,name='ELD HDMI 0'
>aplay -l
card 0: Intel [HDA Intel], device 3: HDMI 0 [HDMI 0]

That looks simple enough for apps to figure out which ELD control to
use? Feedback welcome.
-Pierre
