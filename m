From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: ALSA lib troubles with xine
Date: Mon, 03 Sep 2007 10:12:23 +0200
Message-ID: <1188807143.20671.1208584781@webmail.messagingengine.com>
References: <6zk5r8fdev.fsf@odpc25.int.ondemand.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 7AD0624338
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Sep 2007 10:12:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <6zk5r8fdev.fsf@odpc25.int.ondemand.co.at>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Markus Korber <korbse@gmx.at>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Markus Korber wrote:
> I've got problems using ALSA (hg) and xine-lib (1.1.7).  I'm trying to
> use fbxine for playback but ALSA debug logging gives me:
> 
> | Period size range from 0 to 0               <- !!!
> | To choose period_size = 512
> | was set period_size = 0
> | PERIOD_SIZE: 2048

A period size was set, but xine's code that tries to read the period
size apparently doesn't work.

Please check the return values of the *_get_period_size* calls.

> Toolchain: buildroot based arm gcc 4.2.1 with uclibc 0.9.29.

Is it possible that xine-lib and alsa-lib were compiled with different
compiler options, resulting in a different size of snd_pcm_uframes_t?


Regards,
Clemens
