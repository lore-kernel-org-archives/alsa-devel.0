From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Buffer underrun in a not empty playback buffer
Date: Wed, 25 Jul 2012 12:41:34 +0200
Message-ID: <500FCD5E.4070401@ladisch.de>
References: <500F9321.30305@voiceinterconnect.de>
 <500F99B9.1050905@ladisch.de> <500FC6B7.1040309@voiceinterconnect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id DA8812652DF
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2012 12:41:35 +0200 (CEST)
In-Reply-To: <500FC6B7.1040309@voiceinterconnect.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Christian Gruber <christian.gruber@voiceinterconnect.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Christian Gruber wrote:
> Am 25.07.2012 09:01, schrieb Clemens Ladisch:
>> (Or does that driver, which you did not name, do additional checks?)
>
> The mentioned driver is an ALSA-driver, which was originally developed
> by Texas Instruments for their Audio-Codec family TLV320AIC3x, but was
> adapted to a specific customer board.

The TLV320AIC3x are I=B2S codecs.  DMA and buffering are done by the
controller, which is managed by the platform driver.

> But the behaviour of the mentioned driver is, that an underrun occurs,
> even when there are lots of periods (> 6 periods) inside the playback
> buffer. And this is not correct, isn't it?

This is indeed not correct (if there isn't much time between reading
the buffer fill level and the underrun).

It's likely that the platform driver does not report the buffer position
correctly.


Regards,
Clemens
