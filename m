From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: Re: [PATCH v2] davinci-mcasp: Add support for
 multichannel	playback
Date: Tue, 5 Mar 2013 12:03:45 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ED3C79F@DBDE01.ent.ti.com>
References: <1361983125-32717-1-git-send-email-michal.bachraty@streamunlimited.com>
 <B5906170F1614E41A8A28DE3B8D121433ED3C660@DBDE01.ent.ti.com>
 <2365072.cAK26ghdqV@ganymedes>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id DF289265224
 for <alsa-devel@alsa-project.org>; Tue,  5 Mar 2013 13:03:50 +0100 (CET)
In-Reply-To: <2365072.cAK26ghdqV@ganymedes>
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
To: Michal Bachraty <michal.bachraty@streamunlimited.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 05, 2013 at 17:11:20, Michal Bachraty wrote:
> Hi Vaibhav,
> 
> Please look at  [alsa-devel] [PATCH v3] davinci-mcasp: Add support for 
> multichannel playback thread. 
> There was some changes about computing number of channels. There is also 
> described, how this driver works.

Oops. I somehow missed v3 :(

I just had a look at it and most the comments that I have on v2 are still
applicable and IMO need to be addressed before getting merged. You also don't
have a change-log in v3 so I don't understand why you made some changes.

> Also please look at [alsa-devel] davici-mcasp: "tx-num-evt" confusion with 
> number of serializers thread, where are discussed using "tx-num-evt".
> 

Just noticed this one. Will respond to it.

> I tested driver with 2 - 4 - 6 - 8 channnels I2S (2 slots TDM) with using 1 -2 
> -3 -4 serializers. and S16_LE (will do S24_3LE) audio.

Did you use aplay for this? If so, what were the parameters used. If not, can you
describe how the userspace needs to manage the audio buffer? For anyone looking
at leveraging the multi-serializer feature this information is important to
highlight.

Regards,
Vaibhav 
