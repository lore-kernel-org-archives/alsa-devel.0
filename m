From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: PROBLEM: 2.5.5 with Alsa, kernel BUG at slab.c:1459
Date: Sat, 2 Mar 2002 11:58:32 +0100 (CET)
Message-ID: <Pine.LNX.4.33.0203021150350.681-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id LAA22304
	for <alsa-devel@alsa-project.org>; Sat, 2 Mar 2002 11:58:47 +0100
In-Reply-To: <Pine.LNX.4.33.0203011709020.15390-100000@pluto.tu-graz.ac.at>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Reinhard Wolfgang Kreiner <rkreiner@sbox.tugraz.at>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 1 Mar 2002, Reinhard Wolfgang Kreiner wrote:

> Hello, 
> 
> I tested kernel 2.5.5, 2.5.5-pre1 with alsa-sound-drivers... 
> it runs great, but the system is freezing if i 
> shutdown the system and i get kernel BUG at slab.c:1459!!!
> 
> i tried different combination, the problem only orrur
> if im _using_ the soundcards.
>  
> unloading the modules manually, the same problem
> only on shutdown.
> seems to be freeing some resouces in memory?

We fixed this problem in our CVS (it's in cs4231_lib.c).
What is worring me why /proc/asound shows '???' for card name.
Can you try ALSA 0.9.0beta12 and contect me privately, if it works?

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
