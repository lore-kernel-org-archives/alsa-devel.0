From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: PCM playback doesn't work on Toshiba Tecra8100.
Date: Thu, 11 Nov 2004 12:55:42 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0411111252370.14129-100000@studcom.urz.uni-halle.de>
References: <1100170995.2430.32.camel@cancun.hanskramer.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1100170995.2430.32.camel@cancun.hanskramer.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Hans Kramer <Hans.Kramer@xs4all.nl>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hans Kramer wrote:
> Very rarely it happens when I boot up my Toshiba Tecra, the PCM playwork
> works fine. Perhaps, I am ignorant, but couldn't it be a simple
> initialization issue?

Yes, we know it is some kind of initialization issue.  However, nobody
knows what exactly it is that the driver does wrong.

> Any pointers on how to unload the ALSA drivers with rmmod?

rmmod snd-ymfpci

> Also, how can I prevent this module to be loaded in the first
> place. I commented out the lines in /etc/modprobe.conf and
> /etc/sysconfig/hwconf. (again I am using RHFC3)

On very modern system with PCI hotplugging, you have to put the module
name into /etc/hotplug/blacklist.


HTH
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
