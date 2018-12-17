From: Dimitris Papavasiliou <dpapavas@gmail.com>
Subject: Re: Need help fixing pop/click artifacts in an ASOC
 driver
Date: Mon, 17 Dec 2018 18:23:43 +0200
Message-ID: <f743bf6b-b10a-6c00-57d7-3a0df67d7bba@gmail.com>
References: <56e02571-fd5b-0add-c6c7-98e4f746448c@gmail.com>
 <20181115190403.GI2089@sirena.org.uk>
 <00b68fe8-403d-b129-1166-f414e5bd21ab@gmail.com>
 <724efe46-d604-0de1-caa2-efcfd7c91510@gmail.com>
 <20181213174229.GU10669@sirena.org.uk>
 <fff018b4-c2e5-d3f3-0589-b837e62e9c5e@gmail.com>
 <20181217123703.GF13868@sirena.org.uk>
 <7dbf7969-c0ea-fe13-2044-17f36e458e21@gmail.com>
 <20181217141008.GA27909@sirena.org.uk>
 <53b182ce-c12b-6b97-4e26-f80d0651e8fa@gmail.com>
 <20181217154043.GC27909@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by alsa0.perex.cz (Postfix) with ESMTP id CB5B1267944
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2018 17:23:46 +0100 (CET)
Received: by mail-wr1-f47.google.com with SMTP id p4so12911162wrt.7
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2018 08:23:46 -0800 (PST)
In-Reply-To: <20181217154043.GC27909@sirena.org.uk>
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



On 12/17/18 5:40 PM, Mark Brown wrote:
> That's why I was suggesting that you should be configuring the power
> down time.

I've already tried your suggestion, but unfortunately it doesn't
work in the general case, as it doesn't help when the hw_params
callback is called while the device is opened (but not playing).

I'm quoting my initial reply below for your convenience; you can look
up the whole message if needed.  Apologies in advance, if you've
replied to this and I've somehow missed it.

On 11/18/18 3:37 PM, Dimitris Papavasiliou wrote:
 > Thanks for clarifying about idle_bias_off/ignore_pmdown_time.  As
 > far as I can see, idle_bias_off seems to be set by default, as
 > the pcm512x driver is now a component driver and idle_bias_on is
 > not set to true.  I've also tried to explicitly set it to false,
 > as well as setting use_pmdown_time to false. As far as
 > ignore_pmdown_time is concerned, it seems to be settable at the
 > dai_link level now, which is convenient for my use case.
 >
 > Unfortunately none of this helps.  Although the chip is turned
 > off without delay, it's turned off only while the device is
 > closed.  As soon as the device is opened, it is turned on and
 > kept on during all subsequent hw_params calls, where clock
 > switching takes place.  The pops always get through.
