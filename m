From: Jay Summet <jay@summet.com>
Subject: 0.9.X missing support for ES1688 on HP Omnibook 800...
Date: Wed, 13 Feb 2002 07:55:44 +0000
Message-ID: <20020213075544.7a2b4f13.jay@summet.com>
References: <Pine.LNX.3.96.1020212160448.6916A-100000@planck.clarku.edu>
	<Pine.LNX.4.31.0202130900220.623-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from summet.com (europa.your-site.com [140.186.45.14])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id NAA16558
	for <alsa-devel@alsa-project.org>; Wed, 13 Feb 2002 13:56:47 +0100
In-Reply-To: <Pine.LNX.4.31.0202130900220.623-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello all,

I own and use (as my primary machine) an HP Omnibook 800 laptop. It has
an ESS1888 sound chip which was supported using the es-1688 driver as of ALSA
0.5.12a (driver).

You had to include the following options:
options snd-card-es1688 snd_port=0x220 snd_dma8_size=32 snd_dma8=1 snd_irq=5

<of which I believe the snd_dma8_size=32 is the most important>

Trying out Alsa development (0.9.0 beta 10) version, the option
"snd_dma8_size" is no longer supported, and the alsa drivers are unable to detect/use my sound card chip.

It seems sort of bad to loose support for hardware when upgrading software, normally you are supposed to gain support ;>

For your information, the Kernel 2.0.x drivers supported the ESS1888 out of the box, but Kernels 2.2.x and 2.4.x (as well as 2.5.x) have some issues, which is why I'm using ALSA. (One specific issue is that kernels past 2.0  assume the buffer size is 64K (vs 32K) )

I don't know much about programming for sound hardware, and I'm hopeing that with this report somebody who works on the 1688 driver will say "DOH! I know what's wrong!" and be able to fix it quickly.  (It works in the old code, so you have something to compare with....)

Anyways, if you need help testing this issue on HP 800 hardware, feel free to email, I can either test code for you, or, if you are really serious and have lots of experience with the ES1688 driver, provide a laptop to develop it on.

Thanks,
Jay


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
