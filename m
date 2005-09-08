From: Mikael Magnusson <mikaelmagnusson@glocalnet.net>
Subject: Compilation problems in adriver.h
Date: Thu, 8 Sep 2005 22:07:29 +0200
Message-ID: <20050908200729.GA27433@skinner.hem.za.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I'm using a customized kernel based on kernel-source-2.6.11 from Debian,
and I needed to modify adriver.h to be able to compile the alsa modules
from current CVS. I moved the definition of __nocast, since the declaration
of snd_compat_kstrdup causes a compilation error if __nocast is undefined.

I also commented out the definition of CONFIG_ISA_DMA_API, because
it led to a loop in snd.ko:

  WARNING: Loop detected: /lib/modules/2.6.11-vserver-k7/alsa/acore/snd.ko
  which needs snd.ko again!

It looks like a problem with snd_dma_pointer, snd_dma_disable and
snd_dma_program:

  /lib/modules/2.6.11-vserver-k7/alsa/acore/snd.ko needs
  "snd_dma_pointer": /lib/modules/2.6.11-vserver-k7/alsa/acore/snd.ko
  /lib/modules/2.6.11-vserver-k7/alsa/acore/snd.ko needs
  "snd_dma_disable": /lib/modules/2.6.11-vserver-k7/alsa/acore/snd.ko
  /lib/modules/2.6.11-vserver-k7/alsa/acore/snd.ko needs
  "snd_dma_program": /lib/modules/2.6.11-vserver-k7/alsa/acore/snd.ko

I'm using a customized kernel based on kernel-source-2.6.11 (version
2.6.11-5) from Debian.

Regards,
Mikael Magnusson



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
