From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Problem setting mixer switch with amixer/alsactl.
Date: Wed, 29 Oct 2008 14:53:30 +0000
Message-ID: <20081029145329.GC14648@sirena.org.uk>
References: <48FF7538.3090000@oliford.co.uk>
	<20081023132705.GA20557@sirena.org.uk>
	<4900829A.8000703@oliford.co.uk>
	<20081023140116.GB17901@sirena.org.uk> <87mygvmci7.fsf@free.fr>
	<20081024172533.GA3328@sirena.org.uk> <87ej25ero2.fsf@free.fr>
	<20081028131031.GG9068@sirena.org.uk>
	<20081028153435.GK9068@sirena.org.uk>
	<49078946.9030003@oliford.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 80CA324447
	for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2008 15:53:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <49078946.9030003@oliford.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Oliver Ford <ipaqlinux@oliford.co.uk>
Cc: alsa-devel@alsa-project.org, Robert Jarzmik <robert.jarzmik@free.fr>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 28, 2008 at 09:51:02PM +0000, Oliver Ford wrote:

> Does that give you any ideas of what happening on my system?

Not more than I had already - that's the lowest level of the symptom,
DAPM doesn't think the speaker mixer has any active inputs so leaves it
and the output path from it off.  Unfortunately I've not been able to
devote my full attention to this yet.
