From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: maudio ozone driver and evolution uc-33 midi
 controller drv
Date: Fri, 03 Sep 2004 15:12:31 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0409031509100.24397-100000@studcom.urz.uni-halle.de>
References: <4135D899.2030607@chello.sk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <4135D899.2030607@chello.sk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: dbennar <dbennar@chello.sk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

dbennar wrote:
> Iam curious about these drivers, that if anybody is working on it ,

The UC-33 should already work with the standard driver
(snd-usb-audio).

The Ozone isn't supported because of an incompatibility with the USB
standard that triggers a bug in the Linux kernel.  I don't know if or
when this will be resolved.


Regards,
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
