From: "John S. Denker" <jsd@monmouth.com>
Subject: cs4239 errs on full duplex (provoked by overruns?)
Date: Thu, 05 Dec 2002 19:41:06 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DEFF222.6070103@monmouth.com>
References: <Pine.LNX.4.05.10212051455590.3576-100000@pulsar.kss-loka.si> <3DEF9BFF.2050200@monmouth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.05.10212051455590.3576-100000@pulsar.kss-loka.si>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

The same program that causes sb16 to become completely
wedged causes milder errors in the cs4239 module.
Reference:  see thread starting at:
http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg05525.html

The program runs for a while (sometimes 8 minutes,
sometimes less than one minute) and then gets an
i/o error.  This differs in at least three ways from
the sb16 scenario:
  -- usually it gets the i/o error without having
generated any IOCTL_PREPARE() errors.
  -- On rare occasions it does generate IOCTL_PREPARE()
errors, but they are not fatal.
  -- The ALSA system does not get totally wedged;
restarting the userland application gets us back
where we started.

However one may conjecture that there are elements in
common here.  My program is continually doing input and
output at the same time (i.e. full duplex) ... and is
causing input overruns once every 0.5 seconds.  It is
perhaps a good diagnostic for detecting drivers that
don't quite do enough clean-up after an overrun.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
