From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: Re: [PATCH v2] davinci-mcasp: Add support for
 multichannel playback
Date: Wed, 6 Mar 2013 11:19:07 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ED3D448@DBDE01.ent.ti.com>
References: <1361983125-32717-1-git-send-email-michal.bachraty@streamunlimited.com>
 <B5906170F1614E41A8A28DE3B8D121433ED3C660@DBDE01.ent.ti.com>
 <513616F7.2020201@gmail.com>
 <B5906170F1614E41A8A28DE3B8D121433ED3D3ED@DBDE01.ent.ti.com>
 <20130306105713.GF4896@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D90E265388
 for <alsa-devel@alsa-project.org>; Wed,  6 Mar 2013 12:19:12 +0100 (CET)
In-Reply-To: <20130306105713.GF4896@opensource.wolfsonmicro.com>
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Michal Bachraty <michal.bachraty@streamunlimited.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 06, 2013 at 16:27:15, Mark Brown wrote:
> On Wed, Mar 06, 2013 at 10:54:52AM +0000, Bedia, Vaibhav wrote:
> 
> > Since you are using a multichannel codec things are a lot simplified for you :)
> > Someone might want to hook up multiple codecs to get multi-channel behavior.
> > There will be only 1 CPU DAI but there can be upto 16 CODEC DAIs operating in
> > sync. I haven't really followed the recent ASoC changes so I don't know whether
> > something like this can be handled right now.
> 
> > Mark, Liam,
> 
> > Any suggestions?
> 
> Nobody with any interest in such systems has stepped up to work on the
> framework, and of course relatively little CPU hardware supports
> multiple streams on a single DAI.
> 

Ok. Thinking more on this I guess the situation I described above will indeed be a rare
case. There would be additional complexity in ensuring that the codecs are always operating
in sync. It would perhaps be simpler to cascade the codecs (if supported) and use only one
interface to transfer the data. Or just use multichannel codec like Michal and Daniel
are doing.

Regards,
Vaibhav
