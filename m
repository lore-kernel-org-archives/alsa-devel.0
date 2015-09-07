From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: ASoC: please revert "ASoC: db1200: Use static DAI
 format setup"
Date: Mon, 07 Sep 2015 13:54:26 +0200
Message-ID: <55ED7AF2.1050800@metafoo.de>
References: <CAOLZvyG_tgPoXFJMBkqSeDULBUzgdqnNjQF7eVuzLzU2VtDArg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050900090205050804000508"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-020.synserver.de (smtp-out-026.synserver.de
 [212.40.185.26])
 by alsa0.perex.cz (Postfix) with ESMTP id 69EF3260506
 for <alsa-devel@alsa-project.org>; Mon,  7 Sep 2015 14:01:37 +0200 (CEST)
In-Reply-To: <CAOLZvyG_tgPoXFJMBkqSeDULBUzgdqnNjQF7eVuzLzU2VtDArg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Manuel Lauss <manuel.lauss@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050900090205050804000508
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

On 09/06/2015 07:32 PM, Manuel Lauss wrote:
> Hi Lars,
> 
> commit b4508d0f95fa4aaed889549e31391641d675d4bb
> ("ASoC: db1200: Use static DAI format setup") breaks I2S in that the
> set_dai_fmt() callbacks of neither the codec (wm8731) nor the I2S block
> (psc-i2s) are called.
> 
> Please revert this change or fix it up so that the set_dai_fmt() callbacks
> are at least called once. (This was broken since 4.0, but I just now got
> around to test linux on the hardware again).

Hi,

Can you check whether the attached patch fixes it?

- Lars

--------------050900090205050804000508
Content-Type: text/x-patch;
 name="au1x.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="au1x.patch"

diff --git a/sound/soc/au1x/db1200.c b/sound/soc/au1x/db1200.c
index 58c3164..8c907eb 100644
--- a/sound/soc/au1x/db1200.c
+++ b/sound/soc/au1x/db1200.c
@@ -129,6 +129,8 @@ static struct snd_soc_dai_link db1300_i2s_dai = {
 	.cpu_dai_name	= "au1xpsc_i2s.2",
 	.platform_name	= "au1xpsc-pcm.2",
 	.codec_name	= "wm8731.0-001b",
+	.dai_fmt	= SND_SOC_DAIFMT_LEFT_J | SND_SOC_DAIFMT_NB_NF |
+			  SND_SOC_DAIFMT_CBM_CFM,
 	.ops		= &db1200_i2s_wm8731_ops,
 };
 
@@ -146,6 +148,8 @@ static struct snd_soc_dai_link db1550_i2s_dai = {
 	.cpu_dai_name	= "au1xpsc_i2s.3",
 	.platform_name	= "au1xpsc-pcm.3",
 	.codec_name	= "wm8731.0-001b",
+	.dai_fmt	= SND_SOC_DAIFMT_LEFT_J | SND_SOC_DAIFMT_NB_NF |
+			  SND_SOC_DAIFMT_CBM_CFM,
 	.ops		= &db1200_i2s_wm8731_ops,
 };
 

--------------050900090205050804000508
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------050900090205050804000508--
