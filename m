From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Accessing alsa device in kernel space.
Date: Sun, 5 Aug 2007 19:11:23 +0300
Message-ID: <200708051911.23667.anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.188])
	by alsa0.perex.cz (Postfix) with ESMTP id B31EE2437F
	for <alsa-devel@alsa-project.org>;
	Sun,  5 Aug 2007 18:10:46 +0200 (CEST)
Received: by mu-out-0910.google.com with SMTP id w8so1579581mue
	for <alsa-devel@alsa-project.org>; Sun, 05 Aug 2007 09:10:45 -0700 (PDT)
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

Hi, how to access to alsa device from kernel space?
I want to create driver for virtual soundcard, that will perform mixing and 
rate converting in kernelspace, and put result in real hardware. But I found 
no documentation how to open alsa device in kernel space :(

Best regards,
Vasily.
