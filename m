From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH alsa-lib 2/2] Use thread-safe locale
 functions if available
Date: Wed, 21 Apr 2010 19:21:34 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1004211921110.16336@eeebox2.perex-int.cz>
References: <1271867868-31501-1-git-send-email-remi@remlab.net>
	<1271867868-31501-2-git-send-email-remi@remlab.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1162097328-1271870494=:16336"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 32A0F24542
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Apr 2010 19:21:35 +0200 (CEST)
In-Reply-To: <1271867868-31501-2-git-send-email-remi@remlab.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?Q?R=C3=A9mi_Denis-Courmont?= <remi@remlab.net>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1162097328-1271870494=:16336
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 21 Apr 2010, R=C3=A9mi Denis-Courmont wrote:

> setlocale() is not thread-safe. It can actually trigger a crash if
> another thread uses locale informations at the same time in the process.
> Library code should use POSIX newlocale/duplocale/uselocale/freelocale
> instead. Those functions only change the locale data for the calling
> thread.

Thanks. I applied both patches to alsa-lib git repo.

 =09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

--8323584-1162097328-1271870494=:16336
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--8323584-1162097328-1271870494=:16336--
