From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Implementing ALSA compatibility in OSS
Date: Mon, 15 Nov 2004 17:27:19 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0411151707500.1491-100000@studcom.urz.uni-halle.de>
References: <Pine.LNX.4.58.0411151518070.9417@zeus.compusonic.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0411151518070.9417@zeus.compusonic.fi>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Hannu Savolainen <hannu@opensound.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hannu Savolainen wrote:

> On Mon, 15 Nov 2004, Clemens Ladisch wrote:
>
> > The plugin interface isn't documented at all.
> Any chance that it gets documented in the near future? I guess no.

Properly documenting the application interface has priority.  (Which
doesn't say much as long as neither one is being done.)

> > > Another alternative is making OSS compatible with the ALSA's device driver
> > > interface /dec/snd/*.
> > > Is there any documentation written for it (nothing seems to be
> > > available in the net)?
> >
> > Of course not, otherwise people would try to use it. ;-)
>
> Hmm. Isn't this some kind of waste of natural resources?

The purpose of having alsa-lib is that things like sample format/rate
conversion, virtualization, software synths, replacement drivers like
Jack etc. can be done in user space.  We either do not want or cannot
do this in kernel space.

> Maybe alsa-lib could be implemented on top of the OSS driver API instead
> of having two redundant APIs in the kernel.

AFAICS the ALSA API is a superset of the OSS API.


Best regards,
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
