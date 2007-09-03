From: Markus Korber <korbse@gmx.at>
Subject: Re: ALSA lib troubles with xine
Date: Mon, 03 Sep 2007 11:07:37 +0200
Message-ID: <6zlkboce1y.fsf@odpc25.int.ondemand.co.at>
References: <6zk5r8fdev.fsf@odpc25.int.ondemand.co.at>
	<1188807143.20671.1208584781@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 7CBFF24341
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Sep 2007 11:07:39 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Thus spake Clemens Ladisch:

> Markus Korber wrote:
>> I've got problems using ALSA (hg) and xine-lib (1.1.7).  I'm trying to
>> use fbxine for playback but ALSA debug logging gives me:
>
>> | Period size range from 0 to 0               <- !!!
>> | To choose period_size = 512
>> | was set period_size = 0
>> | PERIOD_SIZE: 2048
>
> A period size was set, but xine's code that tries to read the period
> size apparently doesn't work.
>
> Please check the return values of the *_get_period_size* calls.

All calls succeeded.

Regards,
Markus Korber
