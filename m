From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: static /dev configuration
Date: Mon, 19 Mar 2012 09:22:43 +0100
Message-ID: <4F66ECD3.5020406@ladisch.de>
References: <20120319053820.GA14603@gherkin.frus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 3A5F9104002
	for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2012 09:19:20 +0100 (CET)
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 5A4C6211A8
	for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2012 04:19:08 -0400 (EDT)
In-Reply-To: <20120319053820.GA14603@gherkin.frus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bob Tracy <rct@gherkin.frus.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Bob Tracy wrote:
> Does ALSA now require dynamic devices (udev)

It does if the kernel is compiled with CONFIG_SND_DYNAMIC_MINORS.


Regards,
Clemens
