From: Mike Crowe <drmikecrowe@gmail.com>
Subject: Accessing snd_soc_read/snd_soc_write directly for
	diagnostics
Date: Fri, 16 Jul 2010 09:33:25 +0800
Message-ID: <AANLkTimRMrKi-HNOB68jWSiX6TYTuOjRCySAqvRtpWLy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1158F2441D
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Jul 2010 03:33:50 +0200 (CEST)
Received: by gyd10 with SMTP id 10so1084741gyd.38
	for <alsa-devel@alsa-project.org>; Thu, 15 Jul 2010 18:33:49 -0700 (PDT)
Received: by gyd10 with SMTP id 10so1084712gyd.38
	for <alsa-devel@alsa-project.org>; Thu, 15 Jul 2010 18:33:45 -0700 (PDT)
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

Hi folks,

I know this is a strange request, however, for diagnostic purposes in our
embedded system, we would like to talk directly to the codec registers of
our sound chip, bypassing alsa.  I have the driver compiled into the kernel
(not loaded as a module).

Is it possible to create a program which can talk to the snd_soc_read and
snd_soc_write functions directly?  I'm not sure if this is an option, but if
it is, I'd appreciate a pointer to something similar to use as a guide.

TIA
Mike
