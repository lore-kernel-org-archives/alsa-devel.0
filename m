From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: header files problem in current cvs
Date: Thu, 7 Feb 2002 13:31:38 +0100 (CET)
Message-ID: <Pine.LNX.4.31.0202071329310.487-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <3C62715A.DEB429AE@folkwang-hochschule.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: =?iso-8859-1?Q?J=F6rn?= Nettingsmeier <nettings@folkwang-hochschule.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 7 Feb 2002, [iso-8859-1] J=F6rn Nettingsmeier wrote:

> hello * !
>
>
> ./cvscompile in alsa-lib bails out with:
>
> checking for alsa-driver package... not found or wrong version
> configure: error: Install alsa-driver v0.9.0 package first...
>
> config.log says it does not find sound/asound.h
>
> after copying the headers to /usr/include/alsa by hand and setting
> up a link from /usr/include/linux/sound it compiles.
>
> i may be misunderstanding the new directory structure.
>
> is
> cd alsa-driver && ./cvscompile && make install && cd ../alsa-lib &&
> ./cvscompile && make install ...
> not going to work anymore ?

It should work. The kernel header files are located at /usr/include/sound
and alsa-lib files (independent from kernel header files) are located at
/usr/include/alsa. You need the kernel header files to build alsa-lib, of
course, but applications using alsa-lib don't require them.

=09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
SuSE Linux    http://www.suse.com
ALSA Project  http://www.alsa-project.org


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
