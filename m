From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: question : crash between kernel i2c and alsa i2c
Date: Mon, 13 Jun 2005 14:06:50 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0506131405360.3581@pnote.perex-int.cz>
References: <42AD5670.6070900@avantwave.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B61DB1A3
	for <alsa-devel@alsa-project.org>; Mon, 13 Jun 2005 14:06:51 +0200 (MEST)
In-Reply-To: <42AD5670.6070900@avantwave.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Tomko <tomko@avantwave.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 13 Jun 2005, Tomko wrote:

> Hi everyone,
> 
> I know that there is a tiny i2c subsystem inside alsa , i would like to 
> know is there any control betwen the kernel i2c subsystem and the alsa 
> i2c ?  Will there any crashes if two i2c access the bus togethre ?

It will not work, because there must be only one arbiter maintaining 
locking and exclusive access for the i2c bus.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
