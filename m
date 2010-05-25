From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Mixer volume/decibel mapping
Date: Wed, 26 May 2010 07:24:51 +0800
Message-ID: <AANLkTim4sq_jBHYvxnLk2Pw5bdUDEMJahHPBJGIXH8ds@mail.gmail.com>
References: <201005191834.57919.vand2@gmx.de>
	<AANLkTimRTIwmzU2Dq4lgBSSwtcmSxfMcBfcll9YDC_l5@mail.gmail.com>
	<4BF629B3.9020904@ladisch.de>
	<201005210951.36495.peter.ujfalusi@nokia.com>
	<4BF658C6.4030404@ladisch.de>
	<AANLkTikXWtp87B0Gq_B-vQZXZlBl_MEBqbuHt6N5cTbi@mail.gmail.com>
	<4BFB8C89.3010207@ladisch.de>
	<AANLkTimNj_7k_l7nKLk87towdjtN5j0CSdmws02gpg8v@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id 3AF9A245A8
	for <alsa-devel@alsa-project.org>;
	Wed, 26 May 2010 01:24:52 +0200 (CEST)
Received: by pwj9 with SMTP id 9so3456729pwj.38
	for <alsa-devel@alsa-project.org>; Tue, 25 May 2010 16:24:51 -0700 (PDT)
In-Reply-To: <AANLkTimNj_7k_l7nKLk87towdjtN5j0CSdmws02gpg8v@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/5/25 James Courtier-Dutton <james.dutton@gmail.com>

>
>
> Could this maybe explain why pulseaudio was having such problems with
> alsa with regards to gain controls????
>

I don't think so since no soc user report wrong dB range

http://www.pulseaudio.org/wiki/WritingVolumeControlUIs

If the flat volume model of PA is  0% to 150% , this mean that alsa-lib does
not provide any DB scale suitable for PA to implement dB info for the pulse
device as DB_LINEAR require max is 0dB ( at least capture stream must have
gain )

only one of the PA developer complain about his HDA codec has incorrect dB
range but not willing to provide alsa-info.sh

There is a patch which may affect the dB scale

http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=7c7767ebe2fa847c91a0dd5551ca422aba359473;hp=29fdbec2dcb1ce364812778271056aa9516ff3ed
