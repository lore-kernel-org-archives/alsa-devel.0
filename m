From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: link between HDMI ELD and PCM devices
Date: Wed, 21 Sep 2011 15:55:06 +0200
Message-ID: <4E79ECBA.3060705@canonical.com>
References: <1316560363.3872.14.camel@pbossart-Dell-N7010>
	<74CDBE0F657A3D45AFBB94109FB122FF04B73217D2@HQMAIL01.nvidia.com>
	<1316566711.3872.24.camel@pbossart-Dell-N7010>
	<4E7987BF.8000206@canonical.com>
	<000001cc7861$2d7895e0$8869c1a0$@bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 05CDF103AD9
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Sep 2011 15:55:09 +0200 (CEST)
In-Reply-To: <000001cc7861$2d7895e0$8869c1a0$@bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: 'Takashi Iwai' <tiwai@suse.de>, alsa-devel@alsa-project.org, 'Wu Fengguang' <fengguang.wu@intel.com>, 'Stephen Warren' <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

On 09/21/2011 03:20 PM, Pierre-Louis Bossart wrote:
>> This won't work - in the case of several HDMI codecs (common with
>> NVidia) there will be more than one "HDMI 0".
>
> No, the code doesn't use a constant,

It's actually four constants, please see generic_hdmi_pcm_names in 
patch_hdmi.c. But my point is that this restarts from 0 on every codec.

> it's assigned in the same way as the
> device name. You would have HDMI 0, HDMI 1..4. I don't have this kind of
> hardware, it'd be good if someone could verify that the name is indeed
> dynamic.

On a 3.0 based kernel, here's part of my aplay -l output:

card 3: NVidia [HDA NVidia], device 3: HDMI 0 [HDMI 0]
   Subdevices: 1/1
   Subdevice #0: subdevice #0
card 3: NVidia [HDA NVidia], device 7: HDMI 0 [HDMI 0]
   Subdevices: 1/1
   Subdevice #0: subdevice #0
card 3: NVidia [HDA NVidia], device 8: HDMI 0 [HDMI 0]
   Subdevices: 1/1
   Subdevice #0: subdevice #0
card 3: NVidia [HDA NVidia], device 9: HDMI 0 [HDMI 0]
   Subdevices: 1/1
   Subdevice #0: subdevice #0

>> The solution is to actually find the device number out, like this:
>>
>> 	struct hdmi_spec *spec = codec->spec;
>> 	int pcmdev = spec->pcm_rec[pin_idx].device;
>
> That's what I wanted initially, but this device field is not
> used/initialized, and like I said the device assignment comes after the pin
> sensing and all the ELD handling

A good place to do this is generic_hdmi_build_controls, both because it 
is normally used to add controls (which is what you do), and because it 
is triggered after the pcm device is assigned.

(A side note to Takashi: for some reason hda-emu has the calls to 
build_controls and build_pcms switched, compared to the real 
implementation.)

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
