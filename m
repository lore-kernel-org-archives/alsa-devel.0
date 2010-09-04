From: Jiri Slaby <jirislaby@gmail.com>
Subject: tlv320aic3x: potential null dereference
Date: Sat, 04 Sep 2010 15:07:57 +0200
Message-ID: <4C8244AD.6090900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id EDF27243B9
	for <alsa-devel@alsa-project.org>;
	Sat,  4 Sep 2010 15:07:59 +0200 (CEST)
Received: by fxm11 with SMTP id 11so1792586fxm.38
	for <alsa-devel@alsa-project.org>; Sat, 04 Sep 2010 06:07:59 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: lrg@slimlogic.co.uk
Cc: alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi,

stanse found a potential null dereference:
aic3x_i2c_probe
  -> struct aic3x_setup_data *setup = pdata->setup;
  -> -- pdata can't be null now--
  -> if (pdata && pdata->gpio_reset >= 0)

But there is another check for pdata == NULL. Could take a look and fix
it (either remove the check or move the assignement inside the if)?

thanks,
-- 
js
