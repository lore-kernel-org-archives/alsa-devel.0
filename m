From: The Source <thesourcehim@gmail.com>
Subject: snd-ctxfi
Date: Sat, 30 May 2009 07:22:43 +0400
Message-ID: <4A20A683.9010102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f170.google.com (mail-fx0-f170.google.com
	[209.85.220.170])
	by alsa0.perex.cz (Postfix) with ESMTP id C5CD22478C
	for <alsa-devel@alsa-project.org>;
	Sat, 30 May 2009 05:22:52 +0200 (CEST)
Received: by fxm18 with SMTP id 18so6904618fxm.32
	for <alsa-devel@alsa-project.org>; Fri, 29 May 2009 20:22:51 -0700 (PDT)
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

Hello. I tested the snd-ctxfi driver and found no problems (except no 
support for 5.1 and external console, but original ctxfi does not 
support them either). A minor problem: kernel oops reporter periodically 
pops up with message about using a timer in a wrong place. I'll post 
here this message when I get it next time.
