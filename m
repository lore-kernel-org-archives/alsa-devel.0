From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 0/7] ASoC:davinci-mcasp: bc polarity fix
 and proper format support
Date: Wed, 09 Apr 2014 14:12:21 +0200
Message-ID: <53453925.8040202@gmail.com>
References: <1396611107-30765-1-git-send-email-peter.ujfalusi@ti.com>
 <533EB282.6080906@gmail.com> <533EDFFE.2060501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f52.google.com (mail-bk0-f52.google.com
 [209.85.214.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 49945261AEC
 for <alsa-devel@alsa-project.org>; Wed,  9 Apr 2014 14:12:23 +0200 (CEST)
Received: by mail-bk0-f52.google.com with SMTP id my13so2258220bkb.11
 for <alsa-devel@alsa-project.org>; Wed, 09 Apr 2014 05:12:22 -0700 (PDT)
In-Reply-To: <533EDFFE.2060501@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, jsarha@ti.com
List-Id: alsa-devel@alsa-project.org

Hi Peter,

On 04/04/2014 06:38 PM, Peter Ujfalusi wrote:
> On 04/04/2014 04:24 PM, Daniel Mack wrote:

>> The cleanups look sane, though. I can test them on AM33xx based hardware
>> early next week. If you don't want to hold them off until then, no
>> problem. I can also send fixups in case I spot a regression.
> 
> That would be great if you could also test these. It seams you have quite good
> array of codecs available.

I tested this series with a CS4271 codec in I2S mode, and things still
work as expected, except for the fact that the LRCLK is now inverted in
comparison to the old state.

After some debugging, however, I have confidence that the behaviour with
the patches applied is in fact correct, we just need to flip the bits in
our ASoC machine driver, which is no big deal.


Thanks for the cleanups again!
Daniel
