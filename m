From: Adrian Bunk <bunk@stusta.de>
Subject: Re: OSS driver removal, 2nd round (v2)
Date: Sat, 8 Jul 2006 02:00:00 +0200
Message-ID: <20060708000000.GG26941__43628.8651814268$1152432822$gmane$org@stusta.de>
References: <20060707231716.GE26941@stusta.de> <p737j2potzr.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E8CD7230
	for <alsa-devel@alsa-project.org>;
	Sun,  9 Jul 2006 10:13:28 +0200 (MEST)
Received: from mailout.stusta.mhn.de (emailhub.stusta.mhn.de [141.84.69.5])
	by gate.perex.cz (Perex's E-mail Delivery System) with SMTP id
	38E3D998F7 for <alsa-devel@alsa-project.org>;
	Sat,  8 Jul 2006 02:01:01 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <p737j2potzr.fsf@verdi.suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Andi Kleen <ak@suse.de>
Cc: alsa-devel@alsa-project.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, perex@suse.cz, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sat, Jul 08, 2006 at 01:50:00AM +0200, Andi Kleen wrote:
> Adrian Bunk <bunk@stusta.de> writes:
> > 
> > Q: What about the OSS emulation in ALSA?
> > A: The OSS emulation in ALSA is not affected by my patches
> >    (and it's not in any way scheduled for removal).
> 
> I again object to removing the old ICH sound driver.
> It does the same as the Alsa driver in much less code and is ideal
> for generic monolithic kernels

First of all, if you read my email you'll note that this driver isn't 
currently scheduled for removal.

And more important, your comment is already covered by the other FAQ 
entry in my email:

Q: But OSS is kewl and ALSA sucks!
A: The decision for the OSS->ALSA move was four years ago.
   If ALSA sucks, please help to improve ALSA.

> -Andi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
