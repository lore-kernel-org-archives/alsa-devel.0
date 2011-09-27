From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 02/10] ASoC: twl6040: Combine the custom
	volsw get, and put functions
Date: Tue, 27 Sep 2011 15:55:35 +0300
Message-ID: <2316020.Wv26OjW8Zz@barack>
References: <1317043593-27202-1-git-send-email-peter.ujfalusi@ti.com>
	<15316585.mj9RxehzRH@barack>
	<20110927114243.GA4289@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog125.obsmtp.com (na3sys009aog125.obsmtp.com
	[74.125.149.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 49E8224370
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Sep 2011 14:55:45 +0200 (CEST)
Received: by mail-bw0-f43.google.com with SMTP id s6so9195372bka.30
	for <alsa-devel@alsa-project.org>; Tue, 27 Sep 2011 05:55:33 -0700 (PDT)
In-Reply-To: <20110927114243.GA4289@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tuesday 27 September 2011 12:42:44 Mark Brown wrote:
> On Tue, Sep 27, 2011 at 02:21:37PM +0300, P=E9ter Ujfalusi wrote:
> > In case of SOC_SINGLE_TLV I (will) need to call snd_soc_put_volsw
> > In case of SOC_DOUBLE_TLV I need to call  snd_soc_put_volsw
> > In case of SOC_DOUBLE_R_TLV I need to call  snd_soc_put_volsw_2r.
> =

> Or we could just update the macros and unify all the operations which
> might be easier overall?

If we can save few LOC, it might worth doing it.
I can take a look at this, but I think it is going to be 3.3 material.

--
P=E9ter
