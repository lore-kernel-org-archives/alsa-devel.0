From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: GIT: something wrong with sound-2.6/devel?
Date: Mon, 21 Jul 2008 10:51:22 +0100
Message-ID: <20080721095119.GD7083@sirena.org.uk>
References: <48844CA9.9060408@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 628FF103856
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Jul 2008 11:51:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48844CA9.9060408@keyaccess.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 21, 2008 at 10:45:29AM +0200, Rene Herman wrote:

> rene@7ixe4:~/src/linux/7ixe4$ git fetch tiwai
>  From git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6
>   ! [rejected]        devel      -> tiwai/devel  (non fast forward)
>   ! [rejected]        dma-fix    -> tiwai/dma-fix  (non fast forward)
>   ! [rejected]        master     -> tiwai/master  (non fast forward)

> I'll go ask on the GIT list what this might be about...

This means that the git remote is configured to only pull fast forwards
from that repository.  Add a + to the 'fetch =' for it in .git/config
and it'll track non-linear updates like you get when the remote rebases.
