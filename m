From: Thierry Vignaud <tvignaud@mandriva.com>
Subject: Re: question about closed source alsa driver
Date: Wed, 17 May 2006 20:09:17 +0200
Message-ID: <m2u07ole0i.fsf@vador2.mandriva.com>
References: <d39e2e70605160318meac7c91g40bb9cd7a85c0665@mail.gmail.com>
	<4469CE12.6090701@findus.dhs.org>
	<d39e2e70605160637g153bd27ei3cc3dc28df59dba1@mail.gmail.com>
	<1147791320.13948.111.camel@mindpipe>
	<d39e2e70605161226i2234a968rd301315188fb5831@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <d39e2e70605161226i2234a968rd301315188fb5831@mail.gmail.com> (Sergey Kolosov's message of "Tue, 16 May 2006 23:26:47 +0400")
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Sergey Kolosov <freeserj@gmail.com>
Cc: Lee Revell <rlrevell@joe-job.com>, =?iso-8859-15?Q?Petter_Sundl=F6f?= <petter.sundlof@findus.dhs.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

"Sergey Kolosov" <freeserj@gmail.com> writes:

> It's not just a sound card. It's driver for device but sound is one
> of the basic functions( still there are other parts, initialize
> mapping etc). Maybe I emit some functions to other module...

anyway, since:

$ ~/cvs/alsa $ head -2 alsa-driver/COPYING
                    GNU GENERAL PUBLIC LICENSE
                       Version 2, June 1991

it's obvious one cannot link a non GPL-compatible driver with ALSA
core... [1]

maybe, if they really fell, they can't release the whole stuff under
GPL (or under a GPL compatible license), they'll have to release the
sound driver part as GPL.

also, since:

- lots of symbols in various kernel subsystem are forbidden to be used
  by non GPL (or GPL compatible) by drivers (eg EXPORT_SYMBOL_GPL)

- some kernel developers have explicitely set the boundary (look at
  GPL and discussions about GPL) for the linking in order to forbid
  creating binary drivers using their subsystems and/or frameworks.

it can be uneasy to write a proprietary driver w/o legal matters for
the other parts (non sound stuff).

either one accepts the license or it doesn't (and then he cannot link)

my 2 cents.


[1] unless all ALSA developers (including all those who sent patches i
    guess) acknoledge to set the GPL boundary (eg where ended what is
    called a "derivative work") at the point one can write such a
    driver


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
