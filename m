From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [2.6.8 bugreport] using mmap with via82cxxx_audio
 causes GPF
Date: Sat, 6 Nov 2004 10:59:11 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0411061052270.15738-100000@studcom.urz.uni-halle.de>
References: <200411060614.52265.greengrass@writeme.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200411060614.52265.greengrass@writeme.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Vladimir Chernyshov <greengrass@writeme.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Vladimir Chernyshov wrote:
> Setting up mmap before setting up speed/format/channels causes shortly
>  afterwards a general protection fault in via82cxxx_audio:

via82cxxx_audio is an OSS driver.  Here on the ALSA list, the only
help we can give you is a recommendation to use ALSA.  ;-)

> Modules linked in: snd_via82xx ... via82cxxx_audio ...

If you compile both OSS and ALSA drivers in, you won't be able to
control which one is actually used.  Configure only one of them.


HTH
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
