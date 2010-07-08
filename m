From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH - Fix Fast Track Ultra series: 44.1/88.1
 kHz 1/Fix playback/capture issues and related chrashes at 44100 Hz and
 88200 Hz for M-Audio Fast Track Ultra series.
Date: Thu, 08 Jul 2010 15:10:02 +0200
Message-ID: <4C35CE2A.50806@ladisch.de>
References: <4C32E3B2.5080707@web.de>	<4C344340.8060804@web.de>	<4C3476BD.4090702@ladisch.de>	<4C347EF7.2030401@web.de>
	<4C348DC6.7070602@ladisch.de>	<4C34B177.1090500@web.de>
	<4C356F56.6010804@ladisch.de> <4C358DC5.4010403@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 1894324421
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Jul 2010 15:10:08 +0200 (CEST)
In-Reply-To: <4C358DC5.4010403@web.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Felix Homann <fexpop@web.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Felix Homann wrote:
> I've attached the excerpts from /var/log/syslog with and without the 
> FIXED_ENDPOINT quirk.

> BUG: unable to handle kernel NULL pointer dereference

Sorry, the call for the case without the fixed quirk is buggy.
In line 199 of format.c, please change "fp->rates" to "fp->rate_table".


Regards,
Clemens
