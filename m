From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Memory leaks in alsa-lib
Date: Tue, 26 Aug 2003 12:07:36 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0308261159450.29234-100000@pnote.perex-int.cz>
References: <yw1xznhxpvou.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <yw1xznhxpvou.fsf@users.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 25 Aug 2003, [iso-8859-1] M=E5ns Rullg=E5rd wrote:

>=20
> Is there a memory leak in alsa-lib?  When playing music with a player
> I'm writing (TCVP, http://tcvp.sf.net), the memory usage reported by
> top grows for each file I play, but only if I use ALSA for sound
> playback.  If I use OSS the memory usage varies around 1.5 MB, but if
> I use ALSA, it starts at 1.9 MB (OK, libasound takes some space) and
> grows by 30-40 kB for each played file.  Running the whole thing under
> valgrind gives me this, which is all alsa-related.  When using OSS,
> valgrind reports no leaks.

I tested aplay with valgrind and I cannot find any leak (except a few=20
allocations probably from glibc). Note that you have to use=20
snd_config_update_free_global() after end of the session to free
the configuration cache in alsa-lib. This is described in=20
the alsa-lib/MEMORY-LEAK file.

=09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
