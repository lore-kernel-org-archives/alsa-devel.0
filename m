From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 2/4] soundwire: cdns: fix check for number
	of messages
Date: Fri, 29 Mar 2019 11:24:46 +0530
Message-ID: <20190329055446.GJ5348@vkoul-mobl>
References: <20190328134134.22479-1-srinivas.kandagatla@linaro.org>
 <20190328134134.22479-3-srinivas.kandagatla@linaro.org>
 <797b8525-dbcd-e52b-7b36-b80427a80186@linux.intel.com>
 <28b05dc7-f269-0091-53ab-4390f613fc09@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7517DF8071D
 for <alsa-devel@alsa-project.org>; Fri, 29 Mar 2019 06:54:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <28b05dc7-f269-0091-53ab-4390f613fc09@linaro.org>
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
Cc: sanyog.r.kale@intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 28-03-19, 14:58, Srinivas Kandagatla wrote:
> =

> =

> On 28/03/2019 14:03, Pierre-Louis Bossart wrote:
> > > ---
> > > =A0 drivers/soundwire/cadence_master.c | 2 +-
> > > =A0 1 file changed, 1 insertion(+), 1 deletion(-)
> > > =

> > > diff --git a/drivers/soundwire/cadence_master.c
> > > b/drivers/soundwire/cadence_master.c
> > > index cb6a331f448a..d41adbc57918 100644
> > > --- a/drivers/soundwire/cadence_master.c
> > > +++ b/drivers/soundwire/cadence_master.c
> > > @@ -434,7 +434,7 @@ cdns_xfer_msg_defer(struct sdw_bus *bus,
> > > =A0=A0=A0=A0=A0 int cmd =3D 0, ret;
> > > =A0=A0=A0=A0=A0 /* for defer only 1 message is supported */
> > > -=A0=A0=A0 if (msg->len > 1)
> > =

> > I am not sure this is a typo.
> > =

> =

> Am bit confused with defer data-structure itself.
> =

> I was assuming that defer->length is number of sdw messages in the
> structure. If its same as message lenght then sdw_msg->len and
> sdw_defer->length are totally redundant. May be we should get rid of leng=
ht
> field in defer to avoid confusion?

Sorry Srini, I didnt pay much attention to it last time we discussed. So
relooking at the code, we send msg as a message to trf (defered or not)
and then copy length few lines down, but I agree this is not most useful
and should be cleaned up.

> > IRRC the hardware only defer e.g. a single write that can perform bank
> > switches and writes at specific times indicated with an SSP. What's more
> okay got it.
> Does that mean that candence controller can only support 1 byte defer
> transfers?

I think so, Pierre can confirm.

> > is that the defer structure is actually modified below this code (not
> > shown in the diff) to set defer>length =3D msg->len, so testing before =
the
> > value is set looks more suspicious than the current code.
> =

> removing the length field in defer should get rid of such instances.

Right!

-- =

~Vinod
