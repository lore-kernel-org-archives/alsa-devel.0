From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: SPDIF receiver with dynamically changing sample
	rate
Date: Sun, 13 Nov 2011 07:43:30 +0100
Message-ID: <99ff9d69-04dd-4629-b2dd-e205cb2c0640@email.android.com>
References: <loom.20111112T133210-522@post.gmane.org>
	<4EBE926E.8030603@ladisch.de> <4EBEF2C1.2000408@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id EECFB24738
	for <alsa-devel@alsa-project.org>; Sun, 13 Nov 2011 07:41:49 +0100 (CET)
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 997C520804
	for <alsa-devel@alsa-project.org>; Sun, 13 Nov 2011 01:41:47 -0500 (EST)
In-Reply-To: <4EBEF2C1.2000408@freenet.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sam Hawkens <Sam.Hawkens@freenet.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sam Hawkens wrote:
>Some SPDIF receivers have an interrupt output that can be configured to
>be asserted when sample rate changes.

If the driver supports this, it will notify you of changes
of the mixer control that contains the status bits.


Regards,
Clemens
