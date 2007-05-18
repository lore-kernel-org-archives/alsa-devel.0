From: Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>
Subject: Re: Linux 2.6.21 regression with hda-intel
	(Conexant	5045)
Date: Fri, 18 May 2007 11:05:15 +0200
Message-ID: <f2jq7l$5ru$1@sea.gmane.org>
References: <f2h9a9$d15$1@sea.gmane.org>
	<1179414132.4415.295.camel@razman.gruemaster.com>
Reply-To: G.Ohrner@post.rwth-aachen.de
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 5EAAF24352
	for <alsa-devel@alsa-project.org>;
	Fri, 18 May 2007 11:05:16 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HoyOc-0007UE-It
	for alsa-devel@alsa-project.org; Fri, 18 May 2007 11:05:10 +0200
Received: from bras-co-85-197-6-232.westend.de ([85.197.6.232])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 18 May 2007 11:05:10 +0200
Received: from G.Ohrner by bras-co-85-197-6-232.westend.de with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 18 May 2007 11:05:10 +0200
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

Tobin Davis wrote:
> what kernels.  The best thing to do is download the
> alsa-driver-1.0.14rc4.tar.bz2 release from alsa-project.org and use it.
> It is the most current for that codec.

This driver version does not seem to compile with Linux 2.6.21:

In file included
from /usr/src/tmp/alsa-driver-1.0.14rc4/acore/memalloc.inc:13,
                 from /usr/src/tmp/alsa-driver-1.0.14rc4/acore/memalloc.c:1:
/usr/src/tmp/alsa-driver-1.0.14rc4/include/adriver.h: In
function 'snd_pci_orig_save_state':
/usr/src/tmp/alsa-driver-1.0.14rc4/include/adriver.h:1168: error: too many
arguments to function 'pci_save_state'
/usr/src/tmp/alsa-driver-1.0.14rc4/include/adriver.h: In
function 'snd_pci_orig_restore_state':
/usr/src/tmp/alsa-driver-1.0.14rc4/include/adriver.h:1172: error: too many
arguments to function 'pci_restore_state'
make[4]: *** [/usr/src/tmp/alsa-driver-1.0.14rc4/acore/memalloc.o] Fehler 1
make[3]: *** [/usr/src/tmp/alsa-driver-1.0.14rc4/acore] Fehler 2
make[2]: *** [_module_/usr/src/tmp/alsa-driver-1.0.14rc4] Fehler 2

I noticed no errors before this one and no failed includes or similar in
paticular.

Greetings,

  Gunter
