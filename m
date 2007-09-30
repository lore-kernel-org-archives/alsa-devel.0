From: Stas Sergeev <stsp@aknet.ru>
Subject: Re: nforce ac97 plays too fast
Date: Sun, 30 Sep 2007 14:12:07 +0400
Message-ID: <46FF7677.8070304@aknet.ru>
References: <46FE0428.1070501@aknet.ru>
	<75b66ecd0709291851g47007518n48035588b5ffecef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.AKNET.ru [77.246.241.226])
	by alsa0.perex.cz (Postfix) with ESMTP id B234324579
	for <alsa-devel@alsa-project.org>;
	Sun, 30 Sep 2007 12:12:11 +0200 (CEST)
In-Reply-To: <75b66ecd0709291851g47007518n48035588b5ffecef@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello.

Lee Revell wrote:
> What ALSA tutorial are you looking at?
This one:
http://equalarea.com/paul/alsa-audio.html
But now I noticed that it passes the rate
as an integer, not as a pointer, so it might
be somehow outdated...
Nevertheless, libao doesn't check, which
is a problem.

> Direction is just a hint.
> http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m___h_w___params.html#ga3602c3c8912acf66c4db29f96608021
It says:
---
target/chosen exact value is <,=,> val following dir (-1,0,1)
---
Cannot parse, what does this mean?
Does this mean that dir is only set by
the call, and its initial value does not
matter? But it doesn't seem to be the
case either. No matter what value I set
the dir to, the rate is being set to 48000,
and the dir is set to 0.
Is this really an expected result?
If the initial value of dir is not counted
and the new value is always 0, then why
this parameter is needed at all?

> For example:
Yes, they seem to check the rate. But then
I don't understand what does this "dir" stand
for... And I guess the libao developers had
the same question. :)
