From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.34-rc1: regression: ^Z no longer stops sound
Date: Mon, 15 Mar 2010 08:41:32 +0100
Message-ID: <20100315074132.GB8886@atrey.karlin.mff.cuni.cz>
References: <20100314075831.GA13457@elf.ucw.cz> <s5hhboijb83.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atrey.karlin.mff.cuni.cz (ksp.mff.cuni.cz [195.113.26.206])
	by alsa0.perex.cz (Postfix) with ESMTP id 59D491037F7
	for <alsa-devel@alsa-project.org>; Mon, 15 Mar 2010 08:41:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hhboijb83.wl%tiwai@suse.de>
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
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, alsa-devel@alsa-project.org, kernel list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

> At Sun, 14 Mar 2010 08:58:31 +0100,
> Pavel Machek wrote:
> > 
> > Hi!
> > 
> > In 2.6.33, hitting ^Z stopped mpg123 in a way you'd expect (both on
> > thinkpad and geode notebook).
> > 
> > On 2.6.34-rc1, hit ^Z and sound starts looping.
> 
> Is it an OSS app using the kernel OSS emulation or another backend?

OSS kernel emulation, yes. ... at least I think I'm using it.

> The possible cause is the rewrite of PCM hwptr updater.
> Jaroslav, could you take a look?

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
