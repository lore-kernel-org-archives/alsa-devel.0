From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: alsamixer crashes with SIGFPE
Date: Thu, 18 Feb 2010 09:44:22 +0100
Message-ID: <4B7CFDE6.5080700@ladisch.de>
References: <4B7CFA78.6090104@faberman.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id D7F601038AD
	for <alsa-devel@alsa-project.org>; Thu, 18 Feb 2010 09:44:26 +0100 (CET)
In-Reply-To: <4B7CFA78.6090104@faberman.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Florian Faber <faber@faberman.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Florian Faber wrote:
> there are several spots in alsamixer's mixer_display.c that cause SIGFPE
> through division by zero if (max-min) is zero:
> 
> bar_height = ((volumes[c] - min) * volume_height + max - min - 1) / (max - min);
> value = ((volumes[0] - min) * 100 + (max - min) / 2) / (max - min);

Thanks.  With which hardware do you see this error?


Regards,
Clemens
