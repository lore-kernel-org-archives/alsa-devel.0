From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: salsa error message setting hwparams
Date: Fri, 24 Apr 2009 09:22:01 +0200
Message-ID: <49F16899.6090704@ladisch.de>
References: <bca65b460904231231n6eacecc4l783ba028030d4398@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id E9A1710388A
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Apr 2009 09:21:55 +0200 (CEST)
In-Reply-To: <bca65b460904231231n6eacecc4l783ba028030d4398@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: maarten van es <maarten.h.van.es@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

maarten van es wrote:
> This sytem works fine on a via C7 based pc with via audio. When I try
> an exact copy of the system on an athlon64 based system with a
> HDPS9632 I get this error message.

It's probably that the HDSP does not support the sample format or rate
that you're tryint to use.  Try this tool:
http://article.gmane.org/gmane.linux.alsa.user/32525


HTH
Clemens
