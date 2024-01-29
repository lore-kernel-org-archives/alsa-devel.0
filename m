Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 611C9C47422
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Jan 2024 13:31:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DF53B7F4;
	Mon, 29 Jan 2024 14:30:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DF53B7F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1706535066;
	bh=USoguoAsVtRzvLdYpwq9PSQwEzZknH4DB77gCTTu4yA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Jlhx3S5fSKRIaq+xOmFbM0fgW16Ypn/p2zVSyibUR8Xpi9hpunNkmabDDWG91SZ0c
	 CjrAdWdb5cP62YNbIjPFAQl6fAGMBE47OkbXVzPtRCJCCm6SD3SuQkcGsLtsfHBkEo
	 fdq9iWN8kuVsJloMTRRZpUra/cuwQlVwHgPafbl0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 34014F805AE; Mon, 29 Jan 2024 14:30:31 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9EDA3F805AD;
	Mon, 29 Jan 2024 14:30:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3695DF80563; Mon, 29 Jan 2024 14:29:52 +0100 (CET)
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A0724F804E7
	for <alsa-devel@alsa-project.org>; Mon, 29 Jan 2024 14:29:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A0724F804E7
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=iki.fi header.i=@iki.fi header.a=rsa-sha256
 header.s=lahtoruutu header.b=HWwgkOWL
Received: from hillosipuli.retiisi.eu
 (2a00-1190-d1dd-0-c641-1eff-feae-163c.v6.cust.suomicom.net
 [IPv6:2a00:1190:d1dd:0:c641:1eff:feae:163c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest
 SHA256)
	(No client certificate requested)
	(Authenticated sender: sailus)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4TNq0D5PsFz49PsS;
	Mon, 29 Jan 2024 15:29:32 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1706534974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ti5qDi4jNpEc7HezPyQo40H85potwB0yNijMtXKik8o=;
	b=HWwgkOWLzH5ghmaXKwfPxaY00WCBofcmOmeghi2AFgVt/hyO0lxbZoR7KNn2YqsjDDUy9T
	wbXioyPTV6I1b0D2uAidHUU6mFcaoQvYC1VYrm2QGg61s8sSwmsXCpQ33nek7u+OAzJiL1
	KohbpioO9kSsyFmmCXj7avOPd3T2DEb4CP8VgEobVn5vqIwJDBPrqA/b63ryCNVgbSY6HB
	uutj+Ia6DCwugd+STbNMcgNqsj73a+jNabtpQLWsmZAcciqdKKVrNLoKw+IIT/z14mTj8c
	sv5VTBBAx4scTr+TTbf9mV2l8LgP8imDKphDmHKw/a5sIKKeN2jV13f3Lh9/lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1706534974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ti5qDi4jNpEc7HezPyQo40H85potwB0yNijMtXKik8o=;
	b=nIXCWyMeKTw4vP1xJ/+s4m+uumY8VJjfXn0U0iNRnY3zJ3M73CFkNL1LF6Urfs0QgTqPMo
	8kCQdKyxDdA5LGaj21SL8MXUvVpHotYd2+BztEFUip9mQXp/Pq54v9ihHIgvZm4UUTBO4m
	geDXx40Y8UuerWe+JV4Q077f0rZJGBGCFOs63pwqTARUF/ootmlkTpWFq96gT85geRskBc
	XaGvTJ3s7Bb2djwDby9WuKDRBEPhfBsIkSTwAHGkuuziOUSUvqpe0srgE/94S8oO3OSGop
	ZNLquxupCinWOdePNujKL/NuccD04MLs1GJzAIw316XmPOTFtGq27Ukdvn4POg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1706534974; a=rsa-sha256;
	cv=none;
	b=qt1DALoLuXyOBmzEPdZI2WBROdMWb7hdl88hVZqDDCu06N5RbUPh/ncIuKZM01ev98Jh0o
	Dw7WoUiDfeoX9R6G+CI0BzNuSBsW23Q+IyScAEDnvhSge2mEHAIsRguf6Umo7Oy5UOwptg
	tu5aj+IWzbzucZborT/3/B0u2CK4srZAkhsuaYDq24Y0u0KZRcD6z4kJ372UxBGg5WwhK2
	3urSaaP7mC/a5NpyS8FMQriAkgsUmdwZ8nX9Eu58QY/kkU9V6IUgwrectDtOpi/jx5cbMQ
	cs6eQGPH+F6TIXofczRppdvM7Z3Jynbi9IN7ntCZ1aagFC2GOl1AvbRvgtsJNA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 1EBAF634C93;
	Mon, 29 Jan 2024 15:29:32 +0200 (EET)
Date: Mon, 29 Jan 2024 13:29:32 +0000
From: Sakari Ailus <sakari.ailus@iki.fi>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	=?iso-8859-1?Q?=22Uwe_Kleine-K=C3=B6nig=22?=
 <u.kleine-koenig@pengutronix.de>,
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
	Frank Rowand <frowand.list@gmail.com>, Helge Deller <deller@gmx.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Rob Herring <robh+dt@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Takashi Iwai <tiwai@suse.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
	linux-fbdev@vger.kernel.org, linux-media@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH v2 00/13] of: property: add port base loop
Message-ID: <ZbeoPBvGJlaJco_J@valkosipuli.retiisi.eu>
References: <87fryhklhb.wl-kuninori.morimoto.gx@renesas.com>
 <20240129122736.GC8131@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129122736.GC8131@pendragon.ideasonboard.com>
Message-ID-Hash: CWNNQZY2A6TVSXNIVG2MXB54RBLH5Y7B
X-Message-ID-Hash: CWNNQZY2A6TVSXNIVG2MXB54RBLH5Y7B
X-MailFrom: sakari.ailus@iki.fi
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CWNNQZY2A6TVSXNIVG2MXB54RBLH5Y7B/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi Laurent, Morimoto-san,

On Mon, Jan 29, 2024 at 02:27:36PM +0200, Laurent Pinchart wrote:
> Hello Morimoto-san,
> 
> (CC'ing Sakari Ailus)

Thanks for cc'ing me.

> 
> On Mon, Jan 29, 2024 at 12:54:24AM +0000, Kuninori Morimoto wrote:
> > 
> > Hi Rob
> > 
> > This is v2 of port base loop patch-set
> > 
> > We have endpoint base functions
> > 	- of_graph_get_next_endpoint()
> > 	- of_graph_get_endpoint_count()
> > 	- for_each_endpoint_of_node()
> > 
> > But to handling "port" base things, it is not useful. We want to have
> > "port" base functions, too. This patch-set adds it.
> > 
> > Because current existing drivers couldn't use "port" base functions,
> > it were implemented in a different way. This patch-set doesn't try
> > to full-replace to avoid unknown bug, try easy / quick replace only
> > for now, but easy to know how "port" base functions are needed.
> > 
> > Because I can't test the driver which I can't use, non-ASoC drivers
> > needs Tested-by, Acked-by.
> 
> The strategy sounds good to me. However, I'm wondering if you shouldn't
> take one more step in the core, and implement these as fwnode
> operations. Or is there a reason why OF is special, and iterating over
> ports would be useful for drivers on OF systems but not on other types
> of systems ?

I'd prefer that, too.

Probably we could use the existing callbacks for endpoint enumeration, for
port enumeration, too, as I don't think this is performance critical in any
way.

-- 
Kind regards,

Sakari Ailus
