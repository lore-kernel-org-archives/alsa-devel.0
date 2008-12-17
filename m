From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ALSA: Add support for TV-out to the
	jack	reporting API
Date: Wed, 17 Dec 2008 14:34:00 +0000
Message-ID: <20081217143358.GC22204@sirena.org.uk>
References: <1229515473-24289-1-git-send-email-ext-jani.1.nikula@nokia.com>
	<s5hd4fr2bcx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id CA23824369
	for <alsa-devel@alsa-project.org>; Wed, 17 Dec 2008 15:34:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hd4fr2bcx.wl%tiwai@suse.de>
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

On Wed, Dec 17, 2008 at 02:13:34PM +0100, Takashi Iwai wrote:
> Jani Nikula wrote:

> > Add support for reporting new jack types SND_JACK_TVOUT and

This might be better as "video" rather than "TV", identifying the type
of video with the descriptive text in the label.

> Well, the patch itself looks good to me, but I'm slowly getting
> nervous about such an addition.

> If any more new jack type will come, it'd be the time to consider
> a better mapping between SW_*_INSERT and SND_JACK_*...

Hrm.  Difficult given that the input side has incrementing numbers
rather than the bitmask...
