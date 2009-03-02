From: John Kha <sirkha@gmail.com>
Subject: Support for fujitsu T421x
Date: Sun, 1 Mar 2009 20:43:56 -0500
Message-ID: <b91658390903011743x6e744b32y1cb9e8f8cb210b2e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 618D31037F0
	for <alsa-devel@alsa-project.org>; Mon,  2 Mar 2009 02:43:57 +0100 (CET)
Received: by yw-out-1718.google.com with SMTP id 6so1414569ywa.2
	for <alsa-devel@alsa-project.org>; Sun, 01 Mar 2009 17:43:56 -0800 (PST)
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

I have a Fujitsu Lifebook T4210 (very similar to the T4215) and wish
to work on adding support for these models in patch_sigmatel.c.  I
have ran the alsa-info script, once after a fresh boot, and once after
changing the model a few times:

Virgin: http://www.alsa-project.org/db/?f=e76430dbf61b0e2c1ff199c9d1c85051a0341508
With Model Changed:
http://www.alsa-project.org/db/?f=cdd45e343c143052e18f9706e65eef8865696606

After trying various models, I have been unable to get the audio to
output to the correct pin groups.  I have managed to use
hda_analyzer.py to change some of my hardware settings, and have an
idea of what verbs i need to send.  What I need is some information on
the architecture of the driver, or an idea of where to edit things.  I
would just say the config here and ask someone else to edit
patch_sigmatel.c, but this is only the first of the issues I want to
fix, so some knowledge of how to edit myself would be useful.

-- 
John C. Kha
United States Navy
