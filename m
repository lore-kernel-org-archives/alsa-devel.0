From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: ASoC: TLV320AIC3x: Adding additional functionality
 for 3106 with [Patch] for discuss
Date: Thu, 17 Mar 2016 11:26:11 +0200
Message-ID: <56EA7833.7080302@ti.com>
References: <56E69B3F.8090306@mcsplus.ru> <56E6CEE9.5030802@ti.com>
 <56E7FC3C.1030503@mcsplus.ru> <56E802D9.4040501@ti.com>
 <56E834B0.5010808@mcsplus.ru> <56E91FEE.4070604@ti.com>
 <56E934CB.4040209@mcsplus.ru> <56E97A75.7030700@ti.com>
 <56E98F99.2060100@mcsplus.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 3AA2B260831
 for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2016 10:26:15 +0100 (CET)
In-Reply-To: <56E98F99.2060100@mcsplus.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Karaldin <karaldin@mcsplus.ru>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 03/16/16 18:53, Timur Karaldin wrote:
>> your mail client does not seem to wrap the lines correctly, can you chec=
k that.
> I have no idea how these lines should looks, so it's very hard for me to =
see
> what's wrong. Could you point me how it looks in original?

They are looong.

see: https://wiki.openstack.org/wiki/MailingListEtiquette

> Ok, now it's much more clear for me.
> Another question is register behaviour during soft reset. There is
> "aic3x_set_power" handle. In this handle kernel makes SOFT_RESET, markes =
cache
> as dirty, then power down the codec for handle power down request.
> But as I could see main volumes like "HP DAC" and "PCM" stores values bet=
ween
> close and open in mixer and I could not see any code to handle it. On the
> other hand my controls do not save states, as you mentioned because of
> SOFT_RESET, could you explain such different behaviour?

All cached registers are going to be restored after power on with exception=
 of
volatile registers. You need to restore the bits in a volatile registers in
the driver.

-- =

P=E9ter
