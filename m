From: Bard Liao <bardliao@realtek.com>
Subject: Use more than 1 .c file for a single codec driver
Date: Fri, 8 Nov 2013 13:32:55 +0800
Message-ID: <1121E117AD4ECE49880A389A396215BB935CA227EA@rtitmbs7.realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id A2E0B261688
 for <alsa-devel@alsa-project.org>; Fri,  8 Nov 2013 06:33:01 +0100 (CET)
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Mark Brown (broonie@linaro.org)" <broonie@linaro.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Can we use more than one .c file for a codec driver?
There are some codecs with DSP function.
I want to know if I can separate the DSP part from other functions.
For example, rt5670.c/.h rt5670-dsp.c/.h for RT5670 codec driver.

Thanks.

Bard Liao

Computer Peripherals Business Unit
Realtek Semiconductor Corp.
886-3-578-0211 ext. 3334
bardliao@realtek.com
