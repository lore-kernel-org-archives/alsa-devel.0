From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: [patch][saa7134] do not change mute state for
 capturing audio
Date: Tue, 19 Jul 2011 14:25:33 +0200
Message-ID: <20110719122533.GD8224@tango.0pointer.de>
References: <4E19D2F7.6060803@list.ru> <4E1E05AC.2070002@infradead.org>
	<4E1E0A1D.6000604@list.ru> <4E1E1571.6010400@infradead.org>
	<4E1E8108.3060305@list.ru> <4E1F9A25.1020208@infradead.org>
	<4E22AF12.4020600@list.ru> <4E22CCC0.8030803@infradead.org>
	<4E24BEB8.4060501@redhat.com> <4E2524DF.7070502@list.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 07C2C2459B
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Jul 2011 14:26:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E2524DF.7070502@list.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stas Sergeev <stsp@list.ru>
Cc: ALSA devel <alsa-devel@alsa-project.org>, "Nickolay V. Shmyrev" <nshmyrev@yandex.ru>, linux-media@vger.kernel.org, Devin Heitmueller <dheitmueller@kernellabs.com>, Mauro Carvalho Chehab <mchehab@infradead.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 19.07.11 10:31, Stas Sergeev (stsp@list.ru) wrote:

> 2. "Even if it sucks in general". In this case, what solution
> would you propose to get the problem of the white
> noise fixed?

Well, for removing the probing in PA we'd need a way to reliably figure
out in which combinations of input and output we can open a sound
card. i.e. we want to know if we can run surround 5.1 output and spdif
output at the same time, or surround 5.1 output and stereo input and so
on. And we'd need a lot of other attrbites about the sound card, and all
that without having to open any PCM device. 

But that would be really hard to do, the current format neagotiation in
ALSA PCM works very differently. And that's the reason why so far nobody
has bothered with getting this right.

The current code in PA to figure this out is somewhat ugly. It's slow,
since we open the card in a lot of different combinations to test what
works. It's fragile, since if somebody else has opened the soundcard we
get an EBUSY which we take as hint that a specific combination didn't
work, and so on.

It's a hard problem,

Lennart

-- 
Lennart Poettering - Red Hat, Inc.
