From: shariff <shariffsinbox@gmail.com>
Subject: Reg: Implementation of GSM digital audio path
Date: Thu, 25 Jun 2009 15:17:54 +0530
Message-ID: <1cbe56070906250247j30e63925k3acbff5a5a3e3df8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.169])
	by alsa0.perex.cz (Postfix) with ESMTP id 5AE6E24BA3
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Jun 2009 11:47:55 +0200 (CEST)
Received: by wf-out-1314.google.com with SMTP id 24so439228wfg.23
	for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2009 02:47:54 -0700 (PDT)
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

Hi all,

        Iam working on OMAP3 based custom board. On our board, GSM digital
audio path is connected to McBSP3 and
TWL4030 digital audio path is connected to McBSP2.

I want to implement a module that transfers GSM audio data and store audio
data into some buffer and redirect it to TWL4030 audio codec through McBSP2.

I question is how can I implement this in ASoC?

I studied ASoC framework, but I am unable to understand where to implement
my stuff.

Regards,
Shariff
