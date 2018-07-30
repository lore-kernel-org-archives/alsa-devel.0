From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH v0 3/3] ASoC: max9867: Fix volume controls
Date: Mon, 30 Jul 2018 12:45:03 +0200
Message-ID: <20180730104503.GA7186@lenoch>
References: <20180728154134.GA9665@lenoch> <20180728154415.GD9665@lenoch>
 <20180730101115.GD5789@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 93BEF2673A0
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2018 12:45:10 +0200 (CEST)
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23992363AbeG3KpJukGzL (ORCPT
 <rfc822;alsa-devel@alsa-project.org>);
 Mon, 30 Jul 2018 12:45:09 +0200
Content-Disposition: inline
In-Reply-To: <20180730101115.GD5789@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, anish kumar <yesanishhere@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 30, 2018 at 11:11:15AM +0100, Mark Brown wrote:
> On Sat, Jul 28, 2018 at 05:44:15PM +0200, Ladislav Michl wrote:
> > Build proper audio paths and fix volume controls to match datasheet.
> 
> This sounds like it should be split up into separate patches for at
> least the routing and volume control stuff.  It also needs a bit of a
> better changelog as I'm not sure what the issues with the volume
> controls were or what was improper about the old audio paths.

Oh well, will do. Perhaps driver author wants to step in and describe
setup driver was tested with. This is not meant as an offense, but
it does really look like code was copied over from other drivers
(sometimes without renaming) until it compiled and then submitted.
As it is I'm unable to play or record anything as power domains
are not enabled, but there still is a chance I'm doing something
wrong.

> > Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> > ---
> >  I'm still unsure about control names, please see yet unaswered mail
> >  here: https://www.spinics.net/lists/alsa-devel/msg80006.html
> 
> Always CC maintainers on mails - you really shouldn't rely on anyone
> seeing anything that only goes to the lists, they're quite high volume.

Well, in this case I decided to sent general question to the list in a
hope anyone with enough knowledge could answer that... But point taken,
will Cc maintaniners next time.
