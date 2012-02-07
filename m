From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Request for help CM109 on arm board
Date: Tue, 07 Feb 2012 22:44:39 +0100
Message-ID: <4F319B47.2080703@ladisch.de>
References: <1328630452.28163.11.camel@jonspc>
	<1328646929.31394.11.camel@jonspc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 5B0FB103CCB
	for <alsa-devel@alsa-project.org>; Tue,  7 Feb 2012 22:45:15 +0100 (CET)
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 6808E20B16
	for <alsa-devel@alsa-project.org>; Tue,  7 Feb 2012 16:45:12 -0500 (EST)
Received: from [192.168.42.121] (unknown [176.1.222.55])
	by mail.messagingengine.com (Postfix) with ESMTPSA id DDC6848247C
	for <alsa-devel@alsa-project.org>; Tue,  7 Feb 2012 16:45:11 -0500 (EST)
In-Reply-To: <1328646929.31394.11.camel@jonspc>
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

Jonathan Andrews wrote:
> ALSA lib timer.c:189:(snd_timer_open_noupdate) Unknown timer hw:CLASS=3,SCLASS=0,CARD=0,DEV=0,SUBDEV=0

> ARM # cat /usr/share/alsa/alsa.conf
> ...

You have deleted alsa-lib's basic device definitions.  Device-specific
definitions are supposed to go into /usr/share/alsa/cards/.  Your
definitions look as if they are supposed to go into /etc/asound.conf.


Regards,
Clemens
