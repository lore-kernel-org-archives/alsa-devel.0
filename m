From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ALSA SOC driver for s3c24xx: 8 bit sound
	fix
Date: Mon, 10 Nov 2008 11:47:50 +0000
Message-ID: <20081110114747.GC12804@sirena.org.uk>
References: <12261302562876-git-send-email-chripell@gmail.com>
	<s5h63mwjcr9.wl%tiwai@suse.de>
	<cabda6420811092320m41cecd4brd7e20c1ce338957e@mail.gmail.com>
	<s5h3ai0jawk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 191B9103897
	for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2008 12:47:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h3ai0jawk.wl%tiwai@suse.de>
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
Cc: chri <chripell@gmail.com>, alsa-devel@alsa-project.org, ben-linux@fluff.org, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 10, 2008 at 08:30:19AM +0100, Takashi Iwai wrote:

> Yes.  Without a proper check and/or hw_param constraints, the driver
> thinks the streams are individual and allows apps to set up
> independent parameters, which may result in a hardware error.

Of course, since the driver isn't doing this yet we probably shouldn't
hold up any other fixes for it - it's needed anyway :/
