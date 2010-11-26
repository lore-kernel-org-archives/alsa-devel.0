From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Linux USB audio driver - sample code / link
	/	documentation
Date: Fri, 26 Nov 2010 08:51:22 +0100
Message-ID: <4CEF66FA.3090405@ladisch.de>
References: <AANLkTi=R_2dPhOGCB+5Dv_KUG3PrESg+Z+x1A_bhiTjr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 09090103CC6
	for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2010 08:49:17 +0100 (CET)
In-Reply-To: <AANLkTi=R_2dPhOGCB+5Dv_KUG3PrESg+Z+x1A_bhiTjr@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ramya Desai <ramya.desai@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ramya Desai wrote:
> I did not find a document for writing a USB audio driver under Linux
> environment. Please let me know any sample driver / link / document
> which describes about the USB audio driver under Linux environment.

The simplest sample driver is this one:
http://www.alsa-project.org/~clemens/ua1a.patch

If your device were class compliant, it would be supported by the
standard driver.


Regards,
Clemens
