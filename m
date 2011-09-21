From: "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>
Subject: Re: link between HDMI ELD and PCM devices
Date: Wed, 21 Sep 2011 08:20:04 -0500
Message-ID: <7165.68798893622$1316611224@news.gmane.org>
References: <1316560363.3872.14.camel@pbossart-Dell-N7010>
	<74CDBE0F657A3D45AFBB94109FB122FF04B73217D2@HQMAIL01.nvidia.com>
	<1316566711.3872.24.camel@pbossart-Dell-N7010>
	<4E7987BF.8000206@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id D4671103844
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Sep 2011 15:20:10 +0200 (CEST)
In-Reply-To: <4E7987BF.8000206@canonical.com>
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
Cc: 'Takashi Iwai' <tiwai@suse.de>, alsa-devel@alsa-project.org, 'Wu Fengguang' <fengguang.wu@intel.com>, 'Stephen Warren' <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

> This won't work - in the case of several HDMI codecs (common with
> NVidia) there will be more than one "HDMI 0".

No, the code doesn't use a constant, it's assigned in the same way as the
device name. You would have HDMI 0, HDMI 1..4. I don't have this kind of
hardware, it'd be good if someone could verify that the name is indeed
dynamic.

> The solution is to actually find the device number out, like this:
> 
> 	struct hdmi_spec *spec = codec->spec;
> 	int pcmdev = spec->pcm_rec[pin_idx].device;

That's what I wanted initially, but this device field is not
used/initialized, and like I said the device assignment comes after the pin
sensing and all the ELD handling
-Pierre
