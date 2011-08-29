From: Raymond Toy <rtoy@google.com>
Subject: Re: Alsa timing question
Date: Mon, 29 Aug 2011 13:24:14 -0700
Message-ID: <CAE3TgXHTshARnB8oYssGnU4gD1K1jCa2J-VX0OGhuqZ375RQAQ@mail.gmail.com>
References: <CAE3TgXE3g9n92Xru_6Znk00rfDdF5OSMXaTiquU=ne5NLrOkOg@mail.gmail.com>
	<4E55F6A2.3040307@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out.google.com (smtp-out.google.com [74.125.121.67])
	by alsa0.perex.cz (Postfix) with ESMTP id E9499244C8
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Aug 2011 22:24:20 +0200 (CEST)
Received: from hpaq6.eem.corp.google.com (hpaq6.eem.corp.google.com
	[172.25.149.6]) by smtp-out.google.com with ESMTP id p7TKOGDp016836
	for <alsa-devel@alsa-project.org>; Mon, 29 Aug 2011 13:24:16 -0700
Received: from fxbb27 (fxbb27.prod.google.com [10.184.28.27])
	by hpaq6.eem.corp.google.com with ESMTP id p7TKOFHY020755
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <alsa-devel@alsa-project.org>; Mon, 29 Aug 2011 13:24:15 -0700
Received: by fxbb27 with SMTP id b27so5286730fxb.4
	for <alsa-devel@alsa-project.org>; Mon, 29 Aug 2011 13:24:15 -0700 (PDT)
In-Reply-To: <4E55F6A2.3040307@ladisch.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In theory, when the device is configured for a specific period size, its
> interrupts (and therefore the application wakeups) will arrive spaced at
> this interval (modulo any scheduling delays).
>
> However, if you're using the dmix plugin, the period size of your
> application's device will not necessarily be identical with the period
> size of the hardware device.  To see the actual period size, look into
> /proc/asound/card?/pcm0p/sub0/hw_params.
>

Would dmix allow me to control this better than pulse audio? (I'm still
looking into how to get pulse audio to do what I want.)

Ray
