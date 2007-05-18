From: Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>
Subject: Re: alsa-driver 1.0.14rc4 compile error resolved
	(was:	Linux 2.6.21 regression with hda-intel	(Conexant	5045))
Date: Fri, 18 May 2007 12:45:58 +0200
Message-ID: <f2k04f$oq1$1@sea.gmane.org>
References: <f2h9a9$d15$1@sea.gmane.org>
	<1179414132.4415.295.camel@razman.gruemaster.com>
	<f2jq7l$5ru$1@sea.gmane.org> <s5hveeqeba4.wl%tiwai@suse.de>
	<f2js0l$at0$1@sea.gmane.org> <s5hps4yea9x.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id A41552415F
	for <alsa-devel@alsa-project.org>;
	Fri, 18 May 2007 12:45:55 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hozxv-0005Mm-Kq
	for alsa-devel@alsa-project.org; Fri, 18 May 2007 12:45:43 +0200
Received: from bras-co-85-197-6-232.westend.de ([85.197.6.232])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 18 May 2007 12:45:43 +0200
Received: from G.Ohrner by bras-co-85-197-6-232.westend.de with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 18 May 2007 12:45:43 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
>> >> /usr/src/tmp/alsa-driver-1.0.14rc4/include/adriver.h:1168: error: too
>> >> many arguments to function 'pci_save_state'
> Does the configure script detect it as "mcore2", or not?

Yes, both configures (1.0.14rc4 and hb-20070518) detect it as mcore2 if I
try to compile it against a corresponding kernel, and both fail with the
mentioned error.

*******************************
checking for processor type... mcore2
*******************************

*******************************
In file included
from /usr/src/tmp/alsa-driver-hg20070518/include/adriver.h:930,
                
from /usr/src/tmp/alsa-driver-hg20070518/include/sound/driver.h:46,
                 from /usr/src/tmp/alsa-driver-hg20070518/acore/hwdep.c:22:
include/linux/pci.h:531: error: expected identifier or '(' before numeric
constant
In file included
from /usr/src/tmp/alsa-driver-hg20070518/include/sound/driver.h:46,
                 from /usr/src/tmp/alsa-driver-hg20070518/acore/hwdep.c:22:
/usr/src/tmp/alsa-driver-hg20070518/include/adriver.h: In
function 'snd_pci_orig_save_state':
/usr/src/tmp/alsa-driver-hg20070518/include/adriver.h:1172: error: too many
arguments to function 'pci_save_state'
/usr/src/tmp/alsa-driver-hg20070518/include/adriver.h: In
function 'snd_pci_orig_restore_state':
/usr/src/tmp/alsa-driver-hg20070518/include/adriver.h:1176: error: too many
arguments to function 'pci_restore_state'
make[4]: *** [/usr/src/tmp/alsa-driver-hg20070518/acore/hwdep.o] Fehler 1
make[3]: *** [/usr/src/tmp/alsa-driver-hg20070518/acore] Fehler 2
*******************************

If I compile against my Pentium M kernel, both configures report "i686" and
at least alsa driver 1.0.14rc4 compiles. (Not tested with the HG snapshot.)

> (BTW, any reason that you add Reply-To: header?)

Yes, but no paticularily good one. I tried to improve my client side
configuration a bit and the "Reply-To"s should be gone now.

Greetings,

  Gunter
