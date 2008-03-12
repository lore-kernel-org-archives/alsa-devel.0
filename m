From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: aplay doesnt work - new problem`
Date: Wed, 12 Mar 2008 09:34:05 +0100
Message-ID: <47D7957D.2050505@ladisch.de>
References: <61445c750803111605u1c9b8f5ascdee2289c992488a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 7BAB324423
	for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2008 09:32:39 +0100 (CET)
In-Reply-To: <61445c750803111605u1c9b8f5ascdee2289c992488a@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Pharaoh ." <pharaoh137@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pharaoh . wrote:
> I am trying to run my pcm external io type plugin on an arm based board. I
> have no kernel alsa driver
> and the user space plugin is supposed to take care of talking to DSP using
> shared memorty and send sound data.
>
> Since, I dont have kernel space ALSA driver, do I need to enable kernel ALSA
> support in .config?

No.

> ALSA lib conf.c:2852:(snd_config_hook_load) cannot access file
> /home/pharaoh/alsa/cards/aliases.conf

What --*prefix options did you use when configuring alsa-lib?
What did you use as DESTDIR when installing alsa-lib?


Regards,
Clemens
