Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAEBAC47422
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Jan 2024 21:56:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6A0793E8;
	Wed, 24 Jan 2024 22:55:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6A0793E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1706133363;
	bh=309aYL4WHgnoj7cp3YCClCX/HORT29FwxxqIu388QIM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=H6NlfkHHuwgDhoftH0b30Oxar3pvg/1GwXc7fTIe4xoDrve96aQ9tWRkP9nRYXX77
	 uZ+TnCpKAOILcMSfCDYmHMqxyJgiXmX9RimjT7UwsX8Q+hl6UipVmRSp+Qx73JZ61c
	 5khTO0217lrBGW2Kc2Gr3VwsPXincCxU0TwBWFC4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 16899F8057C; Wed, 24 Jan 2024 22:55:25 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 65E68F8003A;
	Wed, 24 Jan 2024 22:55:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 41915F8028D; Wed, 24 Jan 2024 22:55:20 +0100 (CET)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with UTF8SMTPS id 8D75CF8022B
	for <alsa-devel@alsa-project.org>; Wed, 24 Jan 2024 22:55:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8D75CF8022B
Received: from [192.168.2.4] (51b68f75.dsl.pool.telekom.hu
 [::ffff:81.182.143.117])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000070DBE.0000000065B1873B.0018A6D1;
 Wed, 24 Jan 2024 22:55:07 +0100
Message-ID: <4dbee9d8524da296b185ba0fe6827249c93eebd6.camel@irl.hu>
Subject: Re: [PATCH 0/2] ALSA: hda: Move component binding support into
 separate library
From: Gergo Koteles <soyer@irl.hu>
To: Richard Fitzgerald <rf@opensource.cirrus.com>, tiwai@suse.com,
  shenghao-ding@ti.com
Cc: perex@perex.cz, linux-kernel@vger.kernel.org,
  linux-sound@vger.kernel.org, alsa-devel@alsa-project.org,
  patches@opensource.cirrus.com
Date: Wed, 24 Jan 2024 22:55:07 +0100
In-Reply-To: <20240124112607.77614-1-rf@opensource.cirrus.com>
References: <20240124112607.77614-1-rf@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
MIME-Version: 1.0
Message-ID-Hash: 2GVWVY4VIJ7AOJXN3DLRPZLXYIJ7QXQD
X-Message-ID-Hash: 2GVWVY4VIJ7AOJXN3DLRPZLXYIJ7QXQD
X-MailFrom: soyer@irl.hu
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2GVWVY4VIJ7AOJXN3DLRPZLXYIJ7QXQD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi Richard,

On Wed, 2024-01-24 at 11:26 +0000, Richard Fitzgerald wrote:
> The Cirrus Logic amplifiers are currently paired with Realtek HDA codecs.
> But they could be used with other codecs. To prepare for this, these two
> patches move the manager side of the component binding out of the Realtek
> driver into a library module.
>=20
> The first patch tweaks the CS35L41 code so that it is not hardcoded to
> CS35L41, and changes the TAS2781 handling so that it re-uses that code
> instead of having a near-identical copy of it.
>=20
> Can someone please test that these two patches don't break TAS2781?
> I have checked that they should work in theory but I don't have hardware
> to test on.
>=20

It works on a Lenovo Yoga 7 14ARB7 laptop.

Tested-by: Gergo Koteles <soyer@irl.hu>

Regards,
Gergo

> Richard Fitzgerald (2):
>   ALSA: hda: realtek: Re-work CS35L41 fixups to re-use for other amps
>   ALSA: hda: realtek: Move hda_component implementation to module
>=20
>  MAINTAINERS                   |   1 +
>  sound/pci/hda/Kconfig         |   4 +
>  sound/pci/hda/Makefile        |   2 +
>  sound/pci/hda/hda_component.c | 169 ++++++++++++++++++++++++++
>  sound/pci/hda/hda_component.h |  59 +++++++++
>  sound/pci/hda/patch_realtek.c | 217 ++++------------------------------
>  6 files changed, 261 insertions(+), 191 deletions(-)
>  create mode 100644 sound/pci/hda/hda_component.c
>=20

