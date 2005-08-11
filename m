From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Re: CVS compile issue
Date: Thu, 11 Aug 2005 16:08:17 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0508111605320.21860-100000@studcom.urz.uni-halle.de>
References: <s5hiryc63fd.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hiryc63fd.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Raymond <rayau@netvigator.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> Raymond wrote:
> >
> > There is a "division by zero" warning for drivers which include
> > "driver.h" on Kernel 2.4
> >
> > /alsa/cvs/alsa-driver/include/adriver.h: In function `jiffies_to_msecs':
> > /alsa/cvs/alsa-driver/include/adriver.h:639: warning: division by zero
>
> Is it the line:
> 	else if (HZ > 1000 && !(HZ % 1000))
> ==>		return (j + (HZ / 1000) - 1)/(HZ / 1000);
>
> ??  Where HZ is defined/declared in your kernel?

The HZ definition is OK.  The problem is that gcc complains even when
the code gets optimized away.

The equivalent code in the 2.6 kernel uses #if, but that wouldn't work
with the SuSE kernels where HZ is a variable.


Regards,
Clemens



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
