From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Re: snd_pcm_writei is stuck with EPIPE
Date: Mon, 15 Nov 2004 18:02:28 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0411151801310.1491-100000@studcom.urz.uni-halle.de>
References: <20041114190618.86791.qmail@web60401.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20041114190618.86791.qmail@web60401.mail.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Pete Zaitcev <zaitcev@yahoo.com>
Cc: Dirk Jagdmann <doj@cubic.org>, alsa-devel@lists.sourceforge.net, mh@mpg123.de
List-Id: alsa-devel@alsa-project.org

Pete Zaitcev wrote:
> It looks I found it. The trick is to call snd_pcm_prepare when an underflow
> is reported.

To ignore underruns, set stop_threshold to the boundary value.


HTH
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
