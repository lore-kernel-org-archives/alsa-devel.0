From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: M-Audio Audiophile 192 (ice1724)'s broken spdif
 capture
Date: Wed, 30 Jan 2013 11:26:09 +0100
Message-ID: <5108F541.3010300@ivitera.com>
References: <CAF+J8LeejgAx6vs0Ee8svWpmGYyk3-7SK+mE1ev-bWXYy-7v6Q@mail.gmail.com>
 <51042EE5.5070900@perex.cz>
 <7adcf466397b198e2e079e35b47686bc.squirrel@mail.insite.cz>
 <CAF+J8LduUEPqaguteL0oyiACXa4jVXGTVVTCm4Tw=jMxRTmLWA@mail.gmail.com>
 <510670CC.2090904@ivitera.com> <5107188F.3060001@gmail.com>
 <510798CC.3080006@ivitera.com> <51081FA7.70907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (static-84-242-75-189.net.upcbroadband.cz
 [84.242.75.189])
 by alsa0.perex.cz (Postfix) with ESMTP id F1793261718
 for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2013 11:26:09 +0100 (CET)
In-Reply-To: <51081FA7.70907@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonas Petersen <jnsptrsn1@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 29.1.2013 20:14, Jonas Petersen wrote:
> Am 29.01.2013 10:39, schrieb Pavel Hofman:
> 
> I did that with no success. Same behaviour, no change, still no ak4114.
> The only difference I got was:
> 
> $ diff ~/Audiophile192-proc-a.txt ~/Audiophile192-proc-b.txt
> 90c90
> <   MT05     : 0x08
> ---
>>   MT05     : 0x00
> 
> I printk'ed a message in ap192_ak4114_init() and it's definitely being
> called.
> 

I see, ak4114 support in revo.c is incomplete. ak4114 controls incl. the
proc file are never built. Please try the following patch (applicable to
clean git checkout):

diff --git a/sound/pci/ice1712/revo.c b/sound/pci/ice1712/revo.c
index 7641080..3f39c42 100644
--- a/sound/pci/ice1712/revo.c
+++ b/sound/pci/ice1712/revo.c
@@ -35,6 +35,7 @@
 struct revo51_spec {
        struct snd_i2c_device *dev;
        struct snd_pt2258 *pt2258;
+       struct ak4114 *ak4114;
 };

 static void revo_i2s_mclk_changed(struct snd_ice1712 *ice)
@@ -487,10 +488,10 @@ static int ap192_ak4114_init(struct snd_ice1712 *ice)
                                 ap192_ak4114_read,
                                 ap192_ak4114_write,
                                 ak4114_init_vals, ak4114_init_txcsb,
-                                ice, &ak);
+                                ice, &spec->ak4114);
        /* AK4114 in Revo cannot detect external rate correctly.
         * No reason to stop capture stream due to incorrect checks */
-       ak->check_flags = AK4114_CHECK_NO_RATE;
+       spec->ak4114->check_flags = AK4114_CHECK_NO_RATE;

        return 0; /* error ignored; it's no fatal error */
 }
@@ -562,6 +563,9 @@ static int revo_init(struct snd_ice1712 *ice)
                                               ice);
                if (err < 0)
                        return err;
+               err = ap192_ak4114_init(ice);
+               if (err < 0)
+                       return err;

                /* unmute all codecs */
                snd_ice1712_gpio_write_bits(ice, VT1724_REVO_MUTE,
@@ -597,9 +601,13 @@ static int revo_add_controls(struct snd_ice1712 *ice)
                err = snd_ice1712_akm4xxx_build_controls(ice);
                if (err < 0)
                        return err;
-               err = ap192_ak4114_init(ice);
+               /* only capture SPDIF over AK4114 */
+               spec = ice->spec;
+               err = snd_ak4114_build(spec->ak4114, NULL,
+
ice->pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream);
                if (err < 0)
-                       return err;
+               return err;
+
                break;
        }
        return 0;


Thanks,

Pavel.
