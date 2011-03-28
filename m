From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: GPL/LGPL licensing of the Alsa library
Date: Mon, 28 Mar 2011 11:00:01 +0200
Message-ID: <4D904E11.8020003@ladisch.de>
References: <5B9D7D28-C10D-42D5-9BB1-675103BC0957@neolex.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 67A7D10382C
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Mar 2011 10:58:43 +0200 (CEST)
In-Reply-To: <5B9D7D28-C10D-42D5-9BB1-675103BC0957@neolex.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ossi Niiranen <oniiranen@neolex.fi>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ossi Niiranen wrote:
> We recently performed a licensing audit of a larger software project
> incorporating the Alsa library 1.0.19. One issue we identified was
> that although the Alsa library purported to state that the library was
> licensed under the LGPL, there were still several files with third
> party copyright holders that indicated in their header that the file
> in question was licensed under the GPL.

$ grep -rl 'GNU General' alsa-lib/
alsa-lib/COPYING
alsa-lib/aserver/COPYING
alsa-lib/aserver/aserver.c
alsa-lib/include/sound/asequencer.h
alsa-lib/include/sound/asound.h
alsa-lib/include/sound/asound_fm.h
alsa-lib/include/sound/asoundef.h
alsa-lib/include/sound/emu10k1.h
alsa-lib/include/sound/hdsp.h
alsa-lib/include/sound/hdspm.h
alsa-lib/include/sound/sb16_csp.h
alsa-lib/m4/attributes.m4
alsa-lib/src/ucm/main.c
alsa-lib/src/ucm/parser.c
alsa-lib/src/ucm/ucm_local.h
alsa-lib/src/ucm/utils.c
alsa-lib/test/latency.c
alsa-lib/test/oldapi.c
alsa-lib/test/playmidi1.c

The aserver tool and the tests are separate and not part of the library
itself; the UCM stuff is actually LGPL-licensed and mentions the GPL
only in "You should have received a copy of the GNU General Public
License ...".

Most files in include/sound/ are just copies of the kernel headers.

Is there any specific file that you think would make the resulting
library not LGPL?

> The information contained in this e-mail is privileged ...

This e-mail contains public information intended for any subscriber of
this mailing list and for anybody else who bothers to read it; it will
be copied, disclosed and distributed to the public.  If you think you
are not the intended recipient, please commit suicide immediately.
These terms apply also to any e-mails quoted in, referenced from, or
answering this e-mail, and supersede any confidentiality notices in
those e-mails.  Additionally, confidentiality notices in those e-mails
will incur legal processing fees of $42 per line; you have agreed to
this by reading this confidentiality notice.


Regards,
Clemens
