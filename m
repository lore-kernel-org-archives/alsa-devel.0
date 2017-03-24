From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] ASoC: jack - check status of GPIO-based
	pins on resume
Date: Fri, 24 Mar 2017 12:22:09 -0700
Message-ID: <20170324192209.GB18364@dtor-ws>
References: <20170321235043.GA9831@dtor-ws>
 <20170324185147.rwbi2qqynr2yggq2@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f68.google.com (mail-pg0-f68.google.com [74.125.83.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 606CF2669DD
 for <alsa-devel@alsa-project.org>; Fri, 24 Mar 2017 20:22:13 +0100 (CET)
Received: by mail-pg0-f68.google.com with SMTP id w20so2099870pgc.1
 for <alsa-devel@alsa-project.org>; Fri, 24 Mar 2017 12:22:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170324185147.rwbi2qqynr2yggq2@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 24, 2017 at 06:51:47PM +0000, Mark Brown wrote:
> On Tue, Mar 21, 2017 at 04:50:43PM -0700, Dmitry Torokhov wrote:
> > From: Dmitry Torokhov <dtor@chromium.org>
> > 
> > For GPIO-backed pins that are not configured as wakeup sources, we may
> > miss change in their state that happens while system is suspended. Let's
> > use PM notifier to refresh their state upon resume.
> > 
> > Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
> > ---
> 
> Please send patches from the mail account corresponding to the signoff,
> not doing that makes the patch look like it's missing a signoff (as it's
> got the From line so more than one signoff is expected but there's only
> one) which slows down review.

Resent from @chromium.

-- 
Dmitry
