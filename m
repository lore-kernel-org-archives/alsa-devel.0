From: chri <chripell@gmail.com>
Subject: Re: [PATCH] ALSA SOC driver for s3c24xx: 8 bit sound
	fix
Date: Mon, 10 Nov 2008 08:20:13 +0100
Message-ID: <cabda6420811092320m41cecd4brd7e20c1ce338957e@mail.gmail.com>
References: <12261302562876-git-send-email-chripell@gmail.com>
	<s5h63mwjcr9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.190])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D46224369
	for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2008 08:20:14 +0100 (CET)
Received: by nf-out-0910.google.com with SMTP id e27so1308642nfd.32
	for <alsa-devel@alsa-project.org>; Sun, 09 Nov 2008 23:20:13 -0800 (PST)
In-Reply-To: <s5h63mwjcr9.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.arm.linux.org.uk, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Mon, Nov 10, 2008 at 7:50 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Sat,  8 Nov 2008 08:44:16 +0100,
>
> I don't think it's good to overwrite the global variables in this way.
>

I see. I just tried to keep the modifications minimal. Perhaps Ben
Dooks, the author of the code, can suggest a better way to proceed. I
will be happy to follow his suggestion.

> And, what if playback and capture use the different formats in full
> duplex streams...?
>

I dont' think that this is possible on the S3C24{1,4}0 since the
configuration registers are shared between playback and record path
(so this applies to sample frequency too for example). I guess you are
suggesting that given parameters should be checked against those of
the currently playing stream to see if they are compatible?


-- 
Christian Pellegrin, see http://www.evolware.org/chri/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."
