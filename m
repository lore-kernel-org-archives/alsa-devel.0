From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH - Fix Fast Track Ultra series: 44.1/88.1
 kHz 1/Fix playback/capture issues and related chrashes at 44100 Hz and
 88200 Hz for M-Audio Fast Track Ultra series.
Date: Thu, 08 Jul 2010 17:19:43 +0200
Message-ID: <4C35EC8F.3000401@ladisch.de>
References: <4C32E3B2.5080707@web.de>	<4C344340.8060804@web.de>	<4C3476BD.4090702@ladisch.de>	<4C347EF7.2030401@web.de>	<4C348DC6.7070602@ladisch.de>	<4C34B177.1090500@web.de>	<4C356F56.6010804@ladisch.de>
	<4C358DC5.4010403@web.de> <4C35CE2A.50806@ladisch.de>
	<4C35EB5A.50304@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id B9B4D2436F
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Jul 2010 17:19:43 +0200 (CEST)
In-Reply-To: <4C35EB5A.50304@web.de>
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
> I guess  there's still something wrong with your debug patch (or me
> applying it...). Doesn't look like any valuable information in syslog
> this time (no fixed_endpoint quirk):

But that part of parse_audio_format_rates_v1 definitely gets executed,
or the kernel wouldn't have crashed previously.

Please make sure that the source code (in alsa-kernel) contains the
print_hex_dump_bytes call, and that it is this driver that gets
loaded.


Regards,
Clemens
