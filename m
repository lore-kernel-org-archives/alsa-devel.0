From: Torrey Hoffman <thoffman@arnor.net>
Subject: Re: ALSA doesn't work with XMMS
Date: Tue, 20 Jan 2004 12:55:56 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1074632156.14457.2.camel@moria.arnor.net>
References: <1074549141.22882.71.camel@moria.arnor.net>
	 <400D7987.3030702@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from devil.servak.biz (devil.servak.biz [209.124.81.2])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id VAA29293
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2004 21:59:59 +0100
In-Reply-To: <400D7987.3030702@gmx.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Klaus-Peter Schrage <kpschrage@gmx.de>
Cc: ALSA Development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2004-01-20 at 10:55, Klaus-Peter Schrage wrote:
> Torrey Hoffman wrote:
> 
> > If I configure the XMMS ALSA plugin to use the "plughw:0:0" device, it
> > opens the device and begins playback, but I just get noise... a
> > repetitive burst like a stuck CD player.
> 
> Others (and me) on the alsa-user list have reported this noise too with 
> alsa 1.0.1, a 2.6 kernel and the ice1712 driver.
> What about you when using the old driver that's inside the vanilla 2.6.1 
> kernel (0.9.7)? I don't have this noise then.

Thanks for the tip!  I am installing 2.6.1-vanilla now.  In the
meantime, I can verify that the ALSA ice1712 driver DOES work in my old
2.4.22-1.2115.nptlsmp kernel (Fedora Core 1) using the
"alsa-driver-1.0.1-2.fr" kernel driver package RPM set from FreshRPMs.

So there seems to be a new bug which has been introduced in the latest
ALSA updates in the -mm kernels.

Torrey

> Klaus
> 
> 
> 
> -------------------------------------------------------
> The SF.Net email is sponsored by EclipseCon 2004
> Premiere Conference on Open Tools Development and Integration
> See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
> http://www.eclipsecon.org/osdn
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
-- 
Torrey Hoffman <thoffman@arnor.net>



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
