From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Low sample rates for SGTL5000 on i.MX28
Date: Fri, 14 Nov 2014 00:53:24 -0200
Message-ID: <CAOMZO5BW0atG5yHhFGBA-NJfVR1ap_Ud=df5mdwE4pHTUSHWjg@mail.gmail.com>
References: <546450E5.9090203@beamcommunications.com>
 <CAOMZO5BAaL8cP+7NetvNyEiGfokiyLWdpXw3r=AJspLj1dfzxw@mail.gmail.com>
 <54653283.5070404@beamcommunications.com>
 <CAOMZO5ADTTgcvQY=HMt0dk2bAaO23YeBQBbwBzV5HyPOSUu=bQ@mail.gmail.com>
 <CAOMZO5C=pSuW9wkpAwy6aNA3tbPNETvjvgAYer3wNe-T5LrGeQ@mail.gmail.com>
 <CAOMZO5CGnQT0NwQR-Tos3rZvgWAwa2BKxpFZ16yyxtoeO+zr=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f51.google.com (mail-la0-f51.google.com
 [209.85.215.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 4137C260503
 for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2014 03:53:25 +0100 (CET)
Received: by mail-la0-f51.google.com with SMTP id q1so14443960lam.10
 for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2014 18:53:24 -0800 (PST)
In-Reply-To: <CAOMZO5CGnQT0NwQR-Tos3rZvgWAwa2BKxpFZ16yyxtoeO+zr=A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Craig McQueen <craig.mcqueen@beamcommunications.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 13, 2014 at 10:59 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Thu, Nov 13, 2014 at 10:29 PM, Fabio Estevam <festevam@gmail.com> wrote:
>
>> Ok, so the 'aplay stereo_8k.wav' is converting the rate to 44.1kHz, so
>> that's why it does not fail.
>
> From the sgtl5000 datasheet, it looks like the MCLK range of 8 to
> 27MHz limitation does not apply when sgtl5000 runs in slave mode.
>
> A quick hack that allows 'aplay -D hw:0,0 stereo_8k.wav' to play:

I don't have a scope handy to measure the MCLK, LRCLK, but I found a
bug below where we use sys_fs instead of frame_rate:

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 6bb77d7..a46ec7e 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -605,7 +605,7 @@ static int sgtl5000_set_clock(struct snd_soc_codec
*codec, int frame_rate)
         * calculate the divider of mclk/sample_freq,
         * factor of freq =96k can only be 256, since mclk in range (12m,27m)
         */
-       switch (sgtl5000->sysclk / sys_fs) {
+       switch (sgtl5000->sysclk / frame_rate) {
        case 256:
                clk_ctl |= SGTL5000_MCLK_FREQ_256FS <<
                        SGTL5000_MCLK_FREQ_SHIFT;
@@ -1441,14 +1441,6 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
                return ret;
        }

-       /* SGTL5000 SYS_MCLK should be between 8 and 27 MHz */
-       mclk = clk_get_rate(sgtl5000->mclk);
-       if (mclk < 8000000 || mclk > 27000000) {
-               dev_err(&client->dev, "Invalid SYS_CLK frequency: %u.%03uMHz\n",
-                       mclk / 1000000, mclk / 1000 % 1000);
-               return -EINVAL;
-       }
-
        ret = clk_prepare_enable(sgtl5000->mclk);
        if (ret)
                return ret;
diff --git a/sound/soc/mxs/mxs-sgtl5000.c b/sound/soc/mxs/mxs-sgtl5000.c
index 61822cc..3bba6cf 100644
--- a/sound/soc/mxs/mxs-sgtl5000.c
+++ b/sound/soc/mxs/mxs-sgtl5000.c
@@ -49,13 +49,6 @@ static int mxs_sgtl5000_hw_params(struct
snd_pcm_substream *substream,
                break;
        }

-       /* Sgtl5000 sysclk should be >= 8MHz and <= 27M */
-       if (mclk < 8000000 || mclk > 27000000) {
-               dev_err(codec_dai->dev, "Invalid mclk frequency: %u.%03uMHz\n",
-                       mclk / 1000000, mclk / 1000 % 1000);
-               return -EINVAL;
-       }
-
        /* Set SGTL5000's SYSCLK (provided by SAIF MCLK) */
        ret = snd_soc_dai_set_sysclk(codec_dai, SGTL5000_SYSCLK, mclk, 0);
        if (ret) {

aplay -D hw:0,0 /home/stereo_8k.wav plays in a incorrect pitch, so we
still need to adjust the clocking.
