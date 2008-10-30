From: Oliver Ford <ipaqlinux@oliford.co.uk>
Subject: Re: Problem setting mixer switch with amixer/alsactl.
Date: Thu, 30 Oct 2008 17:47:08 +0000
Message-ID: <4909F31C.7000208@oliford.co.uk>
References: <20081023132705.GA20557@sirena.org.uk>
	<4900829A.8000703@oliford.co.uk>
	<20081023140116.GB17901@sirena.org.uk> <87mygvmci7.fsf@free.fr>
	<20081024172533.GA3328@sirena.org.uk> <87ej25ero2.fsf@free.fr>
	<20081028131031.GG9068@sirena.org.uk>
	<20081028153435.GK9068@sirena.org.uk>
	<49078946.9030003@oliford.co.uk>
	<20081029160451.GD14648@sirena.org.uk>
	<20081030114057.GB5747@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0.thdo.woaf.net (dog.thdo.woaf.net [213.230.192.130])
	by alsa0.perex.cz (Postfix) with ESMTP id 88513244E4
	for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2008 18:47:14 +0100 (CET)
In-Reply-To: <20081030114057.GB5747@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Robert Jarzmik <robert.jarzmik@free.fr>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> Please try this, it resolves the problems I'm seeing here:
>
> commit 9fafa720f6dd4a7a9476bef0d78fee14af401c14
> Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Date:   Thu Oct 30 11:32:47 2008 +0000
>
> ...    

Yes, that seems to fix it.

Thanks for all your efforts in resolving this one.

Oliver
