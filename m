From: Dimitris Papavasiliou <dpapavas@gmail.com>
Subject: Re: Need help fixing pop/click artifacts in an ASOC
 driver
Date: Mon, 17 Dec 2018 17:03:04 +0200
Message-ID: <53b182ce-c12b-6b97-4e26-f80d0651e8fa@gmail.com>
References: <b48bc9d6-767a-24df-692e-fe675afed22e@gmail.com>
 <20181115003313.GH2089@sirena.org.uk>
 <56e02571-fd5b-0add-c6c7-98e4f746448c@gmail.com>
 <20181115190403.GI2089@sirena.org.uk>
 <00b68fe8-403d-b129-1166-f414e5bd21ab@gmail.com>
 <724efe46-d604-0de1-caa2-efcfd7c91510@gmail.com>
 <20181213174229.GU10669@sirena.org.uk>
 <fff018b4-c2e5-d3f3-0589-b837e62e9c5e@gmail.com>
 <20181217123703.GF13868@sirena.org.uk>
 <7dbf7969-c0ea-fe13-2044-17f36e458e21@gmail.com>
 <20181217141008.GA27909@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F1D3267AE0
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2018 16:03:07 +0100 (CET)
Received: by mail-wm1-f65.google.com with SMTP id y139so12596577wmc.5
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2018 07:03:07 -0800 (PST)
In-Reply-To: <20181217141008.GA27909@sirena.org.uk>
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

On 12/17/18 4:10 PM, Mark Brown wrote:
> On Mon, Dec 17, 2018 at 02:58:03PM +0200, Dimitris Papavasiliou wrote:
> 
>> In general the clocks need to be switched during the hw_params
>> callback (when the new callback specifies a new sample rate,
>> which needs the other clock) and, as far as I can see, this can
>> happen at more or less any time, i.e. in all power states and
>> regardless of whether the device is opened or closed.
> 
> It shouldn't be called while the stream is running, if it is it'd be
> entirely fine to just return an error.

It's not called while the stream is running, or at least I
haven't seen that happen.  It can be called though, while the
device is opened and fully powered up, for instance when
switching tracks during playback, where the next track has a
different sample rate.  This scenario is relatively frequent
during normal use of a DAC and can't be avoided, as far as I can
see.
