From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: OSS driver removal, 2nd round
Date: Fri, 30 Jun 2006 17:13:02 +0100
Message-ID: <44A54D8E.3000002__8725.49567507139$1151684108$gmane$org@superbug.co.uk>
References: <20060629192128.GE19712@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from anchor-post-31.mail.demon.net (anchor-post-31.mail.demon.net
	[194.217.242.89])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BB47129A
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Jun 2006 18:13:04 +0200 (MEST)
In-Reply-To: <20060629192128.GE19712@stusta.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Adrian Bunk <bunk@stusta.de>
Cc: alsa-devel@alsa-project.org, perex@suse.cz, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Olaf Hering <olh@suse.de>
List-Id: alsa-devel@alsa-project.org

Adrian Bunk wrote:
> Now that I've sent the first round of actually removing the code for OSS 
> drivers where ALSA drivers without regressions exist for the same 
> hardware, it's time for a second round amongst the remaining drivers.
>
>
> SOUND_EMU10K1
> - ALSA #1735 (OSS emulation 4-channel mode rear channels not working)
> - ALSA #1782 (really poor sound with my SB Live 1024 and ALSA)
>   

As the MAINTAINER of EMU10K1, I am happy for EMU10K1 driver to be 
removed from the kernel.

ALSA #1735 is now closed. All the apps the user was trying also support 
ALSA natively now, so OSS is not needed.
ALSA #1782 requires more information from the user. I am expecting this 
to be a configuration problem, and not a driver problem.


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
