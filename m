Return-Path: <SRS0=L/cl=FI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEFCC433FE
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Dec 2020 09:13:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 911902255F
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Dec 2020 09:13:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 911902255F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 80E251877;
	Fri,  4 Dec 2020 10:12:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 80E251877
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607073218;
	bh=JmG8FBaTzbt/kYkShldS7G1ItAyjwRZb31/e3OGqfUM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bt4zqJKr8VCdFkCzfweMMyWfW9lYoXGEVqb2Y+WZn5O0RDF8Qsanb6sX/NWbPCh4R
	 qlwI4DnrVlext/MxHQFikI+9o7jwwosiPvc3YcDVwOgkguILnm9ODXoXO2XGlvz6WN
	 /O0sAeETRKbL6LC/oLBfSM4RkYOQ/VEhi9Gsjd1I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BE58FF804BD;
	Fri,  4 Dec 2020 10:12:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 724B9F804C2; Fri,  4 Dec 2020 10:12:16 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 586A2F804BC
 for <alsa-devel@alsa-project.org>; Fri,  4 Dec 2020 10:12:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 586A2F804BC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="CY2MOA8p"
X-Gm-Message-State: AOAM533wjB3RR4I/WYTLRa9sItInQC1mDC2DvjvHmHP2WCL2tESE8Fy0
 PsmcRmUa0caAUAyjgpL9XZ4FE/qOovwFk0hAcfk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607073127;
 bh=JmG8FBaTzbt/kYkShldS7G1ItAyjwRZb31/e3OGqfUM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=CY2MOA8pzaahG6laGVMt7huzhQHFwtUjxBSMMrv0kH/aeQQ4gl4p/l9Tn1DLIEei+
 GiR+Iw8c+zK289IuEfzp6egRvS/qo6Q3bHxZu2MdqYB3Z8MtS701RI7ROMWFI0GGcU
 hCxqAuOybA8BksUepjYRlg3rVyziuspg1+bnTQf1/0fdgwZC2X4ALoZowsgfDZxi+E
 rcle56e4VmEffS+uSNJHQhqh04jH9WsfMU2QOyqCSl/phHvlNB+kx3N74XqJ+SFhjE
 dc9lkbmBmh0RobWETDm9q9g4nEfjw5ChAEPiCxHVvDppULs/1sMjRgoa4GjhDR7QsS
 XfSaYWil8yp9A==
X-Google-Smtp-Source: ABdhPJxE5YcToNs/naZOB0pqVvNjNVeYst+MYN/gRehfo8nYfGYKjmuMOWvelXELXZ/AfJWI2lV13OfDu5hEncMg/m4=
X-Received: by 2002:aca:4e42:: with SMTP id c63mr2436708oib.67.1607073126708; 
 Fri, 04 Dec 2020 01:12:06 -0800 (PST)
MIME-Version: 1.0
References: <20201204083624.2711356-1-arnd@kernel.org>
 <CA+Px+wVYCp=x1_zPkmgd3LLYH=wp1yYHCHZbuT4ecMgPCuYXMA@mail.gmail.com>
In-Reply-To: <CA+Px+wVYCp=x1_zPkmgd3LLYH=wp1yYHCHZbuT4ecMgPCuYXMA@mail.gmail.com>
From: Arnd Bergmann <arnd@kernel.org>
Date: Fri, 4 Dec 2020 10:11:50 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1t-JhJ73ikf=FZQn1L0AbT3e=e7zJGkOMvCXky6apj+w@mail.gmail.com>
Message-ID: <CAK8P3a1t-JhJ73ikf=FZQn1L0AbT3e=e7zJGkOMvCXky6apj+w@mail.gmail.com>
Subject: Re: [PATCH] [v2] ASoC: cros_ec_codec: fix uninitialized memory read
To: Tzung-Bi Shih <tzungbi@google.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 ALSA development <alsa-devel@alsa-project.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Eric Biggers <ebiggers@google.com>, Takashi Iwai <tiwai@suse.com>,
 Guenter Roeck <groeck@chromium.org>, Mark Brown <broonie@kernel.org>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Yu-Hsuan Hsu <yuhsuan@chromium.org>, Benson Leung <bleung@chromium.org>,
 Ard Biesheuvel <ardb@kernel.org>, Cheng-Yi Chiang <cychiang@chromium.org>
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

On Fri, Dec 4, 2020 at 9:57 AM Tzung-Bi Shih <tzungbi@google.com> wrote:
>
> On Fri, Dec 4, 2020 at 4:36 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
> > index 58894bf47514..6ec673573c70 100644
> > --- a/sound/soc/codecs/cros_ec_codec.c
> > +++ b/sound/soc/codecs/cros_ec_codec.c
> > @@ -348,7 +348,7 @@ static int i2s_rx_event(struct snd_soc_dapm_widget *w,
> >         }
> >
> >         return send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_I2S_RX,
> > -                                   (uint8_t *)&p, sizeof(p), NULL, 0);
> > +                                   &p.cmd, sizeof(p.cmd), NULL, 0);
> >  }
>
> I would prefer your v1.
>
> Reasons:
> 1. The change is not just kernel related.
> There is a EC (embedded controller) firmware to collaborate with the
> code.  The firmware doesn't know the kernel only copies the first byte
> of the packet (at least for now).  See
> https://chromium.googlesource.com/chromiumos/platform/ec/+/refs/heads/master/common/audio_codec_i2s_rx.c#120.
>
> 2. We don't copy partial packets in a EC host command.
> IMHO, it is also not a big deal if copying a few unused bytes in the packet.

Ok, so if the EC does access the uninitialized data, then it is indeed
better to initialize it to zero as I first thought.

      Arnd
