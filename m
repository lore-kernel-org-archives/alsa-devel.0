From: Daniel Mack <zonque@gmail.com>
Subject: Re: Copy ALSA buffer to the buffer allocated in my
	driver.
Date: Tue, 2 Aug 2011 14:25:18 +0200
Message-ID: <CACTFLANV-Dspe0EExBrPKM0PTqD3TWosWFKKed1rvmN6ujRFZA@mail.gmail.com>
References: <CAB+ez9vpzWQ3CXwoC64X6BEg=quzvJ8u-BhdMTr6vP+-=L4WRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D57C103816
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Aug 2011 14:25:19 +0200 (CEST)
Received: by yxm34 with SMTP id 34so3984460yxm.38
	for <alsa-devel@alsa-project.org>; Tue, 02 Aug 2011 05:25:18 -0700 (PDT)
In-Reply-To: <CAB+ez9vpzWQ3CXwoC64X6BEg=quzvJ8u-BhdMTr6vP+-=L4WRQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: `/ET!-i1S!-i <yethish7@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Please don't drop any addresses from Cc:, and please quote original
postings appropriately.


On Tue, Aug 2, 2011 at 2:21 PM, `/ET!-i1S!-i <yethish7@gmail.com> wrote:
> The driver i am writing is purely virtual .
>
> The role of my driver is to receive the audio data played in the application
> program and stream it to remote system.

Over the network?

> For this purpose i need to copy the audio data from alsa buffer to my
> Buffer. I have no idea how this can be done. So i am looking for sample code
> to copy the audio data to my Buffer.

I'd bet there is no need to write any ALSA driver for this. You can
either use the ALSA plugin mechanism to achive this, or even some
higher level. PulseAudio for example allows seamless streaming over
the network out of the box.

Why are you confident that you need to write a driver?


Daniel
