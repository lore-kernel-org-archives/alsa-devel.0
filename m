From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [PATCH] proper lseek locking in ALSA, take 3
Date: Wed, 20 Feb 2002 21:04:59 +0100 (CET)
Message-ID: <a5109c$u0m$1@quimby2.netfonds.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id VAA24023
	for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2002 21:09:02 +0100
In-Reply-To: <1014232841.18361.37.camel@phantasy>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Robert Love <rml@tech9.net>
Cc: "torvalds@transmeta.com" <torvalds@transmeta.com>, "davej@suse.de" <davej@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 20 Feb 2002, Robert Love wrote:

> The attached patch implements proper locking in ALSA lseek methods.
> Note ALSA has 3 lseek implementations, but only:
>
> 	sound/core/info.c :: snd_info_entry_llseek()
>
> requires locking.  I wrapped the function in the BKL.  According to
> Jaroslav Kysela the gus_mem_proc method is only called from above.  The
> third lseek, in hwdep.c, clearly doesn't need locking.  Without this
> patch, the above lseek is not safe.
>
> Patch is against 2.5.5, please apply.

We have this patch already in our ALSA CVS tree, so it will be commited to
Linus in next patch round. Thanks.

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
