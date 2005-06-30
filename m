From: Peter Plessas <plessas@mur.at>
Subject: Re: hdsp oss emulation and sync
Date: Thu, 30 Jun 2005 22:22:28 +0200
Message-ID: <42C45484.9010501@mur.at>
References: <42C17BBC.1070402@mur.at>	<s5hbr5p7bq7.wl%tiwai@suse.de>	<42C2782A.7060308@mur.at> <s5h64vx78h2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h64vx78h2.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi&List,

Yes, great! This works! What are the drawbacks of using the "Sample 
Clock Source Locking"? I can see that i can't change the hdsp from 
autosync to master after i enabled the locking. But the OSS emulation 
just works fine!!

Thanks again,

Peter

Takashi Iwai wrote:

> Could you try the patch below?  This will add "Sample Clock Source
> Locking" mixer element.  Enabling this switch may fix your problem
> above.  You can turn this on via alsamixer or amixer.
> 
> 
> Takashi
> 
> 
> ------------------------------------------------------------------------
> 
> Index: alsa-kernel/pci/rme9652/hdsp.c
> ===================================================================
> . . . 


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
