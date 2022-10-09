Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD65C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Oct 2022 06:04:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0CD7436B2;
	Tue, 11 Oct 2022 08:03:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0CD7436B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1665468274;
	bh=v3LK9a3wwjqEswskgeveoeeq6g3vQSULu3KyivR7brA=;
	h=Date:To:From:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KO4cvPej78IV2GPuSIjQ94BN8H9URmmc1QDukzq+RtEgsb/TKiJXLlolMYVVVa4Fo
	 p5qzNQqpiNTos/StpaCHhNgwbEsNo40E/fiC3srUP6uBSbc0blLxAeOPdtTTZzJoSR
	 2FnyJxjZBzkHV9E5RIDrOvJfD5mHy9Y0NWlN9CP0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 07E8DF80551;
	Tue, 11 Oct 2022 08:02:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AE8E4F804CB; Sun,  9 Oct 2022 04:01:57 +0200 (CEST)
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8FE73F80137
 for <alsa-devel@alsa-project.org>; Sun,  9 Oct 2022 04:01:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8FE73F80137
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=connolly.tech header.i=@connolly.tech
 header.b="FhTwH0n7"
Date: Sun, 09 Oct 2022 02:01:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
 s=protonmail; t=1665280901; x=1665540101;
 bh=bOWJkhZwbLAJZMmQNK1Ow6lvYBOieY03TLORKHEfn/g=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID;
 b=FhTwH0n7qn2+H2uKLzIQPteezEzwymqG+rxxbJ4phr0L3Hoy3451eo7+5tWdPmtic
 Y4fgo2XG+BNuwQ9dhmtqkmDVN13/xwdLmJBGh+X1LwBkRE/bAl+ey1ZDplIoJYnoQQ
 7h9WlHaWIHryVugSsw5lBBLfjwTTjYOEyg7jE22k=
To: Dylan Van Assche <me@dylanvanassche.be>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
From: Caleb Connolly <caleb@connolly.tech>
Subject: Re: [PATCH v2] sound: soc: codecs: wcd-mbhc-v2: expose ALSA control
 for jack
Message-ID: <b06ef62e-7409-b347-fc6e-9e42bcd44419@connolly.tech>
In-Reply-To: <20221007155716.10594-1-me@dylanvanassche.be>
References: <20221007155716.10594-1-me@dylanvanassche.be>
Feedback-ID: 10753939:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 11 Oct 2022 08:02:20 +0200
Cc: linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht
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

Tested on a OnePlus 6 running postmarketOS!

On 07/10/2022 16:57, Dylan Van Assche wrote:
> Jack detection is currently fully functional via the input
> interface together with multimedia buttons, but is not exposed
> as an ALSA control. Therefore, ALSA clients such as PulseAudio
> do not pick up the jack detection events as they only support
> one of the possible interface (ALSA control or input interface,
> but not both). Expose the jack events as an ALSA control and input
> interface to provide ALSA clients both interfaces.
>
> Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>

Tested-by: Caleb Connolly <caleb@connolly.tech>

> ---
>   sound/soc/codecs/wcd-mbhc-v2.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/sound/soc/codecs/wcd-mbhc-v2.c b/sound/soc/codecs/wcd-mbhc-v=
2.c
> index 1911750f7445..1b75f49b2858 100644
> --- a/sound/soc/codecs/wcd-mbhc-v2.c
> +++ b/sound/soc/codecs/wcd-mbhc-v2.c
> @@ -725,6 +725,10 @@ static int wcd_mbhc_initialise(struct wcd_mbhc *mbhc=
)
>
>   =09mutex_lock(&mbhc->lock);
>
> +=09ret =3D snd_jack_add_new_kctl(mbhc->jack->jack, "Headset Jack", WCD_M=
BHC_JACK_MASK);
> +=09if (ret)
> +=09=09dev_warn(component->dev, "failed creating Headset Jack kctl with e=
rr: %d\n", ret);
> +
>   =09/* enable HS detection */
>   =09if (mbhc->mbhc_cb->hph_pull_up_control_v2)
>   =09=09mbhc->mbhc_cb->hph_pull_up_control_v2(component,
> --
> 2.37.3
>

--
Kind Regards,
Caleb

