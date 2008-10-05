From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: size of snd_hda_intel
Date: Sun, 5 Oct 2008 18:19:05 -0400
Message-ID: <9e4733910810051519k427dce6aobca50815bfac30e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.147])
	by alsa0.perex.cz (Postfix) with ESMTP id B222A24157
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Oct 2008 00:19:06 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 9so503593qwj.56
	for <alsa-devel@alsa-project.org>; Sun, 05 Oct 2008 15:19:05 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>ismod
snd_hda_intel         435,772

435,772 bytes seems awfully large for an audio driver. The large size
seems to be due to having support for multiple codecs in the driver.
Could a generic  hda driver load the correct codec dynamically instead
of building them all in statically?

I have a Realtek codec.

-- 
Jon Smirl
jonsmirl@gmail.com
