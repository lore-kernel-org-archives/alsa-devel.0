From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Backported sbxfi driver (UNTESTED!)
Date: Sun, 12 Oct 2008 09:44:37 +0100
Message-ID: <48F1B8F5.4020802@superbug.co.uk>
References: <s5hy70xsl46.wl%tiwai@suse.de>
	<1223583478.5018.0.camel@home>	<s5hbpxt7zui.wl%tiwai@suse.de>
	<1223619975.4700.2.camel@home>	<s5hzlld6j6u.wl%tiwai@suse.de>	<6d00fe310810100939h6cd61e0cg7817c7f54f6261f6@mail.gmail.com>	<s5hfxn3p206.wl%tiwai@suse.de>
	<1223741002.13219.1.camel@home> <s5hmyhbqbqg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-35.mail.demon.net (anchor-post-35.mail.demon.net
	[194.217.242.85])
	by alsa0.perex.cz (Postfix) with ESMTP id 5835324481
	for <alsa-devel@alsa-project.org>;
	Sun, 12 Oct 2008 10:44:58 +0200 (CEST)
In-Reply-To: <s5hmyhbqbqg.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, "Ted T. Logian" <tedtheologian@gmail.com>, The Source <thesourcehim@gmail.com>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> 
> I'm afraid it's UAA (vista-compatible) type.  If so, maybe something
> is wrong in the initialization, or it takes a wrong port address
> (BAR), etc...
> 

The BARs change when one switches from UAA (the default on some cards)
to XFi mode. You will probably have to provide some method for
correcting this after the change.

Kind Regards

James
