From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Shutdown() vector in ALSA
Date: Tue, 12 Jun 2007 11:27:19 +0100
Message-ID: <466E7507.6060101@superbug.co.uk>
References: <8d6898730706120156v6e8e95c6xb2d3878078465f08@mail.gmail.com>	
	<s5hwsy9pmfa.wl%tiwai@suse.de> <466E644C.4030405@superbug.co.uk>	
	<s5htztdpm11.wl%tiwai@suse.de>
	<8d6898730706120257u155e0124k75f6e00f19c0e996@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-30.mail.demon.net (anchor-post-30.mail.demon.net
	[194.217.242.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 9227F103840
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Jun 2007 12:28:02 +0200 (CEST)
In-Reply-To: <8d6898730706120257u155e0124k75f6e00f19c0e996@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nobin Mathew <nobin.mathew@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

Nobin Mathew wrote:
> In ubuntu this script mutes all mixer controls.
> 
> So there will be no noise (pop/clicks) during shutdown.
> 

That is not always true. Sound cards can still pop/clicks on power down,
even with muted mixer controls.

James
