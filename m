From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCHv2 0/2] ASoC: TWL4030: APLL/AIF ordering and
	DAPM updates
Date: Wed, 28 Apr 2010 15:50:13 +0300
Message-ID: <1272459015-22789-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 3FFAA10388C
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Apr 2010 14:50:13 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Hello,

Correct the APLL/AIF powering sequence.
Also introducing DAPM outputs and input for keeping APLL/AIF
enabled in case when no valid DAPM route selected during audio
activity.

The second patch removes the legacy OUTL/R.

As a note:
The APLL/AIF patch replaces the same patch in Liam's series.
The OUTL/R removal can be applied after the OUTL/R reference
has been removed from machine drivers (as in Lima's series).

---
Peter Ujfalusi (2):
  ASoC: TWL4030: AIF/APLL fix in DAPM domain
  ASoC: TWL4030: Remove OUTL/R outputs

 sound/soc/codecs/twl4030.c |   91 ++++++++++++++++++++++++++++++++++----------
 1 files changed, 71 insertions(+), 20 deletions(-)
