From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Compulab sound device
Date: Fri, 19 Aug 2005 15:17:24 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0508191515220.20194-100000@studcom.urz.uni-halle.de>
References: <20050819124710.36978.qmail@web54603.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050819124710.36978.qmail@web54603.mail.yahoo.com>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Chow Raymond wrote:
> Ok..I backport ARM audio changes from 2.6.12 to 2.6.7.
> I manage to build a zImage file and manage to make
> modules too. However..there are few warnings that i
> encounter during make modules
>
> Building modules, stage 2.
>   MODPOST
> *** Warning: "dma_mmap_writecombine" [sound/arm/snd-pxa2xx-pcm.ko] undefined!
> *** Warning: "pxa_set_cken" [sound/arm/snd-pxa2xx-ac97.ko] undefained!
> *** Warning: "snd_ac97_get_short_name" [sound/arm/snd-pxa2xx-ac97.ko] undefined!
>
> I thought warnings would be ok.

Those aren't.

It seems the audio changes depend on other kernel changes.  You'd
better just use 2.6.12.


HTH
Clemens



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
