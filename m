From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Problem setting mixer switch with amixer/alsactl.
Date: Fri, 24 Oct 2008 21:32:54 +0100
Message-ID: <20081024203254.GA2544@sirena.org.uk>
References: <48FF7538.3090000@oliford.co.uk>
	<20081023132705.GA20557@sirena.org.uk>
	<4900829A.8000703@oliford.co.uk>
	<20081023140116.GB17901@sirena.org.uk> <87mygvmci7.fsf@free.fr>
	<20081024172533.GA3328@sirena.org.uk> <87ej25ero2.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0D0001037EE
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Oct 2008 22:33:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <87ej25ero2.fsf@free.fr>
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

On Fri, Oct 24, 2008 at 09:09:33PM +0200, Robert Jarzmik wrote:

> If I recall correctly, that name is used in dapm path setup. If the name is
> incorrect (truncated), some dapm elements are not switched on. I'm speaking from
> memory, I'll try to browse my git repository to track it back. Notice that I'm
> really busy ATM, so I don't have enough manpower to test immediatly.

Hrm, that's possible I suppose though I don't recall it being mentioned
at the time and can't see any truncations that would make any difference
for here.

> I'll try to revert my patch and see the effects at the end of the next week.

I should be able to look into this myself on Monday.
