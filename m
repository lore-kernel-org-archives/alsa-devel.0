From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] AZT3328 driver update (#2)
Date: Fri, 16 Sep 2005 20:55:34 -0400
Message-ID: <1126918534.4986.110.camel@mindpipe>
References: <20050916234828.GA23429@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050916234828.GA23429@rhlx01.fht-esslingen.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: andi@lisas.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 2005-09-17 at 01:48 +0200, Andreas Mohr wrote:
> - FOUND the 1us DirectX timer area (yay!), made the code respect it properly

You should add support for the ALSA timer API if possible, it's actually
quite simple.  This will allow the ALSA sequencer to use it.  See
sound/pci/emu10k1/timer.c for an example.

Lee



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
