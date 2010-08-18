From: Olof <olof@baah.se>
Subject: Information request - writing a driver for a virtual
	soundcard
Date: Wed, 18 Aug 2010 19:53:29 +0200
Message-ID: <AANLkTiksDnhg=kBupJ1uQO_vXq+8q-tk+TXwAwgtRaSm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1081824430
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Aug 2010 19:53:31 +0200 (CEST)
Received: by eyd9 with SMTP id 9so540985eyd.38
	for <alsa-devel@alsa-project.org>; Wed, 18 Aug 2010 10:53:31 -0700 (PDT)
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

Hi!

Maybe this is the wrong place to ask, but I kinda feel that I'm out of options.

My goal is to write a dummy driver which makes the PCM data available
as a character device though /dev/whatever. Of course I start with the
dummy pcm driver. However I find it difficult to understand how the
driver shall poll PCM data from the ALSA framework. I've read the
how-to-write-a-driver doc and studied the hda driver but I don't
understand how it all fits together with substreams, reading from
intermediate buffers, the PCM memory management functions etc.

Could someone please help me out with some pointers to additional
documentation, a suitable piece of driver code to study or any thing
that might help?

Kind Regards,
Olof
