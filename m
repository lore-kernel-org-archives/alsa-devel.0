From: Oliver Ford <ipaqlinux@oliford.co.uk>
Subject: Re: asoc-v2 ac97-wm9713 suspend/resume
Date: Sun, 22 Jun 2008 18:55:26 +0100
Message-ID: <485E920E.5050601@oliford.co.uk>
References: <485E890D.2070307@oliford.co.uk> <87k5ghweoh.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0.thdo.woaf.net (dog.thdo.woaf.net [213.230.192.130])
	by alsa0.perex.cz (Postfix) with ESMTP id 2A696243F3
	for <alsa-devel@alsa-project.org>;
	Sun, 22 Jun 2008 19:55:29 +0200 (CEST)
In-Reply-To: <87k5ghweoh.fsf@free.fr>
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
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Robert Jarzmik wrote:
>  - I had to add a double reset in wm9713 resume() function as you did
>
>   
Does this actually work for you?

I forgot to say, for me it allows the touchscreen to work, and 'amixer 
cset xxx xxx' commands seem to make things click, but I get no sound 
from aplay where I do before the suspend.

Oliver
