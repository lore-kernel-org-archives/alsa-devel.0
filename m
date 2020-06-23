Return-Path: <SRS0=bSXK=AE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B57AC433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Jun 2020 04:06:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22D6F2076A
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Jun 2020 04:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rBR8BtoX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXzxBbbb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22D6F2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 911841709;
	Tue, 23 Jun 2020 06:05:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 911841709
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592885186;
	bh=UVz4+oAosUXKAyVWZlcgGKdvRIQ5BClYVUWNS+XZFDA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rBR8BtoX41hSr9/yhg7j2jgq4Vd/upcu5ZJUQZkqngEPNOYFR4RmtpaWMjhuZFqrd
	 rW+Vm2DJyvvlDeoyd75vlGr14j9DXwN/tLlBTtlSdGMydHN1UmA3J6fT31tg2RujDV
	 f4l9U0kZVun2JYS7cRO1NQbhBqKVpXB5ilD9cPvk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 042F7F8010E;
	Tue, 23 Jun 2020 06:05:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B5485F80234; Tue, 23 Jun 2020 06:05:30 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 525E2F8012F
 for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2020 06:05:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 525E2F8012F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="hXzxBbbb"
Received: from localhost (unknown [171.61.66.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 887A92076A;
 Tue, 23 Jun 2020 04:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592885123;
 bh=UVz4+oAosUXKAyVWZlcgGKdvRIQ5BClYVUWNS+XZFDA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hXzxBbbbYe1Wcpmfu1Vz6vMkRUo6uf50URq/g8XmTvPPrXQwP+nwvV1CoiBtf1ybY
 h8kdo+GlNGbyxaKIyEfiImk1mXOJtq2zfXFAKPfcVsP2hGArGjcvzaXEohAPCuNiTk
 UtGmZ1sMlto+F+fvvAleTPgWTnblr8bIr/XgR0u0=
Date: Tue, 23 Jun 2020 09:35:17 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 1/3] ALSA: compress: document the compress audio state
 machine
Message-ID: <20200623040517.GO2324254@vkoul-mobl>
References: <20200622065811.221485-1-vkoul@kernel.org>
 <20200622065811.221485-2-vkoul@kernel.org>
 <800a2632-b263-500f-707e-c1ce94ce92d4@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <800a2632-b263-500f-707e-c1ce94ce92d4@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>,
 linux-arm-msm@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-kernel@vger.kernel.org
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On 22-06-20, 08:28, Pierre-Louis Bossart wrote:
> 
> 
> On 6/22/20 1:58 AM, Vinod Koul wrote:
> > So we had some discussions of the stream states, so I thought it is a
> > good idea to document the state transitions, so add it documentation
> > 
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >   .../sound/designs/compress-offload.rst        | 52 +++++++++++++++++++
> >   1 file changed, 52 insertions(+)
> > 
> > diff --git a/Documentation/sound/designs/compress-offload.rst b/Documentation/sound/designs/compress-offload.rst
> > index ad4bfbdacc83..6f86db82298b 100644
> > --- a/Documentation/sound/designs/compress-offload.rst
> > +++ b/Documentation/sound/designs/compress-offload.rst
> > @@ -151,6 +151,58 @@ Modifications include:
> >   - Addition of encoding options when required (derived from OpenMAX IL)
> >   - Addition of rateControlSupported (missing in OpenMAX AL)
> > +State Machine
> > +=============
> > +
> > +The compressed audio stream state machine is described below ::
> > +
> > +                                        +----------+
> > +                                        |          |
> > +                                        |   OPEN   |
> > +                                        |          |
> > +                                        +----------+
> > +                                             |
> > +                                             |
> > +                                             | compr_set_params()
> > +                                             |
> > +                                             v
> > +         compr_free()                   +----------+
> > +  +-------------------------------------|          |
> > +  |                                     |   SETUP  |
> > +  |           +------------------------>|          |<---------------------------------+
> > +  |           | compr_drain_notify()    +----------+                                  |
> > +  |           |                              |                                        |
> > +  |           |                              |                                        |
> > +  |           |                              | compr_write()                          |
> > +  |           |                              |                                        |
> > +  |           |                              v                                        |
> > +  |           |                         +----------+                                  |
> > +  |           |                         |          |                                  |
> > +  |           |                         |  PREPARE |                                  |
> > +  |           |                         |          |                                  |
> > +  |           |                         +----------+                                  |
> > +  |           |                              |                                        |
> > +  |           |                              |                                        |
> > +  |           |                              | compr_start()                          |
> > +  |           |                              |                                        |
> > +  |           |                              v                                        |
> > +  |     +----------+                    +----------+  compr_pause()  +----------+     |
> > +  |     |          |    compr_drain()   |          |---------------->|          |     |
> > +  |     |  DRAIN   |<-------------------|  RUNNING |                 |  PAUSE   |     |
> > +  |     |          |                    |          |<----------------|          |     |
> > +  |     +----------+                    +----------+  compr_resume() +----------+     |
> > +  |           |                           |      |                                    |
> > +  |           |                           |      |                                    |
> > +  |           |                           |      |                                    |
> > +  |           |                           |      |          compr_stop()              |
> > +  |           |                           |      +------------------------------------+
> > +  |           |       +----------+        |
> > +  |           |       |          |        |
> > +  +-----------+------>|          |<-------+
> > +     compr_free()     |   FREE   |  compr_free()
> > +                      |          |
> > +                      +----------+
> > +
> 
> Sorry, this confuses me even more...

Oops

> a) can you clarify if we can go from running to free directly? is this
> really a legit transition? There's already the option of doing a stop and a
> a drain.

As Charles pointed it is legit one, but then from SM we should remove
running->free arrow to clarify. Internally, free in running, draining
and paused triggers a stop and then free.

> b) no way to go back to SETUP from PREPARE? What happens if the app never
> starts but want to tear down the resources?

See above, free would trigger an internal step to stop (setup) and then
freed.

Btw I am not adding changes to code but documenting the 'existing'
behaviour, so a code lookup will help

> c) no way to stop a paused stream?

Yes missed that, will add.

-- 
~Vinod
