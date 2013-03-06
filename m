From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v2] davinci-mcasp: Add support for
 multichannel playback
Date: Wed, 06 Mar 2013 12:00:48 +0100
Message-ID: <513721E0.8000605@gmail.com>
References: <1361983125-32717-1-git-send-email-michal.bachraty@streamunlimited.com>
 <B5906170F1614E41A8A28DE3B8D121433ED3C660@DBDE01.ent.ti.com>
 <513616F7.2020201@gmail.com>
 <B5906170F1614E41A8A28DE3B8D121433ED3D3ED@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f42.google.com (mail-bk0-f42.google.com
 [209.85.214.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 50FE3265383
 for <alsa-devel@alsa-project.org>; Wed,  6 Mar 2013 12:00:46 +0100 (CET)
Received: by mail-bk0-f42.google.com with SMTP id jk7so283471bkc.15
 for <alsa-devel@alsa-project.org>; Wed, 06 Mar 2013 03:00:45 -0800 (PST)
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433ED3D3ED@DBDE01.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, Michal Bachraty <michal.bachraty@streamunlimited.com>
List-Id: alsa-devel@alsa-project.org

On 06.03.2013 11:54, Bedia, Vaibhav wrote:
> Hi Daniel,
> 
> On Tue, Mar 05, 2013 at 21:31:59, Daniel Mack wrote:
> [...]
>>
>> As Michal described, we used a board with a multichannel Codec on it,
>> which connects 3 of its I2S inputs to the AM33xx's AXR data lines.
>>
>> Software wise, we tested with 'aplay -cX', and that seems to work just fine.
>>
> 
> Since you are using a multichannel codec things are a lot simplified for you :)
> Someone might want to hook up multiple codecs to get multi-channel behavior.
> There will be only 1 CPU DAI but there can be upto 16 CODEC DAIs operating in
> sync. I haven't really followed the recent ASoC changes so I don't know whether
> something like this can be handled right now.

I would rather instanciate multiple McASP cores for such setups, so you
can (in theory) also make them operate on different bit depths and clock
dividers. You think that's possible as well?


Thanks,
Daniel
