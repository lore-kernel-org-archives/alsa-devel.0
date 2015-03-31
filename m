From: Pascal Huerst <pascal.huerst@gmail.com>
Subject: ASoC: cs4271: init/timing problem
Date: Tue, 31 Mar 2015 10:50:17 +0200
Message-ID: <551A5FC9.4010109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f172.google.com (mail-wi0-f172.google.com
 [209.85.212.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 76EA6260604
 for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2015 10:50:19 +0200 (CEST)
Received: by wiaa2 with SMTP id a2so16910503wia.0
 for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2015 01:50:19 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: brian.austin@cirrus.com
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Paul.Handrigan@cirrus.com
List-Id: alsa-devel@alsa-project.org

Hey all,

We have a custom built hw, based on am335x and from time to time we need
to rmmod/modprobe the ASoC machine driver. Depending on the hw, the
first call to regmap_update_bits(..) in cs4271_codec_probe(..) fails
with -EREMOTEIO.

The error is originated in:

drivers/i2c/busses/i2c-omap.c

and happens if no i2c package acknowledge is received by the host.

I think this is a timing issue and on some devices, the codec is just
not ready yet, for communication.

What is the right way to fix that? My attempt would be something like this:

const int retries = 5;

while (retries) {
	ret = regmap_update_bits(cs4271->regmap, CS4271_MODE2,
                                 CS4271_MODE2_PDN | CS4271_MODE2_CPEN,
                                 CS4271_MODE2_PDN | CS4271_MODE2_CPEN);

        if (ret == -EREMOTEIO) {
                retries--;
                udelay(1);
                continue;

        } else if (ret)
                return ret;

        break;
}

But I might also just add a proper delay before the first call to
regmap_update_bits(..)

So what is the proper way to handle this?

Thanks
Pascal
