From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA Control Questions (atomicity, error handling)
Date: Fri, 04 Dec 2009 13:33:17 +0100
Message-ID: <4B19018D.4040000@ladisch.de>
References: <4B1803CE.3080501@gmx.de>	<20091203195018.GK14091@buzzloop.caiaq.de>
	<4B18D6DA.6070809@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 8585410389A
	for <alsa-devel@alsa-project.org>; Fri,  4 Dec 2009 13:33:22 +0100 (CET)
In-Reply-To: <4B18D6DA.6070809@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tobias Schneider <tobsnyder@gmx.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Tobias Schneider wrote:
> Another point: I figured out that the "ALSA middlelayer" seems to filter
> the given values of a control. So if the user sets value=1000 where
> maximum is 10, I will get 10 instead of 1000 in the put callback...so
> it's not necessary to check values in those callbacks,

It is, because it is possible to use low-level ALSA functions or to call
the IOCTLs directly, and in this way arbitrary values can reach your
driver's put callback.


Best regards,
Clemens
