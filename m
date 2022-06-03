Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C528C433EF
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jun 2022 19:40:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A410E17EC;
	Fri,  3 Jun 2022 21:39:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A410E17EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654285212;
	bh=BV+s9A/Oh3s+mJA3H+hW+hopPxhygm1cJIl5Qt7aYC8=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N3iddzbhN0HNsJV1A4TAAnH2GliqrzMYI3CSxC2wpmxk3s/u+zrh2wgWOtw0RQ3Co
	 MoWEALjoLlM1P8j0KE0En52D7EymxfFEHQUJgi3dR7DBPSIA63I1hpU/naRWDWgkb+
	 iAJ9ddQmKUUayHZP7vwzeJHZHpaQHvmANPZJ1Ddg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3DAE3F804C1;
	Fri,  3 Jun 2022 21:39:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6F76AF80089; Fri,  3 Jun 2022 21:39:21 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C2924F80089;
 Fri,  3 Jun 2022 21:39:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C2924F80089
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="KroORdY1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1654285155; x=1685821155;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BV+s9A/Oh3s+mJA3H+hW+hopPxhygm1cJIl5Qt7aYC8=;
 b=KroORdY1bHZQC6qrgIKq0Y5CaUtG/fbYN4A3yLczrwUu6OsEuq7brc0v
 KmG0JkRZKGiEsO8ms1huBlm41tcmXkt1cQ7X45JZqvJHTMY30Jtp2zn6X
 E6Vz7YQN2zIChl3KYbCE+ei53oyCB51TQsv4/sCtQvwhqVoemaLEoskZi
 ffBxXaU54nOQYPIzuTZcs74F5xuTqKDEH2lMp9fQtYe54v/p9C1bub8cR
 jNSimIMIJIv1192buOdzdEhC6+yZQdt9QmrVGxZGN43I/mDZQmnVt48gp
 lNowm9HLQT7ZkmGKLDdFE2qjcBPBA+MXuhepx8XgstdFW9CN7KlNW60os w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10367"; a="258414130"
X-IronPort-AV: E=Sophos;i="5.91,275,1647327600"; d="scan'208";a="258414130"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2022 12:38:25 -0700
X-IronPort-AV: E=Sophos;i="5.91,275,1647327600"; d="scan'208";a="563948435"
Received: from aburkhar-mobl.amr.corp.intel.com ([10.254.4.242])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2022 12:38:24 -0700
Message-ID: <d8f063d4f6f68fa8f8954da7f4585b542b66c767.camel@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: Fix potential NULL pointer dereference
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: Amadeusz =?UTF-8?Q?S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>, Mark Brown <broonie@kernel.org>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 03 Jun 2022 12:38:18 -0700
In-Reply-To: <20220602135757.3335351-1-amadeuszx.slawinski@linux.intel.com>
References: <20220602135757.3335351-1-amadeuszx.slawinski@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, sound-open-firmware@alsa-project.org
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

On Thu, 2022-06-02 at 15:57 +0200, Amadeusz Sławiński wrote:
> Cleanup path for sof_prepare_widgets_in_path() should check if
> unprepare
> callback exists before calling it, instead it checks if it does not
> exist. Fix the check.
> 
> Fixes: 370014c8197a ("ASoC: SOF: Add a prepare op to IPC topology
> widget ops")
> Signed-off-by: Amadeusz Sławiński <
> amadeuszx.slawinski@linux.intel.com>
> ---
>  sound/soc/sof/sof-audio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

LGTM. Thanks for the fix.
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> 
> diff --git a/sound/soc/sof/sof-audio.c b/sound/soc/sof/sof-audio.c
> index cd41d0599cef..789d0a1f1a77 100644
> --- a/sound/soc/sof/sof-audio.c
> +++ b/sound/soc/sof/sof-audio.c
> @@ -323,7 +323,7 @@ sof_prepare_widgets_in_path(struct snd_sof_dev
> *sdev, struct snd_soc_dapm_widget
>  			p->walking = false;
>  			if (ret < 0) {
>  				/* unprepare the source widget */
> -				if (!widget_ops[widget-
> >id].ipc_unprepare && swidget->prepared) {
> +				if (widget_ops[widget-
> >id].ipc_unprepare && swidget->prepared) {
>  					widget_ops[widget-
> >id].ipc_unprepare(swidget);
>  					swidget->prepared = false;
>  				}

