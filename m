From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH v3 01/12] ASoC: intel: boards: define some
 general functions for hdac_hdmi
Date: Fri, 12 Apr 2019 02:35:56 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D1952818DA9@SHSMSX103.ccr.corp.intel.com>
References: <1554992400-28777-1-git-send-email-libin.yang@intel.com>
 <1554992400-28777-2-git-send-email-libin.yang@intel.com>
 <s5h7ec0r435.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3080CF80716
 for <alsa-devel@alsa-project.org>; Fri, 12 Apr 2019 04:36:02 +0200 (CEST)
In-Reply-To: <s5h7ec0r435.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

>-----Original Message-----
>From: Takashi Iwai [mailto:tiwai@suse.de]
>Sent: Thursday, April 11, 2019 10:48 PM
>To: Yang, Libin <libin.yang@intel.com>
>Cc: alsa-devel@alsa-project.org; broonie@kernel.org; pierre-
>louis.bossart@linux.intel.com
>Subject: Re: [alsa-devel] [PATCH v3 01/12] ASoC: intel: boards: define some
>general functions for hdac_hdmi
>
>On Thu, 11 Apr 2019 16:19:49 +0200,
>libin.yang@intel.com wrote:
>>
>> +static int hdac_hdmi_add_device_link(struct device *consumer,
>> +				     struct device *supplier,
>> +				     struct device_link **link)
>
>Missing inline?
>
>But, before sending v4, please hold on.
>
>I'm thinking whether we can do this rather in the component init of the hdac-
>hdmi codec driver.  Can't we get the machine device somehow at the time of
>codec component init?
>
>Or even if it's too early, there is also late_probe callback that is called after
>binding all...  If we can manage to create a link from the codec side, we need
>to change only one place, instead of scattering allover the tree.

We just can call it in component driver probe(). It will not too early. After
the machine registers the soc card, it will call the component->driver->probe().
So it is safe we call device_link_add() in component driver probe().

I will submit a new patch soon.

Regards,
Libin

>
>
>thanks,
>
>Takashi
