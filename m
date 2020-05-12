Return-Path: <SRS0=GrjN=62=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F137EC47255
	for <alsa-devel@archiver.kernel.org>; Tue, 12 May 2020 01:02:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7986A206DD
	for <alsa-devel@archiver.kernel.org>; Tue, 12 May 2020 01:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dM/Lk2MU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7986A206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BB4CA86E;
	Tue, 12 May 2020 03:01:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BB4CA86E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589245353;
	bh=cyky/8q9wfsNIQtjq9VHtDFiMXuKn0HuIYQGSx3OCg8=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dM/Lk2MU5MbOXZVJ2fXRH2yHtKYaeO/k2oeI24vGbREsUS17sCjbSKzpNIODEyqnq
	 Ypxi3RoXd4NqYmjU4X+WXJ9ka5nk0ClYwB8XGU+5gGScaabMTz0soghfnf1Vl8Db3Q
	 gdGPhwXe4ntIJ19qYXCJ5xYGp2xSxJTuVjUNNBSs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 70371F802FD;
	Tue, 12 May 2020 02:55:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E94D0F802FE; Tue, 12 May 2020 02:55:55 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5AAB7F802FB
 for <alsa-devel@alsa-project.org>; Tue, 12 May 2020 02:55:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5AAB7F802FB
IronPort-SDR: MpdKuZHiTd25EPLP2uDc3Y51tQ9vKzywQZ3fOzlyb7sdoNz7hjA9PvhkHpA98GyGhXaGQJn2QC
 GteONVOM81CQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2020 17:55:47 -0700
IronPort-SDR: 8htOBMYaL7VjYcyYmdVijR6y0IOjI0rIX0OR7eLXhRwwKkuEBGPzGDBnHd4EfV9TibxQG4ecd/
 dRsx/Sl9tM2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,381,1583222400"; d="scan'208";a="297860090"
Received: from ajgalle-mobl.amr.corp.intel.com ([10.254.179.28])
 by orsmga008.jf.intel.com with ESMTP; 11 May 2020 17:55:47 -0700
Message-ID: <d5549da9b0160c7b4dcf160ef3a723b32b03a1ae.camel@linux.intel.com>
Subject: Re: [PATCH 02/17] ASoC: use snd_soc_dai/component_activity()
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 11 May 2020 17:55:46 -0700
In-Reply-To: <87ftc681v5.wl-kuninori.morimoto.gx@renesas.com>
References: <875zd39frp.wl-kuninori.morimoto.gx@renesas.com>
 <8736879fqa.wl-kuninori.morimoto.gx@renesas.com>
 <d0850429f144f345864776afb59410693abfd33b.camel@linux.intel.com>
 <87ftc681v5.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
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

On Tue, 2020-05-12 at 08:53 +0900, Kuninori Morimoto wrote:
> Hi Ranjani
> 
> Thank you for reviewing
> 
> > > -	if (!cpu_dai->active)
> > > +	if (!snd_soc_dai_activity(cpu_dai))
> > 
> > I have a feeling this is probably incorrect. snd_soc_dai_activity()
> > checks for stream_active count which is different from
> > snd_soc_dai's
> > active member, isnt it?
> 
> OK, let me check.
> The original code is like this
> 
> 	static void snd_soc_runtime_action(struct snd_soc_pcm_runtime
> *rtd,
> 					   int stream, int action)
> 	{
> 		...
> 		for_each_rtd_dais(rtd, i, dai) {
> 			dai->stream_active[stream] += action;
> 			dai->active += action;
> 			...
> 		}
> 	}
> 
> 	void snd_soc_runtime_activate(...)
> 	{
> 		snd_soc_runtime_action(rtd, stream, 1);
> 	}
> 
> 	void snd_soc_runtime_deactivate(...)
> 	{
> 		snd_soc_runtime_action(rtd, stream, -1);
> 	}
> 
> 
> Basically, ASoC calls
> snd_soc_runtime_activate()   for activate count up, and,
> snd_soc_runtime_deactivate() for activate count down.
> 
> I think snd_soc_dai_activity() is correct, *so far*.
> 
> Exceptions are
> soc-dapm.c :: snd_soc_dai_link_event_pre_pmu()
> soc-dapm.c :: snd_soc_dai_link_event()
> 
> 	snd_soc_dai_link_event_pre_pmu(...)
> 	{
> 		...
> 		snd_soc_dapm_widget_for_each_source_path(w, path) {
> 			...
> 			source->active++;
> 		}
> 		...
> 		snd_soc_dapm_widget_for_each_sink_path(w, path) {
> 			...
> 			sink->active++;
> 		}
> 		...
> 	}
> 
> 	snd_soc_dai_link_event(...)
> 	{
> 		...
> 		snd_soc_dapm_widget_for_each_source_path(w, path) {
> 			...
> 			source->active--;
> 			...
> 		}
> 
> 		snd_soc_dapm_widget_for_each_sink_path(w, path) {
> 			...
> 			sink->active--;
> 			...
> 		}
> 		...
> 	}
> 	
> Only these directly access to dai->active, *without* thinking
> stream_active.
> I think it should use snd_soc_runtime_activate() /
> snd_soc_runtime_deactivate().
> My patch cares it... Oops !!
> I thought my patch cares it, but not enough (= [02/17]).
> 
> Can you agree below ?
> 	1) use runtime_activate()/deactivate() at above functions.
I am wondering what the original intention for having separate
stream_active and active members for snd_soc_dai was. With your
proposal there wouldnt be a need for "active" anymore, isnt it?

Thanks,
Ranjani

