From: "J. Scott Merritt" <alsauser@pragmasoft.com>
Subject: SALSA Lib - TLV Deprecated warnings
Date: Sun, 30 Sep 2007 11:10:58 -0400
Message-ID: <20070930111058.10171169.alsauser@pragmasoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp8.server.rpi.edu (smtp8.server.rpi.edu [128.113.2.228])
	by alsa0.perex.cz (Postfix) with ESMTP id 4A8D224368
	for <alsa-devel@alsa-project.org>;
	Sun, 30 Sep 2007 17:05:23 +0200 (CEST)
Received: from RPI02.localdomain (voiceflight.inc.rpi.edu [128.113.36.139])
	by smtp8.server.rpi.edu (8.13.1/8.13.1) with SMTP id l8UF5KKL004314
	for <alsa-devel@alsa-project.org>; Sun, 30 Sep 2007 11:05:21 -0400
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

It appears that if SALSA Lib 0.0.12 is built -without- TLV enabled in
the configuration options, then simply -including- asoundlib.h from an
application program will trigger deprecated warnings on some of the
TLV read/write function definitions (even though they are not called
from the application).

Is there something we can do to the header files to eliminate these
warnings ?

Thanks, Scott.
