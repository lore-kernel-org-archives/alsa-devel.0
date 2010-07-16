From: Felix Homann <fexpop@web.de>
Subject: Re: [PATCH - Fix Fast Track Ultra series: 44.1/88.1
 kHz 1/Fix playback/capture issues and related chrashes at 44100 Hz and
 88200 Hz for M-Audio Fast Track Ultra series.
Date: Fri, 16 Jul 2010 10:27:16 +0200
Message-ID: <4C4017E4.7000303@web.de>
References: <4C32E3B2.5080707@web.de>
	<4C344340.8060804@web.de>	<4C3476BD.4090702@ladisch.de>
	<4C347EF7.2030401@web.de> <4C348DC6.7070602@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wp188.webpack.hosteurope.de (wp188.webpack.hosteurope.de
	[80.237.132.195])
	by alsa0.perex.cz (Postfix) with ESMTP id 74DFF24399
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Jul 2010 10:27:18 +0200 (CEST)
In-Reply-To: <4C348DC6.7070602@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Felix Homann <fexpop@web.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Am 07.07.2010 16:23, schrieb Clemens Ladisch:
> There must be some difference, and I'd really like to know what it is.
> Please load the driver with the patch below, with and without the
> AUDIO_FIXED_ENDPOINT patch, and show what it prints to the system log.
>
>
> Regards,
> Clemens
>
>

Hi Clemens,

Have you found what's making the AUDIO_FIXED_ENDPOINT necessary? What 
are the chances for the patch to make it into the git repositories 
otherwise?

Kind regards,

Felix
