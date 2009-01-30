From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Firmware
Date: Fri, 30 Jan 2009 14:18:12 +0100
Message-ID: <4982FE14.4080005@ladisch.de>
References: <00032557558a00941e0461a4cdc3@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 8BB0B24422
	for <alsa-devel@alsa-project.org>; Fri, 30 Jan 2009 14:18:14 +0100 (CET)
In-Reply-To: <00032557558a00941e0461a4cdc3@google.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: soundprizm@gmail.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

soundprizm@gmail.com wrote:
> Is ALSA Firmware written by alsa developers or obtained from the
> hardware's manufacturer?

Yes.

> If it is obtained from the manufacturer, what is exactly required to
> have the .ihx files created ...?

objcopy -I binary -O ihex something.bin something.ihx


HTH
Clemens
