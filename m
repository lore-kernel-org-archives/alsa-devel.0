From: Hannu Savolainen <hannu@opensound.com>
Subject: Re: Implementing ALSA compatibility in OSS
Date: Mon, 15 Nov 2004 15:41:44 +0200 (EET)
Message-ID: <Pine.LNX.4.58.0411151518070.9417@zeus.compusonic.fi>
References: <Pine.HPX.4.33n.0411151354510.12617-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0411151354510.12617-100000@studcom.urz.uni-halle.de>
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

> The plugin interface is there to avoid having to (re)implement most of
> libasound.
>
> All device types (pcm/rawmidi/ctl/seq/hwdep/timer) are implemented
> using plugins, although most of them have only a plugin named "hw" for
> the kernel driver.
Ok. This sounds promising.

> > Is there any other official documentation for the pcm and mixer
> > interfaces in addition to the DOXYGEN stuff?
>
> Unfortunately, no.  The plugin interface isn't documented at all.
Any chance that it gets documented in the near future? I guess no.

> > Another alternative is making OSS compatible with the ALSA's device driver
> > interface /dec/snd/*.
>
> This is an internal interface (that will change in future versions).
>
> > Is there any documentation written for it (nothing seems to be
> > available in the net)?
>
> Of course not, otherwise people would try to use it. ;-)
> (Unfortunately, sox does.)
Hmm. Isn't this some kind of waste of natural resources?

OSS is a driver API and it's definitely designed to be used directly.
Maybe alsa-lib could be implemented on top of the OSS driver API instead
of having two redundant APIs in the kernel. The draft for current OSS API
specification is available at http://www.fi.opensound.com/developer . We
could also consider donating core parts of OSS to the kernel (under GPL)
if there is any interest to it (no promises however).


> This depends on whether you want to be compatible with ALSA programs
> not using Jack.  Usually, non-'professional' application don't use
> Jack.
Right. They usually use the OSS API directly.

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
