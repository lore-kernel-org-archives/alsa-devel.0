From: Daniel Drake <dsd@gentoo.org>
Subject: storm of emu10k1: unhandled interrupt: 0x00400000
Date: Tue, 12 May 2009 17:27:11 -0400
Message-ID: <4A09E9AF.6080300@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mtaout02-winn.ispmail.ntl.com (mtaout02-winn.ispmail.ntl.com
	[81.103.221.48])
	by alsa0.perex.cz (Postfix) with ESMTP id 0609210385F
	for <alsa-devel@alsa-project.org>;
	Tue, 12 May 2009 23:28:48 +0200 (CEST)
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
Cc: Martin.vGagern@gmx.net
List-Id: alsa-devel@alsa-project.org

Hi,

Martin von Gagern reported a bug in the emu10k1 driver while running 2.6.29:
https://bugs.gentoo.org/show_bug.cgi?id=266657

This message is logged seemingly infinitely, to the point where the 
system became unusable.

     emu10k1: unhandled interrupt: 0x00400000

This is INTE_ADLIBENABLE.

The bug is a one-off and unreproducible, this mail is really just for 
information only... or would people be happy with this flag being added 
to the "mask the interrupts that we don't handle" code below the code 
that prints the "unhandled interrupt" message?

Daniel
