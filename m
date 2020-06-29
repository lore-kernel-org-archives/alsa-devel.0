Return-Path: <SRS0=wrte=AK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77246C433DF
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:35:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0188423139
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RoKmxzgB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="profOf+O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0188423139
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 654FE84C;
	Mon, 29 Jun 2020 11:34:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 654FE84C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593423338;
	bh=00blYSw4H3we8f6YNcADktzYDOCPmayZbfhVhGUiz6o=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RoKmxzgBIXdrvhDvxxbCpEO8KJAwOHC1zD1tX5rVQQBjypF39w7rRMoLVtw3uU4BA
	 A0/k0yBzLbOBrhj/mvq5EKAW/yD3H7d98S4xIqhpNWGuFQLRDed5Q1cztVAS52Xcko
	 7TI4ur9kad49nITn3ppCBkJxcg/1h2/sp7MkO+Dk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DDA94F801F8;
	Mon, 29 Jun 2020 11:34:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BCFC6F8020C; Mon, 29 Jun 2020 11:34:45 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 61FCAF80096
 for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2020 11:34:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 61FCAF80096
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="profOf+O"
Received: from localhost (unknown [122.182.251.219])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CF13820857;
 Mon, 29 Jun 2020 09:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593423274;
 bh=00blYSw4H3we8f6YNcADktzYDOCPmayZbfhVhGUiz6o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=profOf+OjR7WE03HKWGRwyP+LXIRgPlX8syXRo/3NQJ8Cr9hQPWee9UDxZACi3WCF
 ONI2Zny5nkvY3b1m12zOrx6cBSzw69Dv+tVQDZ/PKSubTsWPxVS6ATnMHH7swTNwlL
 vSa10APt2UUDEq5Qh4vgF2mM7T2ZQMh2/ocuIec4=
Date: Mon, 29 Jun 2020 15:04:29 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>
Subject: Re: [PATCH v4 1/3] ALSA: compress: document the compress audio state
 machine
Message-ID: <20200629093429.GA2599@vkoul-mobl>
References: <20200629075002.11436-1-vkoul@kernel.org>
 <20200629075002.11436-2-vkoul@kernel.org>
 <c29b3199-cebd-2153-5530-e75f76aa8b4b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c29b3199-cebd-2153-5530-e75f76aa8b4b@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>,
 linux-kernel@vger.kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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

Hi Amadeusz,

On 29-06-20, 11:05, Amadeusz Sławiński wrote:
> 
> 
> On 6/29/2020 9:50 AM, Vinod Koul wrote:
> > So we had some discussions of the stream states, so I thought it is a
> > good idea to document the state transitions, so add it documentation
> > 
> > Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >   .../sound/designs/compress-offload.rst        | 51 +++++++++++++++++++
> >   1 file changed, 51 insertions(+)
> > 
> > diff --git a/Documentation/sound/designs/compress-offload.rst b/Documentation/sound/designs/compress-offload.rst
> > index ad4bfbdacc83..b6e9025ae105 100644
> > --- a/Documentation/sound/designs/compress-offload.rst
> > +++ b/Documentation/sound/designs/compress-offload.rst
> > @@ -151,6 +151,57 @@ Modifications include:
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
> > +  +------------------------------------|          |
> > +  |                                    |   SETUP  |
> > +  |          +------------------------>|          |<-------------------------+
> > +  |          | compr_drain_notify()    +----------+                          |
> > +  |          |         or                   ^                                |
> > +  |          |      compr_stop()            |                                |
> > +  |          |                              | compr_write()                  |
> > +  |          |                              |                                |
> > +  |          |                              |                                |

Not sure, this is not in the version I posted, arrow is from setup ->
prepare. See https://lore.kernel.org/alsa-devel/20200629075002.11436-2-vkoul@kernel.org/

I don't know how it got reversed in your version, maybe the MUA messed
up??

> > +  |          |                         +----------+                          |
> > +  |          |                         |          |   compr_free()           |
> > +  |          |                         |  PREPARE |---------------> A        |
> > +  |          |                         |          |                          |
> > +  |          |                         +----------+                          |
> > +  |          |                              |                                |
> > +  |          |                              |                                |
> > +  |          |                              | compr_start()                  |
> > +  |          |                              |                                |
> > +  |          |                              v                                |
> > +  |    +----------+                    +----------+                          |
> > +  |    |          |    compr_drain()   |          |        compr_stop()      |
> > +  |    |  DRAIN   |<-------------------|  RUNNING |--------------------------+
> > +  |    |          |                    |          |                          |
> > +  |    +----------+                    +----------+                          |
> > +  |                                       |    ^                             |
> > +  |          A                            |    |                             |
> > +  |          |              compr_pause() |    | compr_resume()              |
> > +  |          |                            |    |                             |
> > +  |          v                            v    |                             |
> > +  |    +----------+                   +----------+                           |
> > +  |    |          |                   |          |         compr_stop()      |
> > +  +--->|   FREE   |                   |  PAUSE   |---------------------------+
> > +       |          |                   |          |
> > +       +----------+                   +----------+
> > +
> >   Gapless Playback
> >   ================
> > 
> 
> Line containing compr_free (between SETUP and FREE) seems to be misaligned?

not in the version I posted and see on lore

> If you move prepare to the left and drain in place of drain, it feels like
> you won't need this weird indirection with A

yeah that was a compromise to make it bit neater to me than adding
overlapping arrows...

> Something like:
> 
> >> +                                             v
> > > +         compr_free()                   +----------+
> > > +  +------------------------------------|          |
> > > +  |                                    |   SETUP  |
> > > +  |          +------------------------>|          |<-------------------------+
> > > +  |          | compr_write()           +----------+                          |
> > > +  |          |                              ^                                |
> > > +  |          |                              | compr_drain_notify() or        |
> > > +  |          |                              | compr_stop()                   |
> > > +  |          |                              |                                |
> > > +  |          |                              |                                |
> > > +  |          |                         +----------+                          |
> > > +  |          |                         |          |                          |
> > > +  |          |                         |  DRAIN   |                          |
> > > +  |          |                         |          |                          |
> > > +  |          |                         +----------+                          |
> > > +  |          |                              ^                                |
> > > +  |          |                              |                                |
> > > +  |          |                              | compr_drain()                  |
> > > +  |          |                              |                                |
> > > +  |          |                              |                                |
> > > +  |    +----------+                    +----------+                          |
> > > +  |    |          |    compr_start()   |          |        compr_stop()      |
> > > +  |    |  PREPARE |------------------->|  RUNNING |--------------------------+
> > > +  |    |          |                    |          |                          |
> > > +  |    +----------+                    +----------+                          |
> > > +  |          |                            |    ^                             |
> > > +  |          | compr_free()               |    |                             |
> > > +  |          |              compr_pause() |    | compr_resume()              |
> > > +  |          |                            |    |                             |
> > > +  |          v                            v    |                             |
> > > +  |    +----------+                   +----------+                           |
> > > +  |    |          |                   |          |         compr_stop()      |
> > > +  +--->|   FREE   |                   |  PAUSE   |---------------------------+
> > > +       |          |                   |          |
> > > +       +----------+                   +----------+
> > > +
> 

> but this makes me question PREPARE state, how do you enter it?

a compr_write() moves from SETUP -> PREPARE. Fixing that above looks
better version of mine..

-- 
~Vinod
