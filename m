From: Luke Yelavich <themuso@ubuntu.com>
Subject: Re: Clarrification about the alsa volume init
	framework.
Date: Tue, 24 May 2011 08:40:07 +1000
Message-ID: <20110523224007.GA3214@strigy.yelavich.home>
References: <20110510064833.GB5736@acapella.yelavich.home>
	<s5hiptj6n2f.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nskntmtas04p.mx.bigpond.com (nskntmtas04p.mx.bigpond.com
	[61.9.168.146]) by alsa0.perex.cz (Postfix) with ESMTP id 22460244E9
	for <alsa-devel@alsa-project.org>;
	Tue, 24 May 2011 00:40:11 +0200 (CEST)
Received: from nskntotgx02p.mx.bigpond.com ([58.160.38.86])
	by nskntmtas04p.mx.bigpond.com with ESMTP id
	<20110523224008.KAEU1385.nskntmtas04p.mx.bigpond.com@nskntotgx02p.mx.bigpond.com>
	for <alsa-devel@alsa-project.org>; Mon, 23 May 2011 22:40:08 +0000
Received: from localhost ([58.160.38.86]) by nskntotgx02p.mx.bigpond.com
	with ESMTP
	id <20110523224007.SDQB29310.nskntotgx02p.mx.bigpond.com@localhost>
	for <alsa-devel@alsa-project.org>; Mon, 23 May 2011 22:40:07 +0000
Content-Disposition: inline
In-Reply-To: <s5hiptj6n2f.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 10, 2011 at 05:18:16PM EST, Takashi Iwai wrote:
> alsactl init should be able to handle different hardware, in general.
> Though, the current file handling (reading all explicitly from 00main)
> doesn't look good for easy extensions.  If you want to add a new h/w-
> specific init file, you'll need to modify 00main as well.  It'd be
> better to look up all files (preferably with some extension like
> "*.conf") in a directory, so that we need to just put a new file for a
> new init quirk.
> 
> I know there are possibilities in preinit/* and postinit/*, but then I
> see no reason why main directory isn't managed in that way.
> 
> Jaroslav, what do you think?

Just bringing this up to the top of the pile again, as I'd like to start moving one way or another on this, so I can get testing from users.

Thanks

Luke
