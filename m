From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/1] ASoC: TWL4030: Wait RAMP_DELAY on
	headsetl_event: POST_PMD
Date: Thu, 14 May 2009 09:35:02 +0300
Message-ID: <200905140935.02353.peter.ujfalusi@nokia.com>
References: <1242040465-10835-1-git-send-email-peter.ujfalusi@nokia.com>
	<200905140827.11625.peter.ujfalusi@nokia.com>
	<20090514090808.14c0dfda.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 4BE48244D2
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 08:35:17 +0200 (CEST)
In-Reply-To: <20090514090808.14c0dfda.jhnikula@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "anuj.aggarwal@ti.com" <anuj.aggarwal@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ext Mark Brown <broonie@opensource.wolfsonmicro.com>, "getarunks@gmail.com" <getarunks@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thursday 14 May 2009 09:08:08 ext Jarkko Nikula wrote:
> On Thu, 14 May 2009 08:27:11 +0300

> My two cents: Would it be possible to implement 'fake' PGA or amplifier
> into TWL outputs which only controls the power state of mixer and mux?

That would be also possible. I'll try it out and see if the order is correc=
t =

with 'fake PGA'.
BTW: we have quite a bit of 'fake' DAPM things in the twl4030 codec, that I =

started to wonder is the codec real at all??? ;)

-- =

P=E9ter
