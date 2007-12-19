From: Miloslaw Smyk <thorgal@wfmh.org.pl>
Subject: Event notification
Date: Wed, 19 Dec 2007 23:55:43 +0000 (UTC)
Message-ID: <loom.20071219T234825-811@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 9EFD010383E
	for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2007 10:45:29 +0100 (CET)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1J5Hxe-0000Rq-Eo
	for alsa-devel@alsa-project.org; Thu, 20 Dec 2007 09:45:02 +0000
Received: from chello087207253221.chello.pl ([87.207.253.221])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2007 09:45:02 +0000
Received: from thorgal by chello087207253221.chello.pl with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2007 09:45:02 +0000
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

My app needs to know about the events occurring to a sound card. Specifically, I
am interested in start, stop, pause and volume change. While I could monitor
volume by similar means as alsamixer does (is there any doc on this apart from
the source code?), I am not sure if monitoring other events is at all possible.
I would appreciate any suggestions as to how to do this.


Kind Regards,
Milek
