From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/3] asoc tlv320aic3x
Date: Tue, 29 Apr 2008 19:50:33 +0100
Message-ID: <20080429185032.GA22205@sirena.org.uk>
References: <20080425091714.GA18478@buzzloop.caiaq.de>
	<20080429150315.GA7771@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6ED8D24929
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Apr 2008 20:50:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080429150315.GA7771@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 29, 2008 at 05:03:15PM +0200, Daniel Mack wrote:
> On Fri, Apr 25, 2008 at 11:17:14AM +0200, Daniel Mack wrote:

> > 1/3: revisit clock setup and drop dividers table
> > 2/3: add support for GPIO lines

> After people ACK'd on those two, could they be applied?

I've applied these to the ASoC tree and queued them for Takashi, though
they may not get applied until the merge window is closed.

When submitting patches please always submit the patches in a form that
can be directly applied, including the commit message.  Otherwise it is
much harder to apply the patch since the person applying it needs to
grovel around the mailing list archives for the commit messages.  It is
especially important to ensure that the signed-off-by is included with
each submission of the patch.  It's also a good idea to add any acks
that the patch has been given to the commit message so that people
remember them.

If you want to include additional comments about the changes in a new
revision of the patch please use the --- separator after the commit
message as documented in Documentation/SubmittingPatches or include the
patch plus commit message as an attachment.

Basically, the idea is that someone should be able to apply your patch
using 'git-am --signoff' - if you're using git then the combination of
git format-patch and git send-email will generally do the job.
