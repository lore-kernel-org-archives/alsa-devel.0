From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: aoss: problems with using functions in dlfcn.h
Date: Fri, 11 Jun 2004 09:43:13 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0406110939170.1785@pnote.perex-int.cz>
References: <40C8F53B.4010303@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from outgoing.perex-int.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A29C724E
	for <alsa-devel@alsa-project.org>; Fri, 11 Jun 2004 09:42:28 +0200 (MEST)
In-Reply-To: <40C8F53B.4010303@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 11 Jun 2004, James Courtier-Dutton wrote:

> I have an application (xine) that opens oss output from a plugin.
> This plugin is loaded into xine using dlopen(), dlsym() and friends.
> When, during runtime, dlsym() resolves the open() function, it bypasses 
> aoss, and links directly to open() instead of linking to the aoss's 
> version of open().
> 
> Is there any way to fix this problem with dlopen and friends.
> 
> Although we don't actually need aoss to work with xine, because xine has 
> good native alsa support, it just highlights a possible problem that 
> other apps might have.

I don't know a working solution, because LD_PRELOAD works only for
the main code not dlopen one.

Perhaps, it's time to persuade all developers using OSS API to use my OSS 
redirector from the alsa-oss package. See alsa-oss/oss-redir/README .

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
