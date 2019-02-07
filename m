From: Manuel Reinhardt <manuel.rhdt@gmail.com>
Subject: Re: [PATCH] ALSA: usb-audio: Fix implicit fb
	endpoint	setup by quirk
Date: Thu, 07 Feb 2019 19:44:02 +0100
Message-ID: <81a005bb649e1ecbf28d6d2ca1a9004160c7af34.camel@gmail.com>
References: <d7a90b82916812e11851582a102de42913265522.camel@gmail.com>
 <s5h5ztwawnd.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by alsa0.perex.cz (Postfix) with ESMTP id DA33A2666B3
 for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2019 19:44:04 +0100 (CET)
Received: by mail-wr1-f65.google.com with SMTP id q18so946752wrx.9
 for <alsa-devel@alsa-project.org>; Thu, 07 Feb 2019 10:44:04 -0800 (PST)
In-Reply-To: <s5h5ztwawnd.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Am Donnerstag, den 07.02.2019, 08:24 +0100 schrieb Takashi Iwai:
> On Thu, 31 Jan 2019 15:32:35 +0100,
> manuel.rhdt@gmail.com wrote:
> > The commit a60945fd08e4 ("ALSA: usb-audio: move implicit fb quirks
> > to
> > separate function") introduced an error in the handling of quirks
> > for
> > implicit feedback endpoints. This commit fixes this.
> > 
> > If a quirk successfully sets up an implicit feedback endpoint, usb-
> > audio
> > no longer tries to find the implicit fb endpoint itself.
> > 
> > Signed-off-by: Manuel Reinhardt <manuel.rhdt@gmail.com>
> 
> I seem to have overlooked this one, and will queue it.
> 
> BTW, did you hit actually a regression by the mentioned commit?
> Or is just a theoretical fix?

I am in the process of writing a quirk to support the MOTU Microbook II
device. The fix I submitted is necessary for the device to work. I
would be surprised if the fix doesn't also fix regressions with other
devices that require the implicit fb quirk.

I will submit the rest of the code needed for Microbook II support
soon. I mailed this patch first to become acquainted with the linux
patch submission model.

Best,

Manuel
