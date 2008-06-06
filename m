From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: git workflow for casual developers
Date: Fri, 6 Jun 2008 13:26:28 +0100
Message-ID: <20080606122627.GD24872@sirena.org.uk>
References: <200806051657.22205.linux@audioscience.com>
	<s5hmyly6dlv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D726A24361
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Jun 2008 14:26:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hmyly6dlv.wl%tiwai@suse.de>
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

On Fri, Jun 06, 2008 at 12:51:08PM +0200, Takashi Iwai wrote:
> Eliot Blennerhassett wrote:

> > 1) git-config --add user.email me@domain.com
> > Otherwise commits get spurious email address for Author and Commiter (is there 
> > any way to fix this after the fact?)

> You need to re-commit the patch.  For editing the tip commit log, you
> can use "git-commit --amend".

For non-tip commits the interactive mode of git rebase can be used to do
this - select 'edit' for the commits you want to change.
