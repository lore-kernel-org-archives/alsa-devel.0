From: "Benjamin van den Hout" <bvdhout@gmail.com>
Subject: Re: Problem with aloop
Date: Tue, 13 May 2008 09:43:36 +0200
Message-ID: <d5eabee70805130043s79f68c8yf5e971d147827360@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.155])
	by alsa0.perex.cz (Postfix) with ESMTP id E573524A8C
	for <alsa-devel@alsa-project.org>;
	Tue, 13 May 2008 09:43:41 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 9so1597942ywk.2
	for <alsa-devel@alsa-project.org>; Tue, 13 May 2008 00:43:36 -0700 (PDT)
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

Well, I discovered that only xinelib has this problem. Xmms and
> alsaplayer, for example, don't have this issue. I am testing VLC and it
> seems to work fine. I am not surprised, since the xine source code that
> deals with alsa is huge and ugly, it must be very hard to mantain that.
>

Thanks for your reply! I did some more testing and I can reproduce it as
well with the 8bit mode, it occurrs less frequently. When I switch back to
16 bit it takes only a few tries with aplay to get the hiccups. So it seems
it is a bit more tricky than I initially thought. Xine can be a strange
beast some times, so that's why I used aplay as well. Anybody have some more
ideas how to tackle this problem or point me in the right direction so I can
solve it myself? It seems I am so close to a working solution...

Kind regards,
Benjamin
