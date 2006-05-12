From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: adding support for Edirol UA-101?
Date: Fri, 12 May 2006 20:05:24 +0200
Message-ID: <20060512180524.GA17001@turing.informatik.uni-halle.de>
References: <44635DF4.207@tyrell.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <44635DF4.207@tyrell.hu>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ??kos Mar??y <darkeye@tyrell.hu>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

??kos Mar??y wrote:
> How difficult would it be to add support for the Edirol UA-101 external
> USB audio device to the usb-audio driver?

This device uses high-speed (USB 2.0) transfers and a synchronization
mechanism that isn't covered by the USB Audio specification (that
specification was written before USB 2.0).

The existing infrastructure in the snd-usb-audio driver helps only
partially.  I have started writing a separate driver for this device
(and for the UA-1000 which is similar), but I won't have as much free
time as I'd like in the near future.


Regards,
Clemens


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
