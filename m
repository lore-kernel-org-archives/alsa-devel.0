From: "christian pellegrin" <chripell@gmail.com>
Subject: Re: [PATCH 2/4] ASoC: s3c24xx 8 bit sound fix
Date: Wed, 12 Nov 2008 18:29:47 +0100
Message-ID: <cabda6420811120929w203186fas8ae52d5966480bc3@mail.gmail.com>
References: <20081112115507.GA22288@rakim.wolfsonmicro.main>
	<1226490949-22360-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1226490949-22360-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20081112141902.GA15238@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.251])
	by alsa0.perex.cz (Postfix) with ESMTP id C0EAF1037F1
	for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2008 18:29:48 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id f25so478387rvb.32
	for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2008 09:29:47 -0800 (PST)
In-Reply-To: <20081112141902.GA15238@trinity.fluff.org>
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
To: Ben Dooks <ben-linux@fluff.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 12, 2008 at 3:19 PM, Ben Dooks <ben-linux@fluff.org> wrote:

>
> Is playing with the dma parameters like that the correct way?
>

Well this worked for me. I'm opened to better solutions and to resend
a patch but it's no clear to me how to proceed.

Out of curiosity I did a search in Openmoko if someone noticed the
same problem and found some people that had 8 bit ringtones sounding
awful on the neo/forerunner. But they just resampled them to 16bit
44khz and lived happy. Unfortunately for consultants there is always
the customer that wants to play that old 8-bit 11khz wav with the
vocal announcement from 10 year ago.

-- 
Christian Pellegrin, see http://www.evolware.org/chri/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."
