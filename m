From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: libalsa w/o pthreads?
Date: Mon, 15 Nov 2004 17:33:48 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0411151731300.1491-100000@studcom.urz.uni-halle.de>
References: <courier.4198D832.00011691@outpost.mndmttr.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <courier.4198D832.00011691@outpost.mndmttr.nl>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Luuk van Dijk <lvd@mndmttr.nl>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Luuk van Dijk wrote:
> on this platform pthreads don't work (yet). is it possible to compile/use
> alsa-lib without them?

Not without some changes.

conf.c and hcontrol.c use just a mutex, so you can remove the pthread
calls if there aren't any threads.

The meter and share plugins create their own threads, so I guess you
have to disable them.


Best regards,
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
