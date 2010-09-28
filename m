From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: how to mandate the use of PCM plugin?
Date: Tue, 28 Sep 2010 09:01:19 +0800
Message-ID: <AANLkTi=p=-pgNQA8+4Xkq_x0MG64EV4Vt0+ZdFHCizHQ@mail.gmail.com>
References: <4C9F6409.6010400@aknet.ru> <20100927005858.GD21247@sirena.org.uk>
	<4CA0221D.6030208@aknet.ru> <i7qltg$bph$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C74910381C
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Sep 2010 03:01:20 +0200 (CEST)
Received: by ewy21 with SMTP id 21so1618656ewy.38
	for <alsa-devel@alsa-project.org>; Mon, 27 Sep 2010 18:01:19 -0700 (PDT)
In-Reply-To: <i7qltg$bph$1@dough.gmane.org>
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

2010/9/28 Colin Guthrie <gmane@colin.guthr.ie>

> 'Twas brillig, and Stas Sergeev at 27/09/10 05:48 did gyre and gimble:
> >   Hello.
> >
> > 27.09.2010 04:58, Mark Brown wrote:
> >>> Is it possible to somehow mandate the
> >>> use of a PCM plugin? For example, the
> >>> PC-Speaker.conf defines the use of softvol
> >>> plugin for "default" and "front" devices.
>

if snd-pcsp only support mono and the pc speaker is also mono, by removing
"front" device from PC-Speaker.conf will force PA to user "hw"

The point is whether libcanberra ( system event sound) need snd-pcsp to
support stereo

I don't think other media application want to use this beep generator to
play music
