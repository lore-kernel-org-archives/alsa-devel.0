From: Jeremy Torres <jeremy.torres@gmail.com>
Subject: ALSA: Updating Sample Rates in sound/core/pcm_native.c
Date: Wed, 18 Apr 2012 19:51:18 -0400
Message-ID: <CAEA5kntdSeg+DVwLPtsDiM5Rr3e+AUqYug=S6MacobZSpjXJtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E4F6243FB
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Apr 2012 01:51:19 +0200 (CEST)
Received: by obbuo19 with SMTP id uo19so2449737obb.38
	for <alsa-devel@alsa-project.org>; Wed, 18 Apr 2012 16:51:18 -0700 (PDT)
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

Hello,

I have updated pcm.h in the linux kernel to allow for new sample
rates.  For example, I have added 128000 and 144000 sample rates.  Per
the documentation in pcm.h, I also updated pcm_native.c (the rates
table).  However when I try and use the "default" device for the
sample rates:

1.  For 128000: plug conversion occurs for 128K, but the slave is
configured to 96K;
2.  For 144000: plug conversion is attempted at the 176400 rate;

Note that:
a) I have snd_pcm_hw_resample set to FALSE in my application; however,
I've been using aplay/arecord to test as well with repeatable results.
b) I do not have an asoundrc setup for plug conversion, etc.  I only
have the default /usr/share/alsa/alsa.conf;
c) When I try the the device "hw:0,0", I get a (proper) warning that
the sample rate requested is not being honored (i.e., 96K instead of
128K).

I have placed debug in pcm_lib.c,  and pcm_native.c and my sample rate
constraints are set.  My understanding is if I define a specific rate
and it can be matched in the "rates" table, it should be honored.

Environment Info:
ALSA lib/driver version 1.0.20
SOC Driver

Any help would be greatly appreciated!

Regards,
Jeremy
