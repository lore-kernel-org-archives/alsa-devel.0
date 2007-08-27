From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Very elementary question regarding period size
Date: Mon, 27 Aug 2007 18:13:08 +0200
Message-ID: <1188231188.14382.1207492269@webmail.messagingengine.com>
References: <61445c750708270319p3ca234dfx965fd5c8d98ca03f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 376871038D8
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Aug 2007 18:13:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <61445c750708270319p3ca234dfx965fd5c8d98ca03f@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Pharaoh ." <pharaoh137@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pharaoh . wrote:
> I am testing out my alsa driver for various period and buffer sizes, at some
> configurations it doesn't work so arises this very basic question.
> 
> Is every sound card/hardware supposed to work at all the period sizes?

No.  The driver is supposed to add constraints that describe the
capabilities of the hardware/driver.

What are the valid period/buffer sizes supported by your driver?


Regards,
Clemens
