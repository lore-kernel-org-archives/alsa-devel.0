From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Fixed latency between multiple channels
Date: Wed, 23 Aug 2017 15:41:36 +0200
Message-ID: <b6c4c2f2-a01c-fc06-e1bb-73e14b3cf56c@ladisch.de>
References: <be709368c93d9e0c7b13f52b0e75ac83.squirrel@postamt.eit.uni-kl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 192E726779C
 for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2017 15:41:38 +0200 (CEST)
Received: from [10.1.2.4] (unknown [94.101.37.79])
 by webclient5.webclient5.de (Postfix) with ESMTPSA id 290D55580F43
 for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2017 15:41:36 +0200 (CEST)
In-Reply-To: <be709368c93d9e0c7b13f52b0e75ac83.squirrel@postamt.eit.uni-kl.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

cuhl@eit.uni-kl.de wrote:
> I've read, that even with a realtime kernel the input-output latency
> varies with time - especially if USB is inbetween.

Yes, USB cam have a small but unknown delay between playback and capture.

> I expect to require a fixed latency between multiple ( I2S ) channels.

> So every channel's signal shall be exactly determined to its
> relative position with respect to the other channels, e. g. it shall be
> known inside the system which events occured simultanously.
>
> Likewise, the processed or generated signals shall be transferred to the
> outputs in a way, that they occur there with intended and modifiable
> relative latency to each other.

This is essentially a hardware problem.

Can't you just use a single device with many channels?


Regards,
Clemens
