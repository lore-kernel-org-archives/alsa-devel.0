From: Dimitris Papavasiliou <dpapavas@gmail.com>
Subject: Re: Need help fixing pop/click artifacts in an ASOC
 driver
Date: Sat, 24 Nov 2018 22:17:49 +0200
Message-ID: <724efe46-d604-0de1-caa2-efcfd7c91510@gmail.com>
References: <ed34c70f-8d10-992e-1cf3-3a5f038c3664@gmail.com>
 <dccda0dc-bde7-7790-e4cc-2737871b14ea@linux.intel.com>
 <11a5bb5b-f8ad-d9cc-29df-8efeccb6228d@gmail.com>
 <20181114220640.GB2089@sirena.org.uk>
 <c0546298-960e-df17-273f-fa0734050aac@gmail.com>
 <20181114230255.GG2089@sirena.org.uk>
 <b48bc9d6-767a-24df-692e-fe675afed22e@gmail.com>
 <20181115003313.GH2089@sirena.org.uk>
 <56e02571-fd5b-0add-c6c7-98e4f746448c@gmail.com>
 <20181115190403.GI2089@sirena.org.uk>
 <00b68fe8-403d-b129-1166-f414e5bd21ab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 3803F267947
 for <alsa-devel@alsa-project.org>; Sat, 24 Nov 2018 21:17:51 +0100 (CET)
Received: by mail-wr1-f42.google.com with SMTP id v13so11713868wrw.5
 for <alsa-devel@alsa-project.org>; Sat, 24 Nov 2018 12:17:51 -0800 (PST)
In-Reply-To: <00b68fe8-403d-b129-1166-f414e5bd21ab@gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

I've submitted a patch for the pcm512x CODEC, that is relevant to
this problem.  The patch implements the digital_mute interface,
suppressing various clicks and pops, including the loud pop under
discussion here.  I still feel that fixing the machine driver, so
that it doesn't generate the pop at all would be desirable, as
I'm not sure whether the digital_mute callback is guaranteed to
have muted the device when the clock source takes place.

Does that sound reasonable, or would it be preferable to simply
rely on the digital_mute mechanism (assuming the patch is
acceptable)?
