From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [PATCH 3/4] soundwire: bus: check if pm runtime is
 enabled before calling
Date: Fri, 05 Apr 2019 08:26:44 -0700
Message-ID: <1b1f66581b4ec8acf94638191d90ce95e790a566.camel@linux.intel.com>
References: <20190328134134.22479-1-srinivas.kandagatla@linaro.org>
 <20190328134134.22479-4-srinivas.kandagatla@linaro.org>
 <e2522fa7-298e-9385-9686-7c3ce3c8a03b@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 83315F80C1B
 for <alsa-devel@alsa-project.org>; Fri,  5 Apr 2019 17:26:47 +0200 (CEST)
In-Reply-To: <e2522fa7-298e-9385-9686-7c3ce3c8a03b@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, vkoul@kernel.org
Cc: sanyog.r.kale@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2019-03-28 at 09:55 -0400, Pierre-Louis Bossart wrote:
> On 3/28/19 9:41 AM, Srinivas Kandagatla wrote:
> > Check the device has pm runtime enabled before returning error.
> > 
> > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > ---
> >   drivers/soundwire/bus.c | 16 ++++++++++------
> >   1 file changed, 10 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> > index 1cbfedfc20ef..101562a6fb0d 100644
> > --- a/drivers/soundwire/bus.c
> > +++ b/drivers/soundwire/bus.c
> > @@ -327,9 +327,11 @@ int sdw_nread(struct sdw_slave *slave, u32
> > addr, size_t count, u8 *val)
> >   	if (ret < 0)
> >   		return ret;
> >   
> > -	ret = pm_runtime_get_sync(slave->bus->dev);
> > -	if (ret < 0)
> > -		return ret;
> > +	if (pm_runtime_enabled(slave->bus->dev)) {
> > +		ret = pm_runtime_get_sync(slave->bus->dev);
> 
> Is this an recommended/accepted sequence in kernel circles? I did a 
> quick git grep and don't see anyone using this sort of tests.
Hi Srinivas/Pierre,

Sorry for the delayed reply.

The only instance where I have seen the pm_runtime_get_sync() fail is
not because pm_runtime was disabled. But it is because the power is
powered off when trying to do a pm_runtime_get_sync().

I'm not very familiar with the code in soundwire yet, but is it
possible that the pm_domain supplier has powered off the soundwire
device and would cause a failure in pm_runtime_get_sync()?

Thanks,
Ranjani

> 
> 
> > +		if (ret < 0)
> > +			return ret;
> > +	}
> >   
> >   	ret = sdw_transfer(slave->bus, &msg);
> >   	pm_runtime_put(slave->bus->dev);
> 
> and the weird thing is that you don't test for the put() case?
> 
> > @@ -355,9 +357,11 @@ int sdw_nwrite(struct sdw_slave *slave, u32
> > addr, size_t count, u8 *val)
> >   	if (ret < 0)
> >   		return ret;
> >   
> > -	ret = pm_runtime_get_sync(slave->bus->dev);
> > -	if (ret < 0)
> > -		return ret;
> > +	if (pm_runtime_enabled(slave->bus->dev)) {
> > +		ret = pm_runtime_get_sync(slave->bus->dev);
> > +		if (ret < 0)
> > +			return ret;
> > +	}
> >   
> >   	ret = sdw_transfer(slave->bus, &msg);
> >   	pm_runtime_put(slave->bus->dev);
> > 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
