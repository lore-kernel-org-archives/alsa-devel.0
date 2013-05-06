From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: "Negative" volume settings in a kcontrol
Date: Mon, 06 May 2013 15:22:45 +0200
Message-ID: <5187AEA5.1020108@ladisch.de>
References: <51824609.30405@canonical.com> <1367498241.8766.3.camel@localhost>
 <5182746C.1070603@topic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id A5E44261AE5
 for <alsa-devel@alsa-project.org>; Mon,  6 May 2013 15:22:44 +0200 (CEST)
In-Reply-To: <5182746C.1070603@topic.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mike Looijmans wrote:
> Some codec registers need negative values. For example,
> sound/soc/codecs/tlv320aic32x4.c specifies this:
>
>  78         SOC_DOUBLE_R_TLV("PCM Playback Volume", AIC32X4_LDACVOL,
>  79                         AIC32X4_RDACVOL, 0, 0x30, 0, tlv_step_0_5),
>
> It's incomplete. The actual range is from -63.5dB to +24dB in 0.5 dB steps.
> The 8-bit value is interpreted as a signed 8-bit integer, so to get -3dB
> the register value must be -6 or 0xFA.
>
> How do I explain that to Alsa?

There are some ASoC helper macros that handle signed register fields, such
as SOC_DOUBLE_S8_TLV and SOC_SINGLE_XR_SX.  If those don't do what you want,
you have to write your own.

> (and on a side note "amixer" doesn't accept negative values either)

A workaround would be to set the control value first to 0 and then to
the desired negative value ... but this bug needs fixing.


Regards,
Clemens
