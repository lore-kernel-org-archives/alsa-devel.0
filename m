From: Julia Lawall <julia.lawall@lip6.fr>
Subject: question about sound/soc/ux500/ux500_msp_i2s.c
Date: Wed, 25 Jul 2012 10:20:52 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1207251011440.1818@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1-relais-roc.national.inria.fr
 (mail1-relais-roc.national.inria.fr [192.134.164.82])
 by alsa0.perex.cz (Postfix) with ESMTP id DBE54265DAE
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2012 10:20:50 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lrg@ti.com, broonie@opensource.wolfsonmicro.com, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I noticed that the function ux500_msp_i2s_init_msp in the file
sound/soc/ux500/ux500_msp_i2s.c returns 0 rather than -ENOMEM in case the
second devm_kzalloc fails:

        /* I2S-controller is allocated and added in I2S controller class. */
        i2s_cont = devm_kzalloc(&pdev->dev, sizeof(*i2s_cont), GFP_KERNEL);
        if (!i2s_cont) {
                dev_err(&pdev->dev,
                        "%s: ERROR: Failed to allocate I2S-controller!\n",
                        __func__);
                goto err_i2s_cont;
        }

Then I also noticed that this function uses devm_kzalloc, but not
devm_ioremap, and that it does use devm_kfree instead of letting the data
get freed automatically.  But it is true that this function is not itself
a probe function, only called by one.  The only call site I see is in
ux500_msp_drv_probe, in sound/soc/ux500/ux500_msp_dai.c.  But then what
seems strange is that the call site does not test the return value, but
only if the value pointer to by the second argument of the call has been
successfully initialized.  That initialization happens quite near the
beginning of ux500_msp_i2s_init_msp, and there are many ways in which the
function can fail after that.  Do they not matter?  Perhaps that explains
the need for devm_kfree?

Also I see that ux500_msp_drv_probe uses devm_regulator_put, which I was
not previously familiar with.  But if that works like the other devm
functions, and since ux500_msp_drv_probe is actually a probe function of a
platform driver, then is devm_regulator_put actually needed?

thanks,
julia
