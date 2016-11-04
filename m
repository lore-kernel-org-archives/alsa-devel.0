From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [question] Sample rate IC followed by DAC
Date: Fri, 4 Nov 2016 12:31:10 +0100
Message-ID: <51ece116-aabb-21fa-b339-8a8bd95d6b52@ladisch.de>
References: <5e9a9d77-4a01-b41c-32aa-130d76958bef@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 84A98266218
 for <alsa-devel@alsa-project.org>; Fri,  4 Nov 2016 12:31:11 +0100 (CET)
In-Reply-To: <5e9a9d77-4a01-b41c-32aa-130d76958bef@flatmax.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Flax <flatmax@flatmax.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Matt Flax wrote:
> I have a sample rate converter IC, which is followed by a DAC. This kind =
of setup :
>
> SoC chip -> Sample rate conv. chip -> DAC chip

What is the purpose of the converter?  What problem does it solve?

> How do you construct a machine driver for this setup ?

The original DAC driver will not work correctly, as far as sample rate
settings are concerned.

> Unfortunately the silicon only supports an older 3.14 kernel.

You mean, you paid for _no support_?  And now are asking here instead?
(Not that a newer kernel version would help ...)

Well, if your goal isn't a proper driver for upstream, just hack the
existing DAC driver to access the other I=B2C device, when needed.


Regards,
Clemens
