From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Problem with "set_period_size"
Date: Fri, 24 Feb 2012 14:01:18 +0100
Message-ID: <4F478A1E.2040105@ladisch.de>
References: <CAKjtJDWJSwoO982Hk5hK44khY5Jw=wMrW3QhrincvJ_iTLDGEg@mail.gmail.com>
	<CAKjtJDVC2tZi8FLAo4ADZKr1iB5e0sX9t-jjPQF25F+R0NXBog@mail.gmail.com>
	<4F465460.4020106@ladisch.de>
	<CAKjtJDWJMAZA+ekTVmTc0vgg7Jo-3kc4uwSUPCz4KCocM5SRZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id A0CBA104271
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 13:58:42 +0100 (CET)
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 94062206FF
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 07:58:39 -0500 (EST)
In-Reply-To: <CAKjtJDWJMAZA+ekTVmTc0vgg7Jo-3kc4uwSUPCz4KCocM5SRZg@mail.gmail.com>
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
> I forgot to write that at the end I activate all the params using:
>
>     /* Activate the parameters */
>     result = snd_pcm_hw_params (stream->pb_pcm, params);
>     if (result < 0) {

If set_period_size fails, params has not been changed.


Regards,
Clemens
