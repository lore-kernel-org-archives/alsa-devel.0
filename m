From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH] ALSA: hda - Optimize resume for codecs
 without jack detection
Date: Thu, 18 Jul 2019 14:59:31 +0300 (EEST)
Message-ID: <alpine.DEB.2.21.1907181453020.16459@zeliteleevi>
References: <20190717135552.25825-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DFB8AF800D2
 for <alsa-devel@alsa-project.org>; Thu, 18 Jul 2019 13:59:35 +0200 (CEST)
In-Reply-To: <20190717135552.25825-1-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Wed, 17 Jul 2019, Takashi Iwai wrote:

> The codecs without jack detection also don't have to be resumed
> forcibly because, obviously, they have no jack.  Skip the forced
> resume in such a case as optimization as well.

looks good. I did a light test round for this, together with
the previous "ALSA: hda - Don't resume forcibly i915 HDMI/DP codec" 
and seem good.

Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
