From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ac97_codec.c - unresolved symbol msecs_to_jiffies
 on Kernel 2.4
Date: Tue, 12 Jul 2005 12:54:43 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0507121253250.2200-100000@studcom.urz.uni-halle.de>
References: <42D38196.6020106@netvigator.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42D38196.6020106@netvigator.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Raymond <rayau@netvigator.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Raymond wrote:
> ac97_codec.c:2252: warning: implicit declaration of function
> `msecs_to_jiffies'
>
> http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-kernel/pci/ac97/ac97_codec.c?r1=1.188&r2=1.189

This was caused by a bug in the configure script which has been fixed
now.


HTH
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
