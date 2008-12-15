From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: Fix declaration of sound_class
Date: Mon, 15 Dec 2008 16:05:13 +0000
Message-ID: <20081215160513.GA3782@rakim.wolfsonmicro.main>
References: <1229355823-23640-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5hd4fte8eb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 56E321037ED
	for <alsa-devel@alsa-project.org>; Mon, 15 Dec 2008 17:05:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hd4fte8eb.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 15, 2008 at 04:59:56PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > Include sound/core.h in sound_core.c so that sound_class is declared
> > before it is defined, avoiding it looking like it should be static.

> It's a question whether it should be in linux/sound.h or in
> sound/core.h, but as long as it's declared in the latter file, I
> think it's OK to included it from sound_core.c although it's not
> ALSA-specific.

Yeah, the OSS code doesn't use the prototype from the header at all but
instead has a local prototype in one of their C files which isn't
terribly clever.
