From: "Jin-Young Park" <mcjin02@gmail.com>
Subject: wrong print debugging message code
Date: Sat, 21 Jun 2008 14:44:47 +0900
Message-ID: <280b69ac0806202244s11e74363l4de3f020fed849be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.191])
	by alsa0.perex.cz (Postfix) with ESMTP id 50D7710390E
	for <alsa-devel@alsa-project.org>;
	Sat, 21 Jun 2008 07:44:48 +0200 (CEST)
Received: by fk-out-0910.google.com with SMTP id b27so1531326fka.0
	for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2008 22:44:47 -0700 (PDT)
Content-Disposition: inline
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
List-Id: alsa-devel@alsa-project.org

Hello,

I written ASoC Audio driver for our company chip in linux kernel 2.6.24.1.
New kernel 2.6.25.7 released before several days.
So, I merge my ASoC Audio dirver to kernel 2.6.25.7.
then I found wrong code that print debuuging message code in several files.
These file location is kernel_src/sound/soc/codecs for SoC audio codec
drvier files

These files include follow define code for print debug message.

------------------------------------------------------------------------------------------------------------------------
#define XXXX_DEBUG 0

#ifdef XXXX_DEBUG
#define dbg(format, arg...) \
        printk(KERN_DEBUG AUDIO_NAME ": " format "\n" , ## arg)
#else
#define dbg(format, arg...) do {} while (0)
#endif
------------------------------------------------------------------------------------------------------------------------

I think "#ifdef XXXX_DEBUG" line is wrong. Because, XXXX_DEBUG was already
defined 0.
I known that "#ifdef" is only check defined or not defined, 0 or 1(false or
true) are not check.
"#if XXXX_DEBUG" code is more correct than "#ifdef XXXX_DEBUG".

thanks
