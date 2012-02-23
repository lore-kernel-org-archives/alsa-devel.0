From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Problem with "set_period_size"
Date: Thu, 23 Feb 2012 15:59:44 +0100
Message-ID: <4F465460.4020106@ladisch.de>
References: <CAKjtJDWJSwoO982Hk5hK44khY5Jw=wMrW3QhrincvJ_iTLDGEg@mail.gmail.com>
	<CAKjtJDVC2tZi8FLAo4ADZKr1iB5e0sX9t-jjPQF25F+R0NXBog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 32F2710419D
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 15:57:06 +0100 (CET)
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 3A07920A40
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 09:57:03 -0500 (EST)
In-Reply-To: <CAKjtJDVC2tZi8FLAo4ADZKr1iB5e0sX9t-jjPQF25F+R0NXBog@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alicia Romero <alromor84@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Alicia Romero wrote:
>     stream->pb_frames = (snd_pcm_uframes_t) 640;
>     snd_pcm_hw_params_set_period_size (stream->pb_pcm, params,
>                         &stream->pb_frames, NULL);

You forgot to check the return value.  I'd guess it's -EINVAL.


Regards,
Clemens
