From: Hannu Savolainen <hannu@opensound.com>
Subject: Re: Implementing ALSA compatibility in OSS
Date: Mon, 15 Nov 2004 19:58:34 +0200 (EET)
Message-ID: <Pine.LNX.4.58.0411151931420.9516@zeus.compusonic.fi>
References: <Pine.HPX.4.33n.0411151707500.1491-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0411151707500.1491-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 15 Nov 2004, Clemens Ladisch wrote:

> The purpose of having alsa-lib is that things like sample format/rate
> conversion, virtualization, software synths, replacement drivers like
> Jack etc. can be done in user space.  We either do not want or cannot
> do this in kernel space.
But why does this need to be done in alsa-lib? Jack is also a library.

> > Maybe alsa-lib could be implemented on top of the OSS driver API instead
> > of having two redundant APIs in the kernel.
>
> AFAICS the ALSA API is a superset of the OSS API.
Right. 1500+ library calls is really a superset of OSS API that has just
5 system calls and a handfull of ioctl calls. OSS is designed to make
the right decisions itself without babysitting by the applications. With
ALSA you check what the device can do. With OSS you simply tell the device
what it should do. In that way we need just a fraction of primitives for
the same functionality.

Best regards,

Hannu
-----
Hannu Savolainen (hannu@opensound.com)
http://www.opensound.com (Open Sound System (OSS))
http://www.compusonic.fi (Finnish OSS pages)
OH2GLH QTH: Karkkila, Finland LOC: KP20CM


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
