From: Timur Tabi <timur@freescale.com>
Subject: kerneldoc for sound drivers?
Date: Thu, 29 Jan 2009 16:47:22 -0600
Message-ID: <ed82fe3e0901291447i14a04c54q24525bddfaa2048d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.150])
	by alsa0.perex.cz (Postfix) with ESMTP id 4940510389C
	for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2009 23:47:23 +0100 (CET)
Received: by qw-out-1920.google.com with SMTP id 9so48141qwj.56
	for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2009 14:47:22 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I'm fixing the comments in my driver (sound/soc/codecs/cs4270.c) to
conform to kerneldoc standards.  However, when I build "make
htmldocs", my comments aren't processed.  I presume the make rules
don't know to look into the sound/soc/codecs directory.  How do I fix
this?

-- 
Timur Tabi
Linux kernel developer at Freescale
