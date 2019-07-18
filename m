From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH 1/2] ALSA: hda/hdmi - Don't report spurious
 jack state changes
Date: Thu, 18 Jul 2019 15:21:25 +0300 (EEST)
Message-ID: <alpine.DEB.2.21.1907181517130.16459@zeliteleevi>
References: <20190718094321.16442-1-tiwai@suse.de>
 <20190718094321.16442-2-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A56EDF800C4
 for <alsa-devel@alsa-project.org>; Thu, 18 Jul 2019 14:21:30 +0200 (CEST)
In-Reply-To: <20190718094321.16442-2-tiwai@suse.de>
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

Hey,

On Thu, 18 Jul 2019, Takashi Iwai wrote:

> The HDMI jack handling reports the state change always via
> snd_jack_report() whenever hdmi_present_sense() is called, even if the
> state itself doesn't change from the previous time.  This is mostly
> harmless but still a big confusing to user-space.

typo: "a bit confusing to user-space"

The patch iself looks good. Gave a quick test with some HDMI 
hotplugging and works as expected.

Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
