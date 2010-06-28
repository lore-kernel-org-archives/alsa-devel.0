From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] ALSA: pcm_lib: avoid timing jitter in
	snd_pcm_read/write()
Date: Mon, 28 Jun 2010 08:37:07 +0800
Message-ID: <AANLkTimO0L-JL3zVg_ZzU7kWK6ez0CwwlR839K_X7MGz@mail.gmail.com>
References: <1277590400.2438.15.camel@obelisk.thedillows.org>
	<AANLkTil91moJgRh51QFgvSFd47MzQxzxty1H2RzKK5nF@mail.gmail.com>
	<1277648967.2438.32.camel@obelisk.thedillows.org>
	<alpine.LNX.2.00.1006271942500.15497@eeebox2.perex-int.cz>
	<1277678773.2438.103.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id BB44E245A3
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Jun 2010 02:37:09 +0200 (CEST)
Received: by vws11 with SMTP id 11so2640856vws.38
	for <alsa-devel@alsa-project.org>; Sun, 27 Jun 2010 17:37:08 -0700 (PDT)
In-Reply-To: <1277678773.2438.103.camel@obelisk.thedillows.org>
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

2010/6/28 David Dillow <dave@thedillows.org>

>
> Perhaps documentation that recommends setting avail_min to 1 when using
> read/write to avoid this issue would be helpful, in lieu of changing the
> ALSA code or giving concrete guarantees.
>
> Dave
>
>
Refer to
http://article.gmane.org/gmane.linux.alsa.devel/69333/match=avail_min

avail_min cannot be less than period size , however set_avail_min() did not
return any error when the value is less than period size and this mislead
the programmers to believe that they can set avail_min to 1

if you want low latency, you need to use small period size
