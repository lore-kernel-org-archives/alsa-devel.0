From: Ben Stanley <Ben.Stanley@exemail.com.au>
Subject: ca0106 SPDIF defaults
Date: Thu, 18 Dec 2008 01:40:47 +1100
Message-ID: <1229524847.13074.148.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.po.exetel.com.au (pecan.exetel.com.au [220.233.0.17])
	by alsa0.perex.cz (Postfix) with ESMTP id AA366243A7
	for <alsa-devel@alsa-project.org>; Wed, 17 Dec 2008 15:40:50 +0100 (CET)
Received: from 168.78.233.220.exetel.com.au ([220.233.78.168]
	helo=[192.168.1.2]) by smtp.po.exetel.com.au with esmtp (Exim 4.68)
	(envelope-from <Ben.Stanley@exemail.com.au>) id 1LCxZv-00017T-3k
	for alsa-devel@alsa-project.org; Thu, 18 Dec 2008 01:40:47 +1100
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

I previously reported problems that are still plaguing me [1] to do with
SPDIF settings that don't reset properly. I am now looking at doing a
patch to the ca0106 driver to fix this problem.

It appears I have to add a new control to be able to set the default
settings. I presume this introduces complications with existing settings
in asound.state? Is there some collected wisdom on how to add new
controls while providing a migration/upgrade/interoperability path?

Ben Stanley.

[1] http://article.gmane.org/gmane.linux.alsa.devel/55406/match=independent+pcm+iec958
