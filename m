From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 3/4] soundwire: bus: check if pm runtime is
 enabled before calling
Date: Fri, 29 Mar 2019 11:28:28 +0530
Message-ID: <20190329055828.GK5348@vkoul-mobl>
References: <20190328134134.22479-1-srinivas.kandagatla@linaro.org>
 <20190328134134.22479-4-srinivas.kandagatla@linaro.org>
 <e2522fa7-298e-9385-9686-7c3ce3c8a03b@linux.intel.com>
 <5f4ef5ca-b90f-4e25-f006-78983fd2bcfc@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2BC90F8071D
 for <alsa-devel@alsa-project.org>; Fri, 29 Mar 2019 06:58:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <5f4ef5ca-b90f-4e25-f006-78983fd2bcfc@linaro.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: sanyog.r.kale@intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On 28-03-19, 14:37, Srinivas Kandagatla wrote:
> =

> =

> On 28/03/2019 13:55, Pierre-Louis Bossart wrote:
> > On 3/28/19 9:41 AM, Srinivas Kandagatla wrote:
> > > Check the device has pm runtime enabled before returning error.
> > > =

> > > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > > ---
> > > =A0 drivers/soundwire/bus.c | 16 ++++++++++------
> > > =A0 1 file changed, 10 insertions(+), 6 deletions(-)
> > > =

> > > diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> > > index 1cbfedfc20ef..101562a6fb0d 100644
> > > --- a/drivers/soundwire/bus.c
> > > +++ b/drivers/soundwire/bus.c
> > > @@ -327,9 +327,11 @@ int sdw_nread(struct sdw_slave *slave, u32
> > > addr, size_t count, u8 *val)
> > > =A0=A0=A0=A0=A0 if (ret < 0)
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
> > > -=A0=A0=A0 ret =3D pm_runtime_get_sync(slave->bus->dev);
> > > -=A0=A0=A0 if (ret < 0)
> > > -=A0=A0=A0=A0=A0=A0=A0 return ret;
> > > +=A0=A0=A0 if (pm_runtime_enabled(slave->bus->dev)) {
> > > +=A0=A0=A0=A0=A0=A0=A0 ret =3D pm_runtime_get_sync(slave->bus->dev);
> > =

> > Is this an recommended/accepted sequence in kernel circles? I did a
> > quick git grep and don't see anyone using this sort of tests.
> =

> There are lots of users in kernel with such sequences, ex:
> =

> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/iommu/arm-smmu.c?h=3Dv5.1-rc2#n279

Sorry not a fan of this :) I think PM core should do this :D

I guess you are trying to solve the case where PM can be disabled for a
device and pm_runtime_get_sync() returns error right?

That would be quite a common sequence in most frameworks..

Thanks


> =

> > =

> > =

> > > +=A0=A0=A0=A0=A0=A0=A0 if (ret < 0)
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
> > > +=A0=A0=A0 }
> > > =A0=A0=A0=A0=A0 ret =3D sdw_transfer(slave->bus, &msg);
> > > =A0=A0=A0=A0=A0 pm_runtime_put(slave->bus->dev);
> > =

> > and the weird thing is that you don't test for the put() case?
> > =

> > > @@ -355,9 +357,11 @@ int sdw_nwrite(struct sdw_slave *slave, u32
> > > addr, size_t count, u8 *val)
> > > =A0=A0=A0=A0=A0 if (ret < 0)
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
> > > -=A0=A0=A0 ret =3D pm_runtime_get_sync(slave->bus->dev);
> > > -=A0=A0=A0 if (ret < 0)
> > > -=A0=A0=A0=A0=A0=A0=A0 return ret;
> > > +=A0=A0=A0 if (pm_runtime_enabled(slave->bus->dev)) {
> > > +=A0=A0=A0=A0=A0=A0=A0 ret =3D pm_runtime_get_sync(slave->bus->dev);
> > > +=A0=A0=A0=A0=A0=A0=A0 if (ret < 0)
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
> > > +=A0=A0=A0 }
> > > =A0=A0=A0=A0=A0 ret =3D sdw_transfer(slave->bus, &msg);
> > > =A0=A0=A0=A0=A0 pm_runtime_put(slave->bus->dev);
> =

> I should add a check in this path as well.
> =

> Thanks,
> srini
> =

> > > =

> > =


-- =

~Vinod
