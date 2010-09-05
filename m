From: Patrick Doyle <wpdster@gmail.com>
Subject: ALSA sound/core/pcm_lib.c:318: BUG: pcmC0D0p:0,
 pos = 32768, buffer size = 32768 , period size = 2048
Date: Sun, 5 Sep 2010 14:28:31 -0400
Message-ID: <AANLkTikmZ0k2YQGMM+wdrqc+xAMgqYOZHtLA7Heag69H@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id F0550243D3
	for <alsa-devel@alsa-project.org>;
	Sun,  5 Sep 2010 20:28:52 +0200 (CEST)
Received: by iwn4 with SMTP id 4so3488551iwn.38
	for <alsa-devel@alsa-project.org>; Sun, 05 Sep 2010 11:28:52 -0700 (PDT)
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

I'm getting this error when running an OSS application in emulation
mode (on an ADI Blackfin processor to which an SSM2602 codec is
attached, if anybody is interested).  I don't have a pure ALSA
application (yet) than i can try.  Can anybody give me pointers as to
how to try to track the source of this error down?

Thanks.

--wpd
