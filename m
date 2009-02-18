From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: longname in sound/core/jack.c
Date: Wed, 18 Feb 2009 14:39:14 +0000
Message-ID: <20090218143913.GB3867@sirena.org.uk>
References: <s5hskmbvp6u.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D18212437C
	for <alsa-devel@alsa-project.org>; Wed, 18 Feb 2009 15:39:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hskmbvp6u.wl%tiwai@suse.de>
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

On Wed, Feb 18, 2009 at 02:40:09PM +0100, Takashi Iwai wrote:

> I'm not sure whether I've already asked it, but I find it ugly to
> refer to card->longname for the input device name in
> sound/core/jack.c.

Yes, it was discussed at the time.  This was chosen because the input
subsystems tends towards the verbose when giving names to devices.

> Can it be changed to card->shortname, at least?

Obviously, it's just a display string.  I think what happened is that
when I checked this on some desktop systems I misread card->id as being
card->shortname in the /proc/asound output.  The former is far too
cryptic to be idiomatic in the input subsystem.
