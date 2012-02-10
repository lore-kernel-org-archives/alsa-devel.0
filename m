From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: system announce port documentation
Date: Fri, 10 Feb 2012 16:02:02 +0100
Message-ID: <4F35316A.6030709@ladisch.de>
References: <20120210134216.GA2949@studio>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 6BED3243ED
	for <alsa-devel@alsa-project.org>; Fri, 10 Feb 2012 16:00:09 +0100 (CET)
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 0858B20CC5
	for <alsa-devel@alsa-project.org>; Fri, 10 Feb 2012 09:59:59 -0500 (EST)
In-Reply-To: <20120210134216.GA2949@studio>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lieven Moors <lievenmoors@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Lieven Moors wrote:
> I have been searching in vain for info or examples on how
> to use the system announce port of alsa sequencer.

This port sends events when client or ports are created/
removed/changed.  Use aseqdump to see what gets sent.


Regards,
Clemens
