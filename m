From: Dimitris Papavasiliou <dpapavas@gmail.com>
Subject: Re: Need help fixing pop/click artifacts in an ASOC
 driver
Date: Thu, 20 Dec 2018 22:41:40 +0200
Message-ID: <c95346b8-335a-88c4-484b-9ad4e1aebc12@gmail.com>
References: <20181217123703.GF13868@sirena.org.uk>
 <7dbf7969-c0ea-fe13-2044-17f36e458e21@gmail.com>
 <20181217141008.GA27909@sirena.org.uk>
 <53b182ce-c12b-6b97-4e26-f80d0651e8fa@gmail.com>
 <20181217154043.GC27909@sirena.org.uk>
 <f743bf6b-b10a-6c00-57d7-3a0df67d7bba@gmail.com>
 <20181217165257.GD27909@sirena.org.uk>
 <5a2103c5-194b-cb21-672e-d472e91825a8@gmail.com>
 <20181219161949.GD8130@sirena.org.uk>
 <8c996338-19a3-996b-16dc-5535688ccea2@gmail.com>
 <20181220153613.GC9325@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 73C472678D4
 for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2018 21:41:43 +0100 (CET)
Received: by mail-wm1-f67.google.com with SMTP id a62so3377920wmh.4
 for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2018 12:41:43 -0800 (PST)
In-Reply-To: <20181220153613.GC9325@sirena.org.uk>
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

On 12/20/18 5:36 PM, Mark Brown wrote:
> On Wed, Dec 19, 2018 at 11:44:46PM +0200, Dimitris Papavasiliou wrote:
>> I got pops even if I opened the stream, called hw_params and closed it
>> on each iteration, but, as it turns out, that was in part because I
>> was being lazy, using a Python script to do the above, which sneaked
>> in a hw_params call immediately after opening the stream, to "reset"
>> it to default values.
> 
> Wow, that's...  interesting.

I'm not sure if you're referring to the Python module's behavior, or to
the fact that I was so careless and am now boring you with it, so I'm
going to assume the former. :)

>> So I've retried your suggested approach.  It looks like setting
>> .ignore_pmdown_time = 1 in the snd_soc_dai_link of the machine driver
>> is enough to cause immediate power ups/downs, but I get the following
>> behavior: The device gets powered up immediately after the first
>> hw_params call (even if nothing gets played subsequently) and it gets
> 
> Are you sure it's the hw_params() call itself?
> 
>[...]
> 
> This is what's supposed to happen.  DAPM is triggered in the prepare()
> callback, you can call hw_params() as often as you like and it should
> have no interaction with DAPM at all.

Ah, well, the explanation then probably lies in the fact that
snd_pcm_hw_params, according to the documentation also prepares the
stream:

> Install one PCM hardware configuration chosen from a configuration
> space and snd_pcm_prepare it.

As far as I can see there's no other way to call hw_params from
userspace, except for snd_pcm_set_params, which is just a wrapper that
calls snd_pcm_hw_params internally, so I suppose calling hw_params to
configure the stream, must inevitably lead to the device being powered
up.

Unfortunately the documentation ("Writing an ALSA Driver") on the
prepare callback even warns explicitly, to:

> Be careful that this callback will be called many times at each
> setup, too.

I'm not sure if this implies that configuring the card in multiple
steps when setting up the stream is expected behavior, but it could be
interpreted that way.

Should we then accept, that some pops will be generated and hope that
they'll be suppressed by the digital_mute callback?
