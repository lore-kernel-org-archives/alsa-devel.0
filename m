From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: aplay patch to add a --seek parameter
Date: Fri, 15 Apr 2011 09:44:47 +0200
Message-ID: <4DA7F76F.5090702@ladisch.de>
References: <m38vvc9ypf.fsf@quimbies.gnus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 2C9FE1037E3
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Apr 2011 09:43:00 +0200 (CEST)
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 7961B21814
	for <alsa-devel@alsa-project.org>; Fri, 15 Apr 2011 03:42:59 -0400 (EDT)
Received: from [10.1.2.56] (unknown [94.101.37.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1F87440A462
	for <alsa-devel@alsa-project.org>; Fri, 15 Apr 2011 03:42:59 -0400 (EDT)
In-Reply-To: <m38vvc9ypf.fsf@quimbies.gnus.org>
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

Lars Magne Ingebrigtsen wrote:
> I'm using aplay in a sound editor to play PCM files.  But I need to be
> able to say "start playing at point X" to be able to skip around in the
> file.
> 
> I've used the following patch for years, but I think I forgot to submit
> it for inclusion into alsa-utils.

Thanks.

Please provide a Signed-off-by tag, document whether this option takes
samples, frames, or (milli)seconds, and add this option to the man page.
Furthermore, the code doesn't look as if it correctly skips over chunks
in VOC files.


Regards,
Clemens
