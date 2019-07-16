From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH 2/2] ALSA: hda/hdmi - Fix i915 reverse
 port/pin mapping
Date: Tue, 16 Jul 2019 17:33:15 +0300 (EEST)
Message-ID: <alpine.DEB.2.21.1907161730400.16459@zeliteleevi>
References: <20190716074255.14267-1-tiwai@suse.de>
 <20190716074255.14267-2-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A1586F800C6
 for <alsa-devel@alsa-project.org>; Tue, 16 Jul 2019 16:33:19 +0200 (CEST)
In-Reply-To: <20190716074255.14267-2-tiwai@suse.de>
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
Cc: Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

On Tue, 16 Jul 2019, Takashi Iwai wrote:

> The recent fix for Icelake HDMI codec introduced the mapping from pin
> NID to the i915 gfx port number.  However, it forgot the reverse
> mapping from the port number to the pin NID that is used in the ELD
> notifier callback.  As a result, it's processed to a wrong widget and
> gives a warning like
>   snd_hda_codec_hdmi hdaudioC0D2: HDMI: pin nid 5 not registered
> 
> This patch corrects it with a proper reverse mapping function.

looks good:

Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
