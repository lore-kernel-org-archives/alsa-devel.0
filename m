From: Johannes Stezenbach <js@sig21.net>
Subject: [PATCH 0/2] ASoC: STA32x: filter coefficients, bug fix
Date: Mon, 11 Jul 2011 17:01:22 +0200
Message-ID: <1310396484-23371-1-git-send-email-js@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bar.sig21.net (bar.sig21.net [80.81.252.164])
	by alsa0.perex.cz (Postfix) with ESMTP id C1EDA103809
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jul 2011 17:01:46 +0200 (CEST)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi,

here are two patches for the ST STA32x ASoC codec driver.
The first one adds SNDRV_CTL_ELEM_TYPE_BYTES controls
for access to the biquad filter coefficients.  I haven't found
any other driver using SNDRV_CTL_ELEM_TYPE_BYTES in this way,
but it works nicely.  The coefficients can be set with
amixer (although amixer has a quirk in that it prints
the values in hex but can read them only as decimal).

# amixer cget name='Ch1 - Biquad 1'
numid=43,iface=MIXER,name='Ch1 - Biquad 1'
  ; type=BYTES,access=rw------,values=15
  : values=0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00

# amixer cset name='Ch1 - Biquad 1' 12,34,0,0,0,0,0,0,0,0,0,0,0,255,78
numid=43,iface=MIXER,name='Ch1 - Biquad 1'
  ; type=BYTES,access=rw------,values=15
  : values=0x0c,0x22,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xff,0x4e

Due to the way the internal coeffcient RAM is accessed, the
corresponding I2C registers are volatile, thus I added the
.volatile_register function in this patch.

The second patch preserves reset values as required by the
chip documentation, it is mainly for future compatibility
and was added during hardware testing to rule out issues from
this side, although it did not make a difference in my tests.
However, the chip spec insists it is important.


Thanks
Johannes
