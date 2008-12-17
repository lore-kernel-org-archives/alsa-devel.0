From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ALSA: Add support for TV-out to the
	jack	reporting API
Date: Wed, 17 Dec 2008 15:59:17 +0000
Message-ID: <20081217155915.GE22204@sirena.org.uk>
References: <1229515473-24289-1-git-send-email-ext-jani.1.nikula@nokia.com>
	<s5hd4fr2bcx.wl%tiwai@suse.de>
	<20081217143358.GC22204@sirena.org.uk>
	<s5hhc5226yh.wl%tiwai@suse.de>
	<20081217150634.GD22204@sirena.org.uk>
	<s5h63li25vc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C84A243D9
	for <alsa-devel@alsa-project.org>; Wed, 17 Dec 2008 16:59:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h63li25vc.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, dmitry.torokhov@gmail.com, Jani Nikula <ext-jani.1.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 17, 2008 at 04:12:07PM +0100, Takashi Iwai wrote:

> If we need to change SND_JACK_* values, then we should do it now
> since 2.6.29 will be the first kernel that uses this API (it exists in
> 2.6.28 but not used).

Ideally, though since this ABI isn't exposed to user space it's not so
critical.  I'm not coming up with any better ideas than yours, though,
so at the minute no change anyway.
