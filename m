From: "Babu, Ramesh" <ramesh.babu@intel.com>
Subject: Re: [PATCH v2 1/2] ASoC: core: Add flag to ignore
 pmdown_time at pcm_close
Date: Fri, 21 Oct 2011 16:28:44 +0530
Message-ID: <12D0C12AF19E15409D57F22566E88EF50A813D504E@bgsmsx501.gar.corp.intel.com>
References: <1318592614-13110-1-git-send-email-peter.ujfalusi@ti.com>
	<1318592614-13110-2-git-send-email-peter.ujfalusi@ti.com>
	<12D0C12AF19E15409D57F22566E88EF50A813690AD@bgsmsx501.gar.corp.intel.com>
	<20111021085303.GB3513@opensource.wolfsonmicro.com>
	<12D0C12AF19E15409D57F22566E88EF50A81369249@bgsmsx501.gar.corp.intel.com>
	<20111021091358.GG3513@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 0551D10388C
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Oct 2011 12:58:53 +0200 (CEST)
In-Reply-To: <20111021091358.GG3513@opensource.wolfsonmicro.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

> This clearly isn't something that should be set in the CODEC driver,
> it's a system integration issue - on a different board there might be
> no
> such requirement.

Hmm... Ok. Thanks for clarification.

If it is a board specific requirement, then would it make sense to have it in
dai_link as per Peter Ujfaulsi's RFC [1].

In general, how this kind of situation is handled?

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2011-October/045088.html
