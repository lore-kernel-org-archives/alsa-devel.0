From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: wrong print debugging message code
Date: Mon, 23 Jun 2008 13:17:43 +0100
Message-ID: <20080623121742.GC9318@sirena.org.uk>
References: <280b69ac0806202244s11e74363l4de3f020fed849be@mail.gmail.com>
	<s5habhc4dz6.wl%tiwai@suse.de>
	<20080623111228.GA9318@sirena.org.uk>
	<s5hzlpc2vts.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id BFD0524406
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Jun 2008 14:17:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hzlpc2vts.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Jin-Young Park <mcjin02@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 23, 2008 at 02:13:19PM +0200, Takashi Iwai wrote:

> It depends on your plan.  Definitely nice to fix it for 2.6.27,
> though.

I've actually just written a patch ripping them all out (I'd probably
have submitted it already if I hadn't been reviewing Ben's changes) -
turns out that none of the drivers were actually using their dbg()
macros anyway so it won't have any runtime effect, though obviously a
fix would still be good.
