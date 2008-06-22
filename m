From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: asoc-v2 ac97-wm9713 suspend/resume
Date: Sun, 22 Jun 2008 19:41:02 +0200
Message-ID: <87k5ghweoh.fsf@free.fr>
References: <485E890D.2070307@oliford.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6-g19.free.fr (smtp6-g19.free.fr [212.27.42.36])
	by alsa0.perex.cz (Postfix) with ESMTP id 00208247D1
	for <alsa-devel@alsa-project.org>;
	Sun, 22 Jun 2008 19:41:04 +0200 (CEST)
In-Reply-To: <485E890D.2070307@oliford.co.uk> (Oliver Ford's message of "Sun\,
	22 Jun 2008 18\:17\:01 +0100")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Oliver Ford <ipaqlinux@oliford.co.uk>, broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Oliver Ford <ipaqlinux@oliford.co.uk> writes:
> ...

Same questions for me, with a different setup : pxa272 + wm9713.
I have the same issues on the mioa701 board, with same symptoms :
 - snd_soc_suspend_* do not work ATM
 - I had to add a double reset in wm9713 resume() function as you did

> Which am I actually supposed to do, and is there a more 'proper' way way 
> of bringing the wm9713 back up from complete power down on resume?
Even if asoc-v2 is still in development, I have the same concerns. Marc, Liam, any idea ?

--
Robert
