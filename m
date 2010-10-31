From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [RFC_i/iv 3/3] ASoC: Decouple DAPM from CODECs.
 Part platforms (will be squashed)
Date: Sun, 31 Oct 2010 20:11:17 +0200
Message-ID: <20101031201117.edea7bbe.jhnikula@gmail.com>
References: <1288353618-21753-1-git-send-email-jhnikula@gmail.com>
	<1288353618-21753-4-git-send-email-jhnikula@gmail.com>
	<20101029204725.GF3921@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id C0D8024152
	for <alsa-devel@alsa-project.org>; Sun, 31 Oct 2010 19:09:55 +0100 (CET)
Received: by ewy22 with SMTP id 22so2430208ewy.38
	for <alsa-devel@alsa-project.org>; Sun, 31 Oct 2010 11:09:55 -0700 (PDT)
In-Reply-To: <20101029204725.GF3921@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, 29 Oct 2010 13:47:26 -0700
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> On Fri, Oct 29, 2010 at 03:00:18PM +0300, Jarkko Nikula wrote:
> > This patch de-couples DAPM from the CODEC in order for other components to
> > have DAPM widgets.
> 
> > Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> 
> I suspect this also needs squashing in with the previous patch.  If
> we're going to split the series it'd be better to split things to move
> field by field rather than introduce bisection issues like this.

Yep, the first RFC_i/iv was splitted mainly by the author to show what
parts were from Liam and what from me. Sorry not being verbose enough
that these were not meant to be independent patches like the patches in
later sets.

I'd expect when the RFC_i/iv is ready, Liam will send it out so that
kudos go to the right person who made the core implementation :-)


-- 
Jarkko
