From: Stephen Warren <swarren@nvidia.com>
Subject: Re: link between HDMI ELD and PCM devices
Date: Tue, 20 Sep 2011 16:33:45 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04B73217D2@HQMAIL01.nvidia.com>
References: <1316560363.3872.14.camel@pbossart-Dell-N7010>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id C5D08103A6D
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Sep 2011 01:33:48 +0200 (CEST)
In-Reply-To: <1316560363.3872.14.camel@pbossart-Dell-N7010>
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
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "; Takashi Iwai" <tiwai@suse.de>, "; Wu Fengguang" <fengguang.wu@intel.com>
List-Id: alsa-devel@alsa-project.org

Pierre-Louis Bossart wrote at Tuesday, September 20, 2011 5:13 PM:
> Hi,
> I've been trying for some time to expose the HDMI ELD information in a
> new control. The problem I am facing with the HDMI/HDA code is that the
> ELD is linked to an output pin, and I can't find an elegant way to link
> this output pin with a PCM device number to be used by my control. For a
> single output, I could hard-code something but it would probably not
> work with multiple monitors handled by recent hardware.
> There is some existing code such as pin_nid_to_pin_index() in
> patch_hdmi.c, but I can't figure out what this pin_idx is, and how to
> find the related PCM device number.
> Any suggestions?

That function simply returns the index into the array spec->pins[] that
refers to that pin NID.

Judging by hinfo_to_pin_index() (e.g. used near the start ofhdmi_pcm_open),
that same index is valid  for spec->pcm_rec[] too, which I assume will
give you access to what you want, possibly through the .stream[0] field.

-- 
nvpublic
