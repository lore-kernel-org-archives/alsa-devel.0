From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Implementing ALSA compatibility in OSS
Date: Mon, 15 Nov 2004 14:13:46 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0411151354510.12617-100000@studcom.urz.uni-halle.de>
References: <Pine.LNX.4.58.0411151141220.9261@zeus.compusonic.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0411151141220.9261@zeus.compusonic.fi>
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
> We are considering making our OSS software compatible with ALSA.
> Our initial plan was to implement a version of libasound.so that
> implements the required functionality in OSS way.

The plugin interface is there to avoid having to (re)implement most of
libasound.

All device types (pcm/rawmidi/ctl/seq/hwdep/timer) are implemented
using plugins, although most of them have only a plugin named "hw" for
the kernel driver.

> However the problem is that there are more than 1500 snd_*
> functions exported by libasound.so (of alsa-lib-1.0.7rc2). How
> many of them are actually needed and how many of them are just
> helpers used internally by the library.

Many of the xxx_set/get_yyy functions are just accessors for the yyy
field of the (internal) xxx structure, to make the libray binary
compatible if the structure changes.

A plugin has to implement much less functions (see pcm_null.c for a
simple example).

> Is there any other official documentation for the pcm and mixer
> interfaces in addition to the DOXYGEN stuff?

Unfortunately, no.  The plugin interface isn't documented at all.

> Is the ALSA library API frozen now or should we wait until the 2.0
> version to avoid doing redundant work?

I don't know of any plans to make (big) changes.

> Another alternative is making OSS compatible with the ALSA's device driver
> interface /dec/snd/*.

This is an internal interface (that will change in future versions).

> Is there any documentation written for it (nothing seems to be
> available in the net)?

Of course not, otherwise people would try to use it. ;-)
(Unfortunately, sox does.)

> Third alternative might be improving the OSS plugin for Jack. After
> browsing the ALSA web site it looks like many pages recommend using Jack
> instead of the ALSA library API. However are there any reasons to
> implement a new version of libasound.so instead of improving the Jack
> plugin?

This depends on whether you want to be compatible with ALSA programs
not using Jack.  Usually, non-'professional' application don't use
Jack.


Clemens



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
