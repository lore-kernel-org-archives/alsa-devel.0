From: Jeremy McDermond <nh6z@nh6z.net>
Subject: [PATCH 0/2] ASoC: tlv320aic32x4: Better model the
	input mixers
Date: Wed, 20 Apr 2016 11:39:10 -0700
Message-ID: <1461177552-31809-1-git-send-email-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.xenotropic.com (mail.xenotropic.com [198.178.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id C0044266558
 for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2016 20:39:22 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
Cc: Jeremy McDermond <nh6z@nh6z.net>
List-Id: alsa-devel@alsa-project.org

The input mixers have resistors on all the input lines as well as an
additional line that crosses between right and left pins.  This patch
enables those routings within the driver to provide more flexibility for
different board configurations.

These settings are documented on pages 135 and 136 of TI's SLAA557
document available at http://www.ti.com/lit/ml/slaa557/slaa557.pdf.

This patch might introduce some breakage for current users because it
changes some mixer routing settings from a straight switch to an enum for
the different resistor values instead.  I'm not sure there's anything we
can do in code to mitigate these effects, but am open to requests for
changes if there's something I'm not aware of.

Jeremy McDermond (2):
  ASoC: tlv320aic32x4: Implement resistors on input pins
  ASoC: tlv320aic32x4:  Add additional input pins

 sound/soc/codecs/tlv320aic32x4.c | 38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

-- 
2.5.0
