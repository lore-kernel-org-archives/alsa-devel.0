From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH v2] sound: usb: mixer: increase control
	transfer timeout
Date: Mon, 29 Aug 2011 16:05:36 +0200
Message-ID: <4E5B9CB0.4090708@ladisch.de>
References: <20110829122320.GX13925@legolas.emea.dhcp.ti.com>	<1314621110-19367-1-git-send-email-balbi@ti.com>
	<CABb+yY15qrszsbJSGGFra7mrVRO_oQPUhNT=U7TNpyoYikABPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 0FA492438A
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Aug 2011 16:05:32 +0200 (CEST)
In-Reply-To: <CABb+yY15qrszsbJSGGFra7mrVRO_oQPUhNT=U7TNpyoYikABPw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Linux USB Mailing List <linux-usb@vger.kernel.org>, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>
List-Id: alsa-devel@alsa-project.org

Jassi Brar wrote:
> On Mon, Aug 29, 2011 at 6:01 PM, Felipe Balbi <balbi@ti.com> wrote:
> > 100ms might not be enough for slower devices. Increasing
> > timeout to 1000ms doesn't seem like overkill.
> >
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >
> > Changes since v1:
> >  . Increase all 100ms timeout to 1000ms
> >
> >  sound/usb/mixer.c        |    4 ++--
> >  sound/usb/mixer_quirks.c |   10 +++++-----
> >  2 files changed, 7 insertions(+), 7 deletions(-)

The calls in mixer_quirks.c are device-specific and known to work, so
none of them actually require a longer timeout. However, increasing
their timeout doesn't hurt either, and ...

> > +                                   buf, val_len, 1000) >= val_len) {
> > +                                   buf, val_len, 1000) >= 0) {
> > +                             !value, 0, NULL, 0, 1000);
> > +                             !value, 0, NULL, 0, 1000);
> > +                             value, index + 2, NULL, 0, 1000);
> > +                                     jacks[i].unitid << 8, buf, 3, 1000);
> > +                             50, 0, &new_status, 1, 1000);
> 
> How about also converting to use a local define for timeout value ?

... now that _all_ calls to snd_usb_ctl_msg use the same timeout value,
we could just as well drop this parameter.


Regards,
Clemens
