From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: aplay hangs with execve("/build/bin/aplay", ["aplay"],
	[/* 8 vars */
Date: Thu, 14 Jun 2007 20:06:36 +0530
Message-ID: <61445c750706140736hb5314a3nc0079f71ca99f426@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.239])
	by alsa0.perex.cz (Postfix) with ESMTP id 2677B103880
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Jun 2007 16:36:38 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id j2so548773nzf
	for <alsa-devel@alsa-project.org>; Thu, 14 Jun 2007 07:36:37 -0700 (PDT)
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

Hi

I am using alsa lib and alsa utils 1.0.14 on my omap based board.
When I try to test my my alsa driver using aplay it just hangs at the very
first step.

The strace output shows nothing else except the following line,

execve("/build/bin/aplay", ["aplay"], [/* 8 vars */

What I am missing?
