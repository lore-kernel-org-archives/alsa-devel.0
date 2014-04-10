From: Andrew Lunn <andrew@lunn.ch>
Subject: Broken alc562x codec in linus/master
Date: Thu, 10 Apr 2014 18:51:44 +0200
Message-ID: <20140410165144.GI10240@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps0.lunn.ch (vps0.lunn.ch [178.209.37.122])
 by alsa0.perex.cz (Postfix) with ESMTP id 4EDF7267767
 for <alsa-devel@alsa-project.org>; Thu, 10 Apr 2014 18:53:48 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@linaro.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark

I found a few issues with the changes you have made to
sound/soc/codecs/alc5623.c which is currently in linus master branch.

The patch causing the trouble seems to be:

commit 0cd257bf9b9b0cbb4fa1a5c988a232506997867c
Author: Mark Brown <broonie@linaro.org>
Date:   Thu Feb 20 09:04:06 2014 +0900

    ASoC: alc5623: Convert to direct regmap API usage
    
    Convert to directly use the regmap API, allowing us to eliminate the last
    user of the ASoC level I/O implementations (there are still open coded
    I/O implementations in drivers), avoiding duplicating code in regmap.
    
    We no longer cache the entire CODEC register map on probe since the more
    advanced cache infrastructure in regmap is able to fill the cache on
    demand.
    
    Signed-off-by: Mark Brown <broonie@linaro.org>

At boot i see:

alc562x-codec 0-001a: unknown or wrong codec
alc562x-codec 0-001a: Expected 10ec:21, got ec10:2103

There are two issues here:

-       vid1 = i2c_smbus_read_word_data(client, ALC5623_VENDOR_ID1);
+       ret = regmap_read(alc5623->regmap, ALC5623_VENDOR_ID1, &vid1);

It looks like these are returning different endianness. This explains
the 10ec vs ec10.

Can the regmap flip the endianness?

The second is:

-       vid2 = i2c_smbus_read_byte_data(client, ALC5623_VENDOR_ID2);
-       if (vid2 < 0) {
-               dev_err(&client->dev, "failed to read I2C\n");
-               return -EIO;
+       ret = regmap_read(alc5623->regmap, ALC5623_VENDOR_ID2, &vid2);
+       if (ret < 0) {
+               dev_err(&client->dev, "failed to read vendor ID2: %d\n", ret);
+               return ret;

It was reading a byte, but now it seems to get a word.  Hence 21 vs
2103. Once the endianness is sorted out, we can mask for the lower
byte.

      Thanks
	Andrew
