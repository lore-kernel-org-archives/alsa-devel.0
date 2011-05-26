From: Stephen Warren <swarren@nvidia.com>
Subject: Re: HDA HDMI pin to converter mapping
Date: Thu, 26 May 2011 16:07:37 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0498A48810@HQMAIL01.nvidia.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF0498A484DD@HQMAIL01.nvidia.com>
	<s5h39k22bmu.wl%tiwai@suse.de> <4DDE22DA.7070905@canonical.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0498A486FC@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id AB257103804
	for <alsa-devel@alsa-project.org>;
	Fri, 27 May 2011 01:07:45 +0200 (CEST)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0498A486FC@HQMAIL01.nvidia.com>
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
To: Stephen Warren <swarren@nvidia.com>, David Henningsson <david.henningsson@canonical.com>, Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Nitin@alsa-project.org" <Nitin@alsa-project.org>, Wei Ni <wni@nvidia.com>, "pl bossart (bossart.nospam@gmail.com)" <bossart.nospam@gmail.com>, "Wu
	Fengguang  (wfg@linux.intel.com)" <wfg@linux.intel.com>, Nitin Daga <ndaga@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Stephen Warren wrote at Thursday, May 26, 2011 11:45 AM:
> David Henningsson wrote at Thursday, May 26, 2011 3:52 AM:
> ...
> > So we're effectively breaking some of the older chips by changing the
> > PCM device from hw:X to hw:X,1 for a specific pin...?
> 
> I don't believe the PCM device names would change for existing supported
> codecs.
> 
> Specifically, the PCM names are:
> 
> hw:${card},${codec_index}                    (1 converter)
> 
> hw:${card},${codec_index}.${converter_index} (n converters)

Actually, I think I was confused here; looking at snd_hda_codec_build_pcms,
I think the naming is always flat, irrespective of how many converters
are within a codec:

hw:${card},${dev}

with dev being assigned in sequence 3,7,8,9 within an entire HDA bus,
which I think means within an entire HDA controller.

So, the naming scheme most likely won't change at all.

-- 
nvpublic
