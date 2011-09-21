From: "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>
Subject: Re: link between HDMI ELD and PCM devices
Date: Wed, 21 Sep 2011 09:32:16 -0500
Message-ID: <36390.6748396859$1316615558@news.gmane.org>
References: <1316560363.3872.14.camel@pbossart-Dell-N7010>	<74CDBE0F657A3D45AFBB94109FB122FF04B73217D2@HQMAIL01.nvidia.com>	<1316566711.3872.24.camel@pbossart-Dell-N7010>	<4E7987BF.8000206@canonical.com>	<000001cc7861$2d7895e0$8869c1a0$@bossart@linux.intel.com>
	<4E79ECBA.3060705@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id C92431038DB
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Sep 2011 16:32:20 +0200 (CEST)
In-Reply-To: <4E79ECBA.3060705@canonical.com>
Content-Language: en-us
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'David Henningsson' <david.henningsson@canonical.com>
Cc: 'Takashi Iwai' <tiwai@suse.de>, alsa-devel@alsa-project.org, "Wu,
	Fengguang" <fengguang.wu@intel.com>, 'Stephen Warren' <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

> > No, the code doesn't use a constant,
> 
> It's actually four constants, please see generic_hdmi_pcm_names in
> patch_hdmi.c. But my point is that this restarts from 0 on every codec.
> On a 3.0 based kernel, here's part of my aplay -l output:
> 
> card 3: NVidia [HDA NVidia], device 3: HDMI 0 [HDMI 0]
>    Subdevices: 1/1
>    Subdevice #0: subdevice #0
> card 3: NVidia [HDA NVidia], device 7: HDMI 0 [HDMI 0]
>    Subdevices: 1/1
>    Subdevice #0: subdevice #0

Thanks for this feedback. I was obviously trying to build on broken code...
Will try to see if I can add the control in build_controls as you suggested.
-Pierre
