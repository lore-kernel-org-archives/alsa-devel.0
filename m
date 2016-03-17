From: Pascal Huerst <pascal.huerst@gmail.com>
Subject: adau1701: Different sample rates need different
	firmwares
Date: Thu, 17 Mar 2016 11:51:24 +0100
Message-ID: <56EA8C2C.4010606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com [74.125.82.41])
 by alsa0.perex.cz (Postfix) with ESMTP id DFC75260694
 for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2016 11:51:25 +0100 (CET)
Received: by mail-wm0-f41.google.com with SMTP id p65so20120960wmp.1
 for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2016 03:51:25 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hey Lars,

I'm having an issue with the adau1701 codec. There is this line which
checks, if the mclk/lrclk ratio has changed and whether it is necessary
to reset the codec and upload a new firmware.

http://lxr.free-electrons.com/source/sound/soc/codecs/adau1701.c#L444

But if we change mclk in the machine driver (for example to playback
44.1), this ration might not change, but still we have to upload a new
firmware, so shouldn't we probably be checking for sample rate changes
instead:

if (adau1701->current_rate != params_rate(params) {
	adau1701->current_rate = params_rate(params);
	ret = adau1701_reset(codec, clkdiv, params_rate(params));
	if (ret < 0)
		return ret;
}

Or did I miss something?

regards
pascal
