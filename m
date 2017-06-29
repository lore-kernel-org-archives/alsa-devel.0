From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH 4/4] ASoC: rt5645: Add jack detection
	workaround for GPD Win
Date: Thu, 29 Jun 2017 08:10:24 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D70267BC89@RTITMBSV02.realtek.com.tw>
References: <20170628124939.11696-1-tiwai@suse.de>
 <20170628124939.11696-5-tiwai@suse.de>
 <6af6a503-e2bf-c6a2-08c9-bdbd785df829@linux.intel.com>
 <s5hshijtgqj.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F9D1266EAB
 for <alsa-devel@alsa-project.org>; Thu, 29 Jun 2017 10:10:32 +0200 (CEST)
In-Reply-To: <s5hshijtgqj.wl-tiwai@suse.de>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Hans de Goede <hdegoede@redhat.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> >
> > it feels like it's time to add a quirk parameter for this codec module
> > to avoid chasing all possible DMI/BIOS issues?
> 
> Yes, my very first version was such one, but we ended up with this
> version as the weird-looking DMI matching was confirmed to work
> uniquely.
> 
> If Realtek guys agree, I can submit the patch to add module options in
> addition.

Yes, I agree to and appreciate it. Please cc me when you submit the patch.

Thanks.

> 
> 
> thanks,
> 
> Takashi
> 
> ------Please consider the environment before printing this e-mail.
