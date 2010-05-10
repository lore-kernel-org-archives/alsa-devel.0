From: "Max Klein" <mein_name@ist-einmalig.de>
Subject: ALSA Control Interface - default values?
Date: Mon, 10 May 2010 15:35:16 +0200
Message-ID: <20100510133516.41930@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id EC6C01037EE
	for <alsa-devel@alsa-project.org>;
	Mon, 10 May 2010 15:35:18 +0200 (CEST)
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

when writing an alsa driver, in the info callback of the control I can specify which range of values this control does accept (uinfo->value.integer.min and .max). If I put 1 as minimum and 10 as maximum for example, I would expect that the default value of this control is something in between the range, e.g. 1, after the driver is loaded.

But I figured out, that ALSA initializes the control with a value of 0, which is not in between the range.

Can someone please tell me why ALSA initializes the Control with a value of zero, even if the minimum in the info callback is 1 ?

Is there any way to initialize the control with some "default" values, aside of snd_ctl_add()?

Best regards and thanks for your help!
Max
-- 
"Feel free" - 10 GB Mailbox, 100 FreeSMS/Monat ...
Jetzt GMX TopMail testen: http://www.gmx.net/de/go/topmail
