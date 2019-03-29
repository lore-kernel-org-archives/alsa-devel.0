From: Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH 2/4] soundwire: cdns: fix check for number
	of messages
Date: Fri, 29 Mar 2019 09:21:45 +0530
Message-ID: <20190329035145.GA9440@buildpc-HP-Z230>
References: <20190328134134.22479-1-srinivas.kandagatla@linaro.org>
 <20190328134134.22479-3-srinivas.kandagatla@linaro.org>
 <797b8525-dbcd-e52b-7b36-b80427a80186@linux.intel.com>
 <28b05dc7-f269-0091-53ab-4390f613fc09@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 54FDEF80C16
 for <alsa-devel@alsa-project.org>; Fri, 29 Mar 2019 04:50:28 +0100 (CET)
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
Cc: vkoul@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 28, 2019 at 02:58:27PM +0000, Srinivas Kandagatla wrote:
> 
> 
> On 28/03/2019 14:03, Pierre-Louis Bossart wrote:
> > > ---
> > > ?? drivers/soundwire/cadence_master.c | 2 +-
> > > ?? 1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/soundwire/cadence_master.c
> > > b/drivers/soundwire/cadence_master.c
> > > index cb6a331f448a..d41adbc57918 100644
> > > --- a/drivers/soundwire/cadence_master.c
> > > +++ b/drivers/soundwire/cadence_master.c
> > > @@ -434,7 +434,7 @@ cdns_xfer_msg_defer(struct sdw_bus *bus,
> > > ?????????? int cmd = 0, ret;
> > > ?????????? /* for defer only 1 message is supported */
> > > -?????? if (msg->len > 1)
> > 
> > I am not sure this is a typo.
> > 
> 
> Am bit confused with defer data-structure itself.
> 
> I was assuming that defer->length is number of sdw messages in the
> structure. If its same as message lenght then sdw_msg->len and
> sdw_defer->length are totally redundant. May be we should get rid of lenght
> field in defer to avoid confusion?
> 
> > IRRC the hardware only defer e.g. a single write that can perform bank
> > switches and writes at specific times indicated with an SSP. What's more
> okay got it.
> Does that mean that candence controller can only support 1 byte defer
> transfers?
> 
> > is that the defer structure is actually modified below this code (not
> > shown in the diff) to set defer>length = msg->len, so testing before the
> > value is set looks more suspicious than the current code.
> 
> removing the length field in defer should get rid of such instances.
>

defer->length is passed as count in cdns_fill_msg_resp function while
processing response of defer message. we can as well use msg->len and
remove length from sdw_defer. I dont see any other instance where
defer->length is used.

> --srini
> 
> > 
> > Vinod, does this ring a bell?
> > 
> > 
> > > +?????? if (defer->length > 1)
> > > ?????????????????? return -ENOTSUPP;
> > > ?????????? ret = cdns_prep_msg(cdns, msg, &cmd);

-- 
