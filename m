From: Stas Sergeev <stsp@list.ru>
Subject: Re: [patch][saa7134] do not change mute state for
	capturing audio
Date: Sun, 17 Jul 2011 16:24:41 +0400
Message-ID: <4E22D489.7030103@list.ru>
References: <4E19D2F7.6060803@list.ru> <4E1E05AC.2070002@infradead.org>
	<4E1E0A1D.6000604@list.ru> <4E1E1571.6010400@infradead.org>
	<4E1E8108.3060305@list.ru> <4E1F9A25.1020208@infradead.org>
	<4E22AF12.4020600@list.ru> <4E22CCC0.8030803@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.mail.ru (smtp1.mail.ru [94.100.176.129])
	by alsa0.perex.cz (Postfix) with ESMTP id 66C511037EE
	for <alsa-devel@alsa-project.org>;
	Sun, 17 Jul 2011 14:29:28 +0200 (CEST)
In-Reply-To: <4E22CCC0.8030803@infradead.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: Lennart Poettering <lpoetter@redhat.com>, "Nickolay V. Shmyrev" <nshmyrev@yandex.ru>, Devin Heitmueller <dheitmueller@kernellabs.com>, ALSA devel <alsa-devel@alsa-project.org>, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

17.07.2011 15:51, Mauro Carvalho Chehab wrote:
> (Added Lennart to the c/c list)
> If pulseaudio is starting sound capture at startup, then it is either
> a pulseaudio miss-configuration or a bug there.
Why?

> I think that this is not the default for pulseaudio, though, as
> you're the only one complaining about that, and I never saw such
> behavior in the time I was using pulseaudio here.
I've seen such a problem mentioned on the russion
linux resource a few years ago... The reason why it
was never mentioned on that list, is probably that
noone tracked it down to the saa7134_alsa driver yet.
But maybe the reason is different, ok, lets see what
Lennart thinks.
