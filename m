From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: errors in wm8990 codec driver
Date: Thu, 30 Apr 2009 11:23:01 +0100
Message-ID: <20090430102301.GF10190@sirena.org.uk>
References: <280b69ac0904292203y11c100f8m658a3579c33e8534@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 90E771038BC
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Apr 2009 12:23:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <280b69ac0904292203y11c100f8m658a3579c33e8534@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jinyoung Park <mcjin02@gmail.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 30, 2009 at 02:03:03PM +0900, Jinyoung Park wrote:

> I found a number of typing errors in wm8990 codec driver.
> The mis-typing exist in dapm controller definitions and dapm route definitions,
> so happen mis-matched error when snd_soc_dapm_add_routes().
> Belows are my modified code. Please check...

This all looks reasonable - could you please supply a Signed-off-by for
your patch?  It may also help to use git send-email to send your patch
or attach it, gmail tends to mangle patches so that they can't be
applied and it looks like some of that may have happened here, though
I've not actually tried applying it.
