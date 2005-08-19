From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: Compulab sound device
Date: Fri, 19 Aug 2005 15:10:31 +0100
Message-ID: <1124460631.2861.259.camel@cearnarfon>
References: <20050819135108.3863.qmail@web54606.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050819135108.3863.qmail@web54606.mail.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chow Raymond <usher_raymond82@yahoo.com>
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 2005-08-19 at 06:51 -0700, Chow Raymond wrote:

> 
> > This means that snd-pxa2xx-pcm.ko has not been
> > inserted. It's built from
> > pxa2xx-pcm.c
> 
> I cant even insmod snd-pxa2xx-pcm. It gives me the
> following error. 
> 
> [root@ARMCore sound1]$ insmod snd-pxa2xx-pcm.ko
> snd_pxa2xx_pcm: Unknown symbol dma_mmap_writecombine
> insmod: error inserting 'snd-pxa2xx-pcm.ko': -1
> Unknown symbol in module
>  

It looks like your arch/arm and include/asm/ also has to be back ported
from 2.6.12. I've now read Clemens reply and also believe it's better to
port your machine from 2.6.7 to 2.6.12.

Liam




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
