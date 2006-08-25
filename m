From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: aoa drivers and alsa 1.0.12
Date: Fri, 25 Aug 2006 10:14:19 +0200
Message-ID: <1156493659.3893.1.camel@ux156>
References: <20060824190341.GA13803@frodo.home.lxtec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20060824190341.GA13803@frodo.home.lxtec.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Elimar Riesebieter <riesebie@lxtec.de>
Cc: debian-powerpc <debian-powerpc@lists.debian.org>, alsa-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Elimar,

> ./configure \
> --with-cards=aoa,aoa-fabric-layout,aoa-onyx,aoa-soundbus,aoa-soundbus-i2s
> ends up with "Unsupported soundcard aoa-onyx"
> 
> ./configure \
> --with-cards=aoa,aoa-fabric-layout,aoa-tas,aoa-soundbus,aoa-soundbus-i2s
> ends up with "Unsupported soundcard aoa-tas"
> 
> aoa-toonie works.

Are you sure that shouldn't be called aoa-codec-onyx? But then again, I
have absolutely no idea why it is this way. Also, can that code possibly
compile? The latest I had can only compile with 2.6.18... And if it's an
earlier code drop then toonie is broken...

johannes

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
