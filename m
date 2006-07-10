From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: OSS driver removal, 2nd round (v2)
Date: Mon, 10 Jul 2006 14:18:50 +0100
Message-ID: <44B253BA.3030103@superbug.co.uk>
References: <20060707231716.GE26941@stusta.de>
	<p737j2potzr.fsf@verdi.suse.de>	<1152458300.28129.45.camel@mindpipe>
	<20060710132810.551a4a8d.atlka@pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from anchor-post-31.mail.demon.net (anchor-post-31.mail.demon.net
	[194.217.242.89])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 61FF1233
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Jul 2006 15:18:53 +0200 (MEST)
In-Reply-To: <20060710132810.551a4a8d.atlka@pg.gda.pl>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: =?ISO-8859-2?Q?Adam_Tla=B3ka?= <atlka@pg.gda.pl>
Cc: alsa-devel@alsa-project.org, ak@suse.de, linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>, alan@lxorguk.ukuu.org.uk, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

Adam Tla=B3ka wrote:
> We have also almost no docs about ALSA drvier <-> ALSA lib interface whic=
h is a strange
> in case of GPL'ed software if we want to implement a new hw driver.
>
>   =

To implement a new hw driver, one does not need to know anything about =

the ALSA driver <-> ALSA lib interface.
One simply implements a small set of functions, and ALSA does the rest.
There is good documentation regarding what this small set of functions =

are and what they should do.

James



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
