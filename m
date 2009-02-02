From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [2.6.29-rc3][PATCH] OMAP: ASoC: Fix
	spinlock	misuse in omap-pcm.c
Date: Mon, 2 Feb 2009 22:05:21 +0000
Message-ID: <20090202220520.GB29683@sirena.org.uk>
References: <1233577246-21969-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D5FF9243A6
	for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2009 23:05:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1233577246-21969-1-git-send-email-jarkko.nikula@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: alsa-devel@alsa-project.org, Eero Nurkkala <ext-eero.nurkkala@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 02, 2009 at 02:20:46PM +0200, Jarkko Nikula wrote:
> From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
> 
> omap_pcm_trigger is called also in interrupt context so CPU flags must
> be restored when returning.
> 
> Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
> Acked-by: Jarkko Nikula <jarkko.nikula@nokia.com>

Applied and pushed out to Takashi, thanks.
