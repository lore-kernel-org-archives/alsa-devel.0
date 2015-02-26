From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [ALSA] ca0106: power down SPI DAC channels when
	not in use
Date: Thu, 26 Feb 2015 14:06:56 +0300
Message-ID: <20150226110656.GA17980@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id A03C8261A90
 for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2015 12:07:21 +0100 (CET)
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
To: xyzzy@speakeasy.org, Andy Owen <andy-alsa@ultra-premium.com>, James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Trent Piepho,

The patch 485100706b4b: "[ALSA] ca0106: power down SPI DAC channels
when not in use" from Jul 25, 2007, leads to the following static
checker warning:

	sound/pci/ca0106/ca0106_main.c:601 snd_ca0106_pcm_open_playback_channel()
	warn: bool is not less than zero.

sound/pci/ca0106/ca0106_main.c
   597  
   598          /* Front channel dac should already be on */
   599          if (channel_id != PCM_FRONT_CHANNEL) {
   600                  err = snd_ca0106_pcm_power_dac(chip, channel_id, 1);

Because of snd_ca0106_spi_write() then this function appears to return
zero on success and 1 on failure.  That's very strange.  None of the
callers expect a 1 return.  If they care about the return code then they
expect negative error codes.

   601                  if (err < 0)
   602                          return err;
   603          }
   604  

regards,
dan carpenter
