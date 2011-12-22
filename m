From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 3.2
Date: Thu, 22 Dec 2011 12:46:56 +0000
Message-ID: <20111222124655.GO4546@opensource.wolfsonmicro.com>
References: <20111222110408.GA8479@opensource.wolfsonmicro.com>
	<CAAQ0ZWSoQJJZv9ReBvHC1FB2EeS_u2V=jDJOguoqNx2cR+1i_g@mail.gmail.com>
	<20111222120246.GM4546@opensource.wolfsonmicro.com>
	<CAAQ0ZWTnMuDCHDQQWg9mvQHTwzm6hJu5TOFvbwc18R5xEhSdiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 09C9010383B
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 13:46:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAAQ0ZWTnMuDCHDQQWg9mvQHTwzm6hJu5TOFvbwc18R5xEhSdiw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 22, 2011 at 08:38:39PM +0800, Shawn Guo wrote:
> On 22 December 2011 20:02, Mark Brown

> > If the API change is only in -next this shouldn't have been applied to
> > the ASoC tree at all. =A0This needs go along with the change that adds =
the
> > new API otherwise you break bisection. =A0Things like this *really* need
> > to be made clear when posting patches.

> I did mention that the patch series addresses the issue seen on -next
> tree in the cover letter.  And I replied your query as below.

You shouldn't rely on cover letters getting noticed, they're too easy to
disassociate from the patch.

> > With patches like this you really need to supply more context - knowing
> > which release the commit you're talking about appears in is useful for
> > exammple,

> This patch only applies to -next, as the offending patch only sits on
> -next.

Yeah, that was after I'd applied the patch.

TBH given that this is an incompatible API change the original patch
relly ought to be updating all users, there shouldn't be separate
patches for the drivers.
