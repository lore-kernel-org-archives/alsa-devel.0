From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Problem setting mixer switch with amixer/alsactl.
Date: Fri, 24 Oct 2008 18:25:34 +0100
Message-ID: <20081024172533.GA3328@sirena.org.uk>
References: <48FF7538.3090000@oliford.co.uk>
	<20081023132705.GA20557@sirena.org.uk>
	<4900829A.8000703@oliford.co.uk>
	<20081023140116.GB17901@sirena.org.uk> <87mygvmci7.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 614C3245B6
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Oct 2008 19:26:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <87mygvmci7.fsf@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: alsa-devel@alsa-project.org, Oliver Ford <ipaqlinux@oliford.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 23, 2008 at 07:45:20PM +0200, Robert Jarzmik wrote:
> Mark Brown <broonie@sirena.org.uk> writes:

> > This is normal - shouldn't be an issue except in UI terms, ALSA limits
> > the length of names.

> Mark, I don't think that's true.
> I had that problem several monthes ago (remember my patch about alsa controls
> length ?).

> Do you remember that patch, which went into asoc-v2 ? :

All this patch does is change the limit, there is still a limit on the
length of control names in ALSA but as I say it's purely a cosmetic issue.
