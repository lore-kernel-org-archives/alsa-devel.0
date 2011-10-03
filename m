From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Event flood on USB disconnect
Date: Mon, 03 Oct 2011 23:50:41 +0200
Message-ID: <4E8A2E31.2080002@ladisch.de>
References: <1317459007.6559.18.camel@snowflake>
	<4E89741B.3050602@colin.guthr.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 103B810394A
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Oct 2011 23:51:19 +0200 (CEST)
In-Reply-To: <4E89741B.3050602@colin.guthr.ie>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Colin Guthrie <gmane@colin.guthr.ie>
Cc: Arun Raghavan <arun.raghavan@collabora.co.uk>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Colin Guthrie wrote:
> Would a POLLERR|POLLNVAL be received any time
> when normal operations will continue afterwards? e.g. should we use this
> error as an indicator to ignore it forever or, e.g., just for a finite
> period of time like 1s.

POLLERR means that the PCM device is in a state where it cannot transfer
data.  This typically happens on an xrun or when the device is unplugged,
if the first system call after that event is poll() and not write().
The error handling should be the same (snd_pcm_prepare(), which might
fail).

A disconnected device returns POLLERR|POLLNVAL, while any other error
state returns POLLOUT|POLLERR.


Regards,
Clemens
