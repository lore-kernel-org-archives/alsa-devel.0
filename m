From: Michal Bachraty <michal.bachraty@streamunlimited.com>
Subject: Re: [PATCH v2] davinci-mcasp: Add support for
	multichannel	playback
Date: Tue, 05 Mar 2013 13:24:05 +0100
Message-ID: <1671626.qyAbYsuZgK@ganymedes>
References: <1361983125-32717-1-git-send-email-michal.bachraty@streamunlimited.com>
 <2365072.cAK26ghdqV@ganymedes>
 <B5906170F1614E41A8A28DE3B8D121433ED3C79F@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.inode.at (mx10.lb01.inode.at [62.99.145.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FFF4265224
 for <alsa-devel@alsa-project.org>; Tue,  5 Mar 2013 13:24:06 +0100 (CET)
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433ED3C79F@DBDE01.ent.ti.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tuesday, March 05, 2013 12:03:45 Bedia, Vaibhav wrote:
> I just had a look at it and most the comments that I have on v2 are still
> applicable and IMO need to be addressed before getting merged. You also
> don't have a change-log in v3 so I don't understand why you made some
> changes.

I found that, there is need to upgrade for other TDM slots configs.

> > I tested driver with 2 - 4 - 6 - 8 channnels I2S (2 slots TDM) with using
> > 1 -2 -3 -4 serializers. and S16_LE (will do S24_3LE) audio.
> 
> Did you use aplay for this? If so, what were the parameters used. If not,
> can you describe how the userspace needs to manage the audio buffer? For
> anyone looking at leveraging the multi-serializer feature this information
> is important to highlight.

Yes aplay  -D "hw:1,0" -r48000 -fS16_LE -c6 < sine16_6ch.txt or similar. I 
hear 6ch audio on TAS5086. Also I had generated data and I saw data on 
oscilloscope.
This patch only exteds driver for using more serializers. When you run 2ch. or 
one serializer), there is same configuration  as was in previous driver 
version.

Best,
Michal
