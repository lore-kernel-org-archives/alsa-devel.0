From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Jack sensing in snd_usb_audio ?
Date: Wed, 12 Oct 2016 14:43:03 +0200
Message-ID: <b0df4e0b-5d46-f14d-133d-65d40623646e@ladisch.de>
References: <1476249011.6699.15.camel@hadess.net>
 <9449bd71-7766-5323-9fe8-30e954ca8f45@sakamocchi.jp>
 <1476269923.6699.20.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id C9C8E26640F
 for <alsa-devel@alsa-project.org>; Wed, 12 Oct 2016 14:43:17 +0200 (CEST)
In-Reply-To: <1476269923.6699.20.camel@hadess.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bastien Nocera <hadess@hadess.net>
Cc: alsa-devel@alsa-project.org, linux-usb@vger.kernel.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

Bastien Nocera wrote:
> Looks like whether or not jack sensing works depends on the device
> itself, but there is a mechanism to propagate the change in setup in
> the USB Audio 2.0 spec

Some recent Windows 10 beta added partial support for USB Audio 2.0.
Earlier Windowses implement only USB Audio 1.0, which does not mention
jacks.

> "
> A change of state in the audio function is most often caused by a
> certain event that takes place. An event can either be user-initiated
> or device-initiated. User-initiated jack insertion or removal is a
> typical example of a user-initiated event.
> "

There are not many USB Audio 2.0 devices, and I'm not aware of any
that actually implements this.


Regards,
Clemens
