From: Voluspa <voluspa@bigfoot.com>
Subject: Re: A volume my mother would have liked ;-)
Date: Wed, 20 Feb 2002 09:13:52 +0100
Message-ID: <20020220091352.2912c331.voluspa@bigfoot.com>
References: <20020219203712.7982523a.voluspa@bigfoot.com>
	<XFMail.20020219203746.guenther.sohler@newlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from oden.fish.net (h139n1fls24o900.telia.com [213.66.143.139])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id JAA12557
	for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2002 09:10:00 +0100
In-Reply-To: <XFMail.20020219203746.guenther.sohler@newlogic.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Guenther Sohler <guenther.sohler@newlogic.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 19 Feb 2002 20:37:46 +0100 (MET)
Guenther Sohler wrote:

> i have the same problem with my audixy card. midi output is far too silent.

Stay right where you are :-) Compiling kernel 2.5.5 took away my sound (in RealPlayer8) and replaced it with 1-second-static-BEEP-1-second-static-BEEP-etc ad infinitum. Mute button/volume slider still unaffecting the sound.

Same config as 2.5.5-pre1 and native OSS still broken:

depmod: *** Unresolved symbols in /lib/modules/2.5.5/kernel/sound/oss/sound.o
depmod:         virt_to_bus_not_defined_use_pci_map

Regards,
Mats Johannesson
Sweden

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
