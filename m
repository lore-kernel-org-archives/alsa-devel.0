From: Stephen Warren <swarren@nvidia.com>
Subject: Re: link between HDMI ELD and PCM devices
Date: Wed, 21 Sep 2011 08:11:17 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF1738180031@HQMAIL01.nvidia.com>
References: <1316560363.3872.14.camel@pbossart-Dell-N7010>
	<74CDBE0F657A3D45AFBB94109FB122FF04B73217D2@HQMAIL01.nvidia.com>
	<1316566711.3872.24.camel@pbossart-Dell-N7010>
	<4E7987BF.8000206@canonical.com>
	<000001cc7861$2d7895e0$8869c1a0$@bossart@linux.intel.com>
	<4E79ECBA.3060705@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 0A7C924349
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Sep 2011 17:11:26 +0200 (CEST)
In-Reply-To: <4E79ECBA.3060705@canonical.com>
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
To: David Henningsson <david.henningsson@canonical.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: 'Takashi Iwai' <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, 'Wu Fengguang' <fengguang.wu@intel.com>
List-Id: alsa-devel@alsa-project.org

David Henningsson wrote at Wednesday, September 21, 2011 7:55 AM:
> On 09/21/2011 03:20 PM, Pierre-Louis Bossart wrote:
> >> This won't work - in the case of several HDMI codecs (common with
> >> NVidia) there will be more than one "HDMI 0".
> >
> > No, the code doesn't use a constant,
> 
> It's actually four constants, please see generic_hdmi_pcm_names in
> patch_hdmi.c. But my point is that this restarts from 0 on every codec.
> 
> > it's assigned in the same way as the
> > device name. You would have HDMI 0, HDMI 1..4. I don't have this kind of
> > hardware, it'd be good if someone could verify that the name is indeed
> > dynamic.
> 
> On a 3.0 based kernel, here's part of my aplay -l output:
> 
> card 3: NVidia [HDA NVidia], device 3: HDMI 0 [HDMI 0]
>    Subdevices: 1/1
>    Subdevice #0: subdevice #0
> card 3: NVidia [HDA NVidia], device 7: HDMI 0 [HDMI 0]
>    Subdevices: 1/1
>    Subdevice #0: subdevice #0
> card 3: NVidia [HDA NVidia], device 8: HDMI 0 [HDMI 0]
>    Subdevices: 1/1
>    Subdevice #0: subdevice #0
> card 3: NVidia [HDA NVidia], device 9: HDMI 0 [HDMI 0]
>    Subdevices: 1/1
>    Subdevice #0: subdevice #0

Just as an FYI, this is a little HW-dependent.

For GPUs that have multiple codecs, everything David said is true.

Very recent NVIDIA GPUs such as GeForce 520, and at least some Intel GPUs
which Pierre-Louis may be testing with (e.g. my wife's Ibex Peak) have
just one codec, which supports multiple PCMs, and then are numbered like:

card 1: NVidia_1 [HDA NVidia], device 3: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: NVidia_1 [HDA NVidia], device 7: HDMI 1 [HDMI 1]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

-- 
nvpublic
