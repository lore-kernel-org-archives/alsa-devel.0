From: Klaus Zimmermann <klaus_zimmermann@gmx.de>
Subject: Userspace Device Driver
Date: Thu, 31 May 2007 00:03:02 +0200
Message-ID: <1180562582.1904.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id D3F652452A
	for <alsa-devel@alsa-project.org>;
	Thu, 31 May 2007 00:03:08 +0200 (CEST)
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

Greetings List,

on various places on the alsa site I read about the possibility of
writing a userspace device driver.
I am interested thatin, since I have a nice Edirol FA-66 ieee1394
interface which works nicely under jack with the ffado
(http://ffado.org , former freebob) driver. 

>From what I read it seems I could either write an external plugin to the
alsa-lib, which would be truly userspace and fine except I it would
always have to be configured from .asoundrc and would probably not be
found by legacy programs like ekiga.

Or I could get really messy and have a userspace daemon relay audio data
between the ffado library, i.e. librawieee1394, and a yet to be written
alsa-driver module.
This would at least yield the advantage, that the driver was
indistinguishable from a true hardware driver.

So: Is it possible to write a userspace driver that is indistinguishable
from a hardware driver?

TIA
Klaus Zimmermann

P.S.: I am aware of the jackplug plugin. However even with very
conservative buffer settings I get underruns and x-runs quickly leading
to a failing jack :(
