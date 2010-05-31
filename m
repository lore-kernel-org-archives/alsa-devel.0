From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Problem with snd_hda_intel from 05-27-2010 snapshot
Date: Mon, 31 May 2010 20:30:34 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1005312028520.5693@eeebox2.perex-int.cz>
References: <AANLkTilIX_UnMYcg8LAqkndS80nFppblW6erTm2e7o5X@mail.gmail.com>
	<AANLkTinLbTMrYBhg6KO826slsugfEcU0_wYqukSQpQw2@mail.gmail.com>
	<alpine.LNX.2.00.1005270931570.6856@eeebox2.perex-int.cz>
	<AANLkTinvfYyOHzQrEfcBrDvDMW3Fc93oYrUHOcABm0Oa@mail.gmail.com>
	<alpine.LNX.2.00.1005290822040.6856@eeebox2.perex-int.cz>
	<AANLkTin1b34S7HeeHTppZkomIZ0Ka-xkC6viZt2Jfr1o@mail.gmail.com>
	<alpine.LNX.2.00.1005301733300.6856@eeebox2.perex-int.cz>
	<AANLkTim5L_klj1g-8hwnsftuR4x_GwESH_AOdeb4_XzT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 3F2582455C
	for <alsa-devel@alsa-project.org>;
	Mon, 31 May 2010 20:30:36 +0200 (CEST)
In-Reply-To: <AANLkTim5L_klj1g-8hwnsftuR4x_GwESH_AOdeb4_XzT@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: VDR User <user.vdr@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, 30 May 2010, VDR User wrote:

> On Sun, May 30, 2010 at 8:37 AM, Jaroslav Kysela <perex@perex.cz> wrote:
>> Thanks. The wallclock register seems working OK. Please, use value 29 for
>> the xrun_debug file to do more accurate inspection what's going wrong (as I
>> suggested in my first reply):
>
> Attached is my full syslog with xrun_debug 29.

Thanks. Could you try this patch?

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 170610e..ac3dbab 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1910,7 +1910,7 @@ static int azx_position_ok(struct azx *chip, struct azx_dev *azx_dev)
  	if (WARN_ONCE(!azx_dev->period_bytes,
  		      "hda-intel: zero azx_dev->period_bytes"))
  		return -1; /* this shouldn't happen! */
-	if (wallclk <= azx_dev->period_wallclk &&
+	if (wallclk < (azx_dev->period_wallclk * 3) / 2 &&
  	    pos % azx_dev->period_bytes > azx_dev->period_bytes / 2)
  		/* NG - it's below the first next period boundary */
  		return bdl_pos_adj[chip->dev_index] ? 0 : -1;

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
