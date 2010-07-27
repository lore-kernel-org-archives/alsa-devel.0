From: dv <dv@pseudoterminal.org>
Subject: detecting the presence of dmix
Date: Tue, 27 Jul 2010 21:22:52 +0200
Message-ID: <4C4F320C.4000700@pseudoterminal.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pseudoterminal.org (pseudoterminal.org [213.239.220.147])
	by alsa0.perex.cz (Postfix) with ESMTP id 61D3E24359
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Jul 2010 21:22:57 +0200 (CEST)
Received: from [192.168.178.14] (85-127-204-87.dynamic.xdsl-line.inode.at
	[85.127.204.87])
	by pseudoterminal.org (Postfix) with ESMTPSA id 008998BCD91
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Jul 2010 21:22:53 +0200 (CEST)
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

is it possible to programmatically detect
whether or not dmix is enabled?

it is important for a software stack where dmix would introduce unwanted 
resampling artifacts
