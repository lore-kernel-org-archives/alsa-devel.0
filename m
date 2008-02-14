From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: midi problem
Date: Thu, 14 Feb 2008 12:45:16 +0100
Message-ID: <47B429CC.6030605@ladisch.de>
References: <20080214102507.AF98832280E@smtp7-g19.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 87F481038A7
	for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2008 12:43:27 +0100 (CET)
In-Reply-To: <20080214102507.AF98832280E@smtp7-g19.free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: rmgls@free.fr
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

rmgls@free.fr wrote:
> rtc: lost some interrupt at 1024hz

This means that something else prevented the RTC interrupt from being
handled.  Are you running some closed-source driver (graphics or WiFi)?


Regards,
Clemens
