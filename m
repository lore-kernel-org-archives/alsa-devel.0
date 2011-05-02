From: "Feng Ye" <fye@broadcom.com>
Subject: ASoC legacy i2c client driver probing issue
Date: Mon, 2 May 2011 11:18:19 -0700
Message-ID: <9383297B60843144AC17878B479520F1164B62450F@SJEXCHCCR01.corp.ad.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from MMS3.broadcom.com (mms3.broadcom.com [216.31.210.19])
	by alsa0.perex.cz (Postfix) with ESMTP id 3EB2324404
	for <alsa-devel@alsa-project.org>;
	Mon,  2 May 2011 20:25:36 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello,

I have a legacy i2c client driver probing issue.
I use kernel version 2.6.27, and wm8750 external codec. The wm8750.c in sound/soc/codecs has a legacy i2c interface (e.g. use attach_adapter() callback). The callback just calls to i2c_probe(). Inside i2c_probe() it checks if the i2c address already been used, and fails there.

In our i2c bus driver, we used i2c_register_board_info() with a static i2c_board_info structure. And then i2c_add_numbered_adapter() is called.
>From code trace, it eventually calls i2c_attach_client(). So I think the probe function will for sure to fail.

I wonder how this would work? How can i2c_probe() succeed if it checks for address in use?
This question is more related to i2c instead of alsa soc. I am sure the SoC part is good, the i2c address is passed to wm8750 through snd_soc_codec_device.



Thanks,
Feng
