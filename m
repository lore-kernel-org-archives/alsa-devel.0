From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: tlv320aic3x: potential null dereference
Date: Sun, 5 Sep 2010 18:46:11 +0300
Message-ID: <20100905184611.ac387439.jhnikula@gmail.com>
References: <4C8244AD.6090900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8AC001037EE
	for <alsa-devel@alsa-project.org>;
	Sun,  5 Sep 2010 17:45:43 +0200 (CEST)
Received: by ewy21 with SMTP id 21so1731051ewy.38
	for <alsa-devel@alsa-project.org>; Sun, 05 Sep 2010 08:45:42 -0700 (PDT)
In-Reply-To: <4C8244AD.6090900@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Sat, 04 Sep 2010 15:07:57 +0200
Jiri Slaby <jirislaby@gmail.com> wrote:

> Hi,
> 
> stanse found a potential null dereference:
> aic3x_i2c_probe
>   -> struct aic3x_setup_data *setup = pdata->setup;
>   -> -- pdata can't be null now--
>   -> if (pdata && pdata->gpio_reset >= 0)
> 
> But there is another check for pdata == NULL. Could take a look and fix
> it (either remove the check or move the assignement inside the if)?
> 
Thanks, this is a bug that got introduced recently to ASoC tree.
Fortunately is not in mainline. I'll send a fix in a minute to
alsa-devel.


-- 
Jarkko
