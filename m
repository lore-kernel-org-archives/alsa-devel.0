From: Sven Zeisberg <sven.zeisberg@googlemail.com>
Subject: How to transfer more than 2 channels between i.MX25 &
 AD1938 using SSI?
Date: Wed, 25 Aug 2010 16:39:51 +0200
Message-ID: <4C752B37.40601@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 090D71037FB
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Aug 2010 16:39:59 +0200 (CEST)
Received: by bwz4 with SMTP id 4so617778bwz.38
	for <alsa-devel@alsa-project.org>; Wed, 25 Aug 2010 07:39:59 -0700 (PDT)
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

  Hi,

has anybody succeeded to transfer more than 2 audio channels between 
i.MX25 and a CODEC throught the i.MX25 SSI Port?

We have succeeded to set the CODEC (AD1938) as Master to the required 
mode (TDM with 8 Timeslots and 32 Bit per Timeslot). However, as soon as 
we start to play a wav file with aplay, we can see on the logic analyzer 
that the data format on the SSI lines is reset to a stereo mode (2 
channels with frame sync changing level between channels).

In the imx-ssi driver, I can see that .channel_max = 2 - therefore my 
question: does this driver support more than two channels at all?

BR
Sven
