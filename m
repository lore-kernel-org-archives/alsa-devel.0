From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: "Resource temporarily unavailable" while reading
	although poll returns POLLIN event
Date: Sat, 24 Apr 2010 09:32:33 +0800
Message-ID: <k2i4f3252891004231832kcd722592hac37a667da424742@mail.gmail.com>
References: <4BCEE140.5060704@gmail.com> <4BCF24AC.3000301@gmail.com>
	<alpine.LNX.2.00.1004211917120.16336@eeebox2.perex-int.cz>
	<4BD02061.2010204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f193.google.com (mail-pz0-f193.google.com
	[209.85.222.193])
	by alsa0.perex.cz (Postfix) with ESMTP id 9F5A61037FE
	for <alsa-devel@alsa-project.org>;
	Sat, 24 Apr 2010 03:32:34 +0200 (CEST)
Received: by pzk31 with SMTP id 31so1859225pzk.16
	for <alsa-devel@alsa-project.org>; Fri, 23 Apr 2010 18:32:33 -0700 (PDT)
In-Reply-To: <4BD02061.2010204@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/4/22 Stefan Schoenleitner <dev.c0debabe@gmail.com>

>
> For testing purposes I increased the period size to 320 so that the
> program works on my hardware sound card "hw".
> It turned out that the program is working fine there and the poll()
> behavior is as it should be.
>
> cheers,
> stefan
>
>
Is it possible to post the output of your program when using your sound card
"hw" since your program failed with XRUN (broken pipe) on my two sound cards
?
