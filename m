From: Dan Mann <mainlylinux@attbi.com>
Subject: Re: ALSA patch for 2.5.4
Date: 11 Feb 2002 19:14:02 -0500
Message-ID: <1013472766.19794.6.camel@localhost.localdomain>
References: <Pine.LNX.4.31.0202111429270.500-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received: from rwcrmhc52.attbi.com (rwcrmhc52.attbi.com [216.148.227.88])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id BAA11238
	for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2002 01:13:54 +0100
In-Reply-To: <Pine.LNX.4.31.0202111429270.500-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>
List-Id: alsa-devel@alsa-project.org


There are at least 2 reasons that I can see why Linus probably won't
accept your patch:

	1. It is not an inline text attachment (it is a URL).
	2. It is 79,000 lines long

If you could send the patch in smaller chunks over time, or ask one of
Linus' closer (read Highly Trusted) patch maintainers to apply it to
his/her tree first and get some testing, he might be more inclined to
accept it.

Dan Mann


On Mon, 2002-02-11 at 09:16, Jaroslav Kysela wrote:
> Hello all,
> 
> 	a new ALSA patch for 2.5.4 is available at
> 
> ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-2002-02-11-1-linux-2.5.4.patch.gz
> 
> 	I repeat myself but anyway. We are open to any suggestions and
> ideas for this kernel integration patch. Unfortunately, Linus has not
> approved this directory tree and he is not talking with us at the time.
> It seems that BIO changes are over, but he's probably busy enough to
> ignore our e-mails with co-operation requests.
> 
> 						Jaroslav
> 
> -----
> Jaroslav Kysela <perex@suse.cz>
> SuSE Linux    http://www.suse.com
> ALSA Project  http://www.alsa-project.org
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
