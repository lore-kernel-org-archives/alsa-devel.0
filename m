From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: static alsa-lib is not working
Date: Thu, 18 Apr 2002 08:45:46 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0204180845110.526-100000@pnote.perex-int.cz>
References: <Pine.BSF.4.44.0204171331390.76520-100000@fest.stud.fee.vutbr.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.BSF.4.44.0204171331390.76520-100000@fest.stud.fee.vutbr.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Kasparek Tomas <xkaspa06@stud.fee.vutbr.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 17 Apr 2002, Kasparek Tomas wrote:

> Hi all,
> 
> I found some strange behavior of alsa-lib. I tried to compile static
> version for profilling purposes, and it's not working.
> 
> The problem is, that sub-libraries for libasound.a are created from
> *.lo objects (produced by libtool). Only alsa-lib/src/*.o ae included
> directly. For .lo files macro SND_DLSYM_BUILD_VERSION() from global.h
> is not called properly. Symbols defined with this macro in .lo files are
> not inserted into "snd_dlsym_start" list. This produces error in
> snd_dlsym.
> 
> The problem is in usage of __attribute__ ((constructor)). It seems to me,
> that it does not work properly in .lo objects.
> 
> For now, quick solution is to create the archive (libasound.a) by hand.
> You just need to copy all .o files from alsa-lib/src into some directory
> (renaming one of two simple.o files to another name to avoid colision)
> and then running arc cru libasound.a *.o

Have you read the alsa-lib/INSTALL file?

Compilation of static library
-----------------------------

If you would like to use the static ALSA library, you need to use these
options for the configure script:

        ./configure --enable-shared=no --enable-static=yes

Unfortunately, due to bug in the libtool script, the shared and static
library cannot be built together.


						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com
