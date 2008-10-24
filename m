From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: Problem setting mixer switch with amixer/alsactl.
Date: Fri, 24 Oct 2008 21:09:33 +0200
Message-ID: <87ej25ero2.fsf@free.fr>
References: <48FF7538.3090000@oliford.co.uk>
	<20081023132705.GA20557@sirena.org.uk>
	<4900829A.8000703@oliford.co.uk>
	<20081023140116.GB17901@sirena.org.uk> <87mygvmci7.fsf@free.fr>
	<20081024172533.GA3328@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp8-g19.free.fr (smtp8-g19.free.fr [212.27.42.65])
	by alsa0.perex.cz (Postfix) with ESMTP id 4034C245FD
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Oct 2008 21:09:53 +0200 (CEST)
In-Reply-To: <20081024172533.GA3328@sirena.org.uk> (Mark Brown's message of
	"Fri\, 24 Oct 2008 18\:25\:34 +0100")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, Oliver Ford <ipaqlinux@oliford.co.uk>
List-Id: alsa-devel@alsa-project.org

Mark Brown <broonie@sirena.org.uk> writes:

> On Thu, Oct 23, 2008 at 07:45:20PM +0200, Robert Jarzmik wrote:
>> Mark Brown <broonie@sirena.org.uk> writes:
> All this patch does is change the limit, there is still a limit on the
> length of control names in ALSA but as I say it's purely a cosmetic issue.

I don't quite agree on the "cosmetic".

If I recall correctly, that name is used in dapm path setup. If the name is
incorrect (truncated), some dapm elements are not switched on. I'm speaking from
memory, I'll try to browse my git repository to track it back. Notice that I'm
really busy ATM, so I don't have enough manpower to test immediatly.

I'll try to revert my patch and see the effects at the end of the next week.

--
Robert
