From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Audigy 4 - mic
Date: Thu, 09 Nov 2006 18:34:57 +0000
Message-ID: <455374D1.3080405@superbug.co.uk>
References: <1162578106.2781.6.camel@localhost.localdomain>	
	<454C943B.2070603@superbug.co.uk> <454E4D35.8010200@superbug.co.uk>
	<1162833115.2773.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from anchor-post-31.mail.demon.net (anchor-post-31.mail.demon.net
	[194.217.242.89])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2BE042B4
	for <alsa-devel@alsa-project.org>; Thu,  9 Nov 2006 19:34:58 +0100 (MET)
In-Reply-To: <1162833115.2773.9.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Peter Zubaj <pzubaj@gaya.sk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Peter Zubaj wrote:
> Hi,
> 
> You are still creating "AMic Playback Volume" and "Mic Capture Volume"
> in DSP program for Audigy 4. If I look correctly on source, there is
> only "Mic Capture Volume" for Audigy 4 and not "Mic Playback Volume".
> 
> Old way was done in way how windows drivers worked. I do not know if
> they use this way today.
> 
> Who cares if mic goes through AC97, most of users use only cheap mic for
> voip.
> 
> If you don't change Audigy 1 driver part, then I don't care.
> 
> Peter Zubaj
> 
The Audigy 1 has not been changed. I don't think that the Audigy 1 has 
the option for this higher quality line-in/mic capture path so the 
higher quality line-in/mic capture is only enabled on cards that have 
been verified to work well with it.
I don't really understand what the problem is that you have. Do you 
simply want mixer controls renamed or something?

James




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
