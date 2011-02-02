From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: UCM list/set/get
Date: Wed, 02 Feb 2011 20:42:04 +0000
Message-ID: <1296679324.3333.20.camel@odin>
References: <AANLkTi=pwNpK-c+h_xSkiQG8V8nhLZs-9X8+DceDw0S3@mail.gmail.com>
	<20110131112257.GC11937@sirena.org.uk> <1296482038.3316.160.camel@odin>
	<AANLkTinbtXS4G0uHYKiu9RRjP8hVEKY53xn6gzGYLZia@mail.gmail.com>
	<alpine.LNX.2.00.1102020909000.6272@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 7D77224373
	for <alsa-devel@alsa-project.org>; Wed,  2 Feb 2011 21:42:09 +0100 (CET)
Received: by wyi11 with SMTP id 11so384645wyi.38
	for <alsa-devel@alsa-project.org>; Wed, 02 Feb 2011 12:42:08 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1102020909000.6272@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: pl bossart <bossart.nospam@gmail.com>, ALSA development <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Margarita Olaya <magi@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-02-02 at 09:11 +0100, Jaroslav Kysela wrote:
> On Mon, 31 Jan 2011, Margarita Olaya wrote:
> 
> > On Mon, Jan 31, 2011 at 7:53 AM, Liam Girdwood <lrg@slimlogic.co.uk> wrote:

> >>
> >> Margarita, could you provide a link to your PA git.
> >>
> >
> > Here is the link to the  PA git, it has the code that can read the ucm verbs.
> >
> > http://git.slimlogic.co.uk/cgi-bin/cgit.cgi/pulseaudio.git/?h=9.20-ucm
> >
> > If the following ucm command works then you will not have issues with the patch
> >
> > $ alsaucm YOUR_CARD listv
> >
> > Regards,
> > Margarita
> 
> This patch does not use the released UCM API in alsa-lib. 

Margarita was using the earlier version of the alsaucm tool here, and
was using a pre-release UCM branch. Now updated to use the release.

> Also, more work 
> is required to separate ALSA card from UCM card (to support virtual or 
> mixed "soundcards").

Agreed, but Margarita will initially be targeting a simpler system with
one sound card and then move on to support a virtual sound card.

Thanks

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
