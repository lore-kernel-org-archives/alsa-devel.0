From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: wrong print debugging message code
Date: Mon, 23 Jun 2008 12:12:28 +0100
Message-ID: <20080623111228.GA9318@sirena.org.uk>
References: <280b69ac0806202244s11e74363l4de3f020fed849be@mail.gmail.com>
	<s5habhc4dz6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A4F19248A3
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Jun 2008 13:12:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5habhc4dz6.wl%tiwai@suse.de>
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

On Mon, Jun 23, 2008 at 12:55:57PM +0200, Takashi Iwai wrote:

> The confusing thing is that it defines to '0' (and I'm not sure the
> debug is activated as default in the current code -- Mark, Liam, is it
> intentional?).

I doubt it.

> IMO, the debug should be basically off as default, and if enabled, it
> should be defined to '1'.

Really they should all just be deleted and replaced by the standard
pr_() macros but if we wait for v2 then we'd be able to use the dev_()
variants instead.
