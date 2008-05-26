From: Ben Stanley <Ben.Stanley@exemail.com.au>
Subject: Building alsa drivers as part of alsa vs kernel
	external module
Date: Mon, 26 May 2008 14:48:12 +1000
Message-ID: <1211777292.17410.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.po.exetel.com.au (pecan.exetel.com.au [220.233.0.17])
	by alsa0.perex.cz (Postfix) with ESMTP id B159A24856
	for <alsa-devel@alsa-project.org>;
	Mon, 26 May 2008 06:48:25 +0200 (CEST)
Received: from 168.78.233.220.exetel.com.au ([220.233.78.168]
	helo=[192.168.1.2]) by smtp.po.exetel.com.au with esmtp (Exim 4.68)
	(envelope-from <Ben.Stanley@exemail.com.au>) id 1K0Ud2-0005KO-TW
	for alsa-devel@alsa-project.org; Mon, 26 May 2008 14:48:14 +1000
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

Hi,

I'm trying to compile the AudioScience driver as an external kernel
module (i.e. using the alsa in the kernel, rather than as a module
within the alsa tree).

What source code transformations can I expect to have to make?

Is there some documentation anywhere on what transformations are
performed as standard?

Or is there a proper way that the module should be written so that it
compiles both ways?

Of course, I understand that patches will most likely be required for
the module to compile against older kernels in particular. This kind of
problem is usually dealt with by autoconf. Is there a standard way of
doing this for just compiling a module directly for the kernel? I see
that alsa has its own set of autoconf macros, and when I compile
directly for the kernel (and its embedded alsa) I will lose the benefit
of that.

Ben Stanley.
