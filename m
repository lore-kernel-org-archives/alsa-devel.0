From: Giuliano Pochini <pochini@denise.shiny.it>
Subject: Re: buffer/period constraint
Date: Tue, 20 Jul 2004 18:32:47 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0407201828560.4733@denise.shiny.it>
References: <2461c072465f49.2465f492461c07@southeast.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <2461c072465f49.2465f492461c07@southeast.rr.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: fmoraes@nc.rr.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



On Tue, 20 Jul 2004 fmoraes@nc.rr.com wrote:

> Hi,
>
> Is the a way to force the period/buffer sizes so that they have an
> integral relationship ?

There are many examples:

grep -r snd_pcm_hw_constraint_integer .
[...]
./alsa-kernel/pci/intel8x0.c:	if ((err =
snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS)) < 0)
[...]


> Second, is there an easy way to find the current position of the DMA
> being used ?

It depends on the hardware... Usually you only have to read a value from a
register.



--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
