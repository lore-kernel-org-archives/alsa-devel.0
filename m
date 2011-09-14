From: Mike Crowe <drmikecrowe@gmail.com>
Subject: OSS emulation and hardware configuration
Date: Wed, 14 Sep 2011 09:37:59 -0400
Message-ID: <CA+jNppn4QPrNb_Jg00En1WZ0Gp97fJzfrFC9DCY2Qa6u004ymg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C9D0D103ACF
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Sep 2011 15:38:21 +0200 (CEST)
Received: by gyg4 with SMTP id 4so1452864gyg.38
	for <alsa-devel@alsa-project.org>; Wed, 14 Sep 2011 06:38:21 -0700 (PDT)
Received: by gyg4 with SMTP id 4so1452839gyg.38
	for <alsa-devel@alsa-project.org>; Wed, 14 Sep 2011 06:38:19 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi folks,

Apologies if this is obvious, but how does the OSS emulation layer set
hardware parameters at the codec level?

We are working in an embedded environment, and using a custom codec
driver.  When we access it via the ALSA API, it works fine.  We have a
bf5xx_wm8990_hw_params() function with configures the critical
hardware parameters of the codec, and I have diagnostics code in the
driver which does kernel prints when the driver changes key codec
parameters (such as bit rate, timing, etc).

When my OSS application opens it's device and changes the audio rate,
I don't see that function getting called.  In core/oss/pcm_oss.c, I
see the snd_pcm_oss_set_rate() function getting called, but I don't
understand how it changes parameters in the codec.  My
bf5xx_wm8990_hw_params() never gets called.

Can somebody please point me in the right direction?  I have two
applications who need to access the audio driver, and at different bit
rates.  I have to makes sure they are getting set correctly.

Mike
