From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Problems with __BYTE_ORDER
Date: Sun, 17 Feb 2002 10:29:41 +0100 (CET)
Message-ID: <Pine.LNX.4.31.0202171029260.513-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <5.1.0.14.1.20020216141259.40e038a0@pop.alternex.com.br>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Haroldo Gamal <gamal@alternex.com.br>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 16 Feb 2002, Haroldo Gamal wrote:

> Takashi,
>
> 	The modification you made on alsa-kernel/include/asound.h carries one problem:
>
> 	__BYTE_ORDER is not defined under linux/types.h. It makes a generation of
> wrong SND_BIG_ENDIAN constant on i386 architecture.
>
> 	Am I wrong?

Nope. I tried to fix this problem in CVS.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
