From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH] ASoc: codec tlv320aic23 fix bogus divide by 0
	message
Date: Fri,  5 Jun 2009 19:15:58 -0700
Message-ID: <1244254558-21114-1-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mpls-qmqp-02.inet.qwest.net (mpls-qmqp-02.inet.qwest.net
	[63.231.195.113])
	by alsa0.perex.cz (Postfix) with ESMTP id 24EC5243F9
	for <alsa-devel@alsa-project.org>;
	Sat,  6 Jun 2009 04:16:14 +0200 (CEST)
In-Reply-To: <>
References: <>
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
Cc: tiwai@suse.de, arunks@mistralsolutions.com, broonie@sirena.org.uk, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

Some code analyzer software mistakenly gives
divide by 0 error messages for these lines.
This patch will end its confusion.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 sound/soc/codecs/tlv320aic23.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index 9fcbb9c..0b8dcb5 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -273,14 +273,14 @@ static const unsigned short sr_valid_mask[] = {
  * Every divisor is a factor of 11*12
  */
 #define SR_MULT (11*12)
-#define A(x) (x) ? (SR_MULT/x) : 0
+#define A(x) (SR_MULT/x)
 static const unsigned char sr_adc_mult_table[] = {
-	A(2), A(2), A(12), A(12),  A(0), A(0), A(3), A(1),
-	A(2), A(2), A(11), A(11),  A(0), A(0), A(0), A(1)
+	A(2), A(2), A(12), A(12),  0, 0, A(3), A(1),
+	A(2), A(2), A(11), A(11),  0, 0, 0, A(1)
 };
 static const unsigned char sr_dac_mult_table[] = {
-	A(2), A(12), A(2), A(12),  A(0), A(0), A(3), A(1),
-	A(2), A(11), A(2), A(11),  A(0), A(0), A(0), A(1)
+	A(2), A(12), A(2), A(12),  0, 0, A(3), A(1),
+	A(2), A(11), A(2), A(11),  0, 0, 0, A(1)
 };
 
 static unsigned get_score(int adc, int adc_l, int adc_h, int need_adc,
-- 
1.5.4.3
