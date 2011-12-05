From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA Underrun / Silence playback
Date: Mon, 05 Dec 2011 10:50:59 +0100
Message-ID: <4EDC9403.3080708@ladisch.de>
References: <4EDC674A.4030302@sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 914A0103833
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2011 10:49:17 +0100 (CET)
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id E556621F90
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2011 04:49:15 -0500 (EST)
In-Reply-To: <4EDC674A.4030302@sasken.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Irfan shaikh <irfan.shaikh@sasken.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Irfan shaikh wrote:
> When i do get boundry, i get some weird value 1572864000.

What's weird about this number?

> Thus i tried to use alsa buffer size for threshold

Use the boundary value.


Regards,
Clemens
