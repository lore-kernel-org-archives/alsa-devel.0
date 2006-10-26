From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: maximum quantity of sound cards supported by alsa
Date: Thu, 26 Oct 2006 12:45:38 +0200
Message-ID: <1161859538.12967.274268898@webmail.messagingengine.com>
References: <d39e2e70610250619n7d28589dkc5ef8e492a6cd0bc@mail.gmail.com>
	<1161782765.24018.274184927@webmail.messagingengine.com>
	<d39e2e70610260235j2507354fne7cec8ab97290611@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <d39e2e70610260235j2507354fne7cec8ab97290611@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Sergey Kolosov <freeserj@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

(quoting fixed)
(please don't send HTML mail)

Sergey Kolosov wrote:
> On 10/25/06, Clemens Ladisch <cladisch@fastmail.net> wrote:
> > Sergey Kolosov wrote:
> > >  What maximum quantity of sound cards supported by alsa?
> >
> > 32 if CONFIG_SND_DYNAMIC_MINORS is set, otherwise 8.
> 
>  Whether it is planned to expand in the future this quantity?

No.  It's unlikely that any computer would be ably to handle
the bandwdth for that many devices.

What are you trying to do?


Regards,
Clemens

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
