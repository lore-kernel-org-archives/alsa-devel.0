From: "Liao, Bard" <bard.liao@intel.com>
Subject: Add polling mode support on
	snd_hdac_bus_get_response(),
Date: Thu, 23 May 2019 06:15:05 +0000
Message-ID: <567A313375B6F043A9BE3A1D9B8C6E7F0B43BC9B@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8A4BCF80C0F
 for <alsa-devel@alsa-project.org>; Thu, 23 May 2019 08:15:12 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "tiwai@suse.de" <tiwai@suse.de>
Cc: "Yang, Libin" <libin.yang@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Bossart,
 Pierre-louis" <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

We would like to add polling mode support on snd_hdac_bus_get_response(),
and use it as a workaround for some specific platforms.
Just like azx_rirb_get_response() and azx_create()

	if (chip->polling_mode || do_poll)
			snd_hdac_bus_update_rirb(bus);
and
	if (IS_CFL(pci))
		chip->polling_mode = 1;

However struct azx is a local variable and other driver may have their own chip
structure. Like struct skl and struct sof_intel_hda_dev.
So I am thinking does it make sense to add the polling_mode in struct
hdac_bus? So we can get the polling_mode directly from bus->polling_mode.
Or it makes more sense to create a global chip struct similar to struct azx for
snd_hdac_bus_get_response()?

Thanks,
Bard
