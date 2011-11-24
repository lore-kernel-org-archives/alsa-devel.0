From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: PCM usage / seg fault in pcm_params.c
Date: Thu, 24 Nov 2011 14:38:03 +0100
Message-ID: <4ECE48BB.4090600@ladisch.de>
References: <CAAs5ODsSYHW7GM8ia050=T0-HSQuGieCRUCnR-nB_t_yWXf9DA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 1DDCF103A90
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 14:37:04 +0100 (CET)
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 8EF6A21556
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 08:37:03 -0500 (EST)
In-Reply-To: <CAAs5ODsSYHW7GM8ia050=T0-HSQuGieCRUCnR-nB_t_yWXf9DA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Borg Onion <borg.onion@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Borg Onion wrote:
> Program terminated with signal 11, Segmentation fault.
>
> Sound card is opened, PCM device is opened,

Is it?

...
Found PCM device #1
Playback=no, Capture=yes, Full Duplex=no
Playback capabilities:
Segmentation fault


Regards,
Clemens
