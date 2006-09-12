From: "Takashi Iwai" <tiwai@novell.com>
Subject: Re: 2.6.18-rc6-mm1: endless loop in snd_hda_intel on
	HPC 6325, sometimes
Date: Tue, 12 Sep 2006 14:30:44 +0100
Message-ID: <4506D2A4020000C800009336@emea1-mh.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from emea1-mh.id2.novell.com
	(public.id2-vpn.continvity.gns.novell.com [195.33.99.129])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6604C271
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Sep 2006 15:30:51 +0200 (MEST)
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: rjw@sisk.pl
Cc: akpm@osdl.org, alsa-devel@alsa-project.org, LKML@sc8-sf-spam2.sourceforge.net, linux-kernel@vger.kernel.org, AndrewMorton@sc8-sf-spam2.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>>> "Rafael J. Wysocki" <rjw@sisk.pl> 09/11/06 10:20 PM >>>
> 
> On the HPC 6325 I'm currently using snd_hda_intel sometimes goes into an
> endless loop in wich it plays the same chunk of sound (< 1 sec.) repeatedly
> forever.
> 
> It helps to reload the snd_hda_intel module.

Does this happen with disable_msi=1 or without?
Any relevant kernel messages?

The symptom indicates either an irq problem or a problem of
DMA position reading.  The latter could be fixed via position_fix
module option as Lee suggested...


Takashi


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
