From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: More HDA NID / control / proc related changes
Date: Mon, 14 Dec 2009 15:53:13 +0000
Message-ID: <20091214155312.GD1250@sirena.org.uk>
References: <alpine.LNX.2.00.0912081753300.14639@eeebox2.perex-int.cz>
	<alpine.LNX.2.00.0912140943390.2598@eeebox2.perex-int.cz>
	<s5h6389lqdc.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0912141313150.2598@eeebox2.perex-int.cz>
	<s5h3a3dlmqo.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0912141457520.2598@eeebox2.perex-int.cz>
	<s5hy6l5k3x3.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0912141627500.2598@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6137324334
	for <alsa-devel@alsa-project.org>; Mon, 14 Dec 2009 16:53:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0912141627500.2598@eeebox2.perex-int.cz>
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
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 14, 2009 at 04:45:18PM +0100, Jaroslav Kysela wrote:
> On Mon, 14 Dec 2009, Takashi Iwai wrote:

> >> Where's your Signed-off-by: line? You rely on the SCM system to obtain
> >> this information from the 'Merge' commit. I don't think that it's good.

> > This is fully normal.  Do you see sign-off in each pull by Linus?

> Linus should be only exception, because this patch route is quite obvious.

> > Many trees with sub-trees or sub-projects are done in that way.
> > See x86 tree, for example.

> It does not mean that it's the correct way.

It's been discussed relatively often on the lists - the general position
is that so long as the last person to sign off is the person who created
the actual commit everything is fine.  If the commit gets changed (as a
result of a rebase or whatever) then you need to add a new signoff but
otherwise we can be sure that the commit will not have changed since the
SHA1 would change if there were changes so there's no question of any
licensing issues.
