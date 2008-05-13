From: "Benjamin van den Hout" <bvdhout@gmail.com>
Subject: Re: Problem with aloop
Date: Tue, 13 May 2008 15:27:09 +0200
Message-ID: <d5eabee70805130627v1dd7b675ua4fadc9bd1905357@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 7BC6724B09
	for <alsa-devel@alsa-project.org>;
	Tue, 13 May 2008 15:27:20 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 9so1667855ywk.2
	for <alsa-devel@alsa-project.org>; Tue, 13 May 2008 06:27:09 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Gustavo da Silva Serra wrote:

I had some problems until I could figure it out how to configure alsa
> properly in /etc/asound.conf. Maybe this could be your problem? What is
> your alsa version? I heard that aloop didn't work well until 1.0.15, or
> such (alsa guys: is this true?).
>

My alsa is 1.0.14 but I'm using the 'HG' version of the alsa-drivers and
alsa-kernel packages so that basically gets me the latest-and-greatest
drivers from the source repository if I understand correctly. I saw some
patches coming by in February and they are already in there so I presume I'm
working with the most current source.

I'm intrigued by the asound.conf, is there any specific configuration you
needed to make the aloop device work properly? I'm using the
distro-configured alsa (ubuntu 7.10) and there is no such file somehwere in
/etc. Even on my debian server (running Etch), I can't find it.

Kind regards,
Benjamin
