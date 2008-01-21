From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [alsa-cvslog] alsa-driver: Added
	CONFIG_HAVE_INIT_UTSNAME test
Date: Mon, 21 Jan 2008 13:18:01 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0801211316530.12394@tm8103.perex-int.cz>
References: <ALOGGER1200912486.66@alsa-project.org>
	<s5hwsq3e892.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 5A6662448F
	for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2008 13:18:02 +0100 (CET)
In-Reply-To: <s5hwsq3e892.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 21 Jan 2008, Takashi Iwai wrote:

> > +  void *x = init_utsname();
> 
> I'm afraid it won't work.  In C, it's fine to call undeclared
> functions.  It's supposed to be an int function.

Yep, fortunately -Werror helps here ;-) Thanks for notice. I though I 
tested it, but old configure script was left in my testing case.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
