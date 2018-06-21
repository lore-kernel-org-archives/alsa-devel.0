From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 6/9] ALSA: usb: caiaq: use
	usb_fill_int_urb()
Date: Thu, 21 Jun 2018 23:16:39 +0200
Message-ID: <20180621211639.a7vym5mikaejvlgw@linutronix.de>
References: <20180619215521.13688-1-bigeasy@linutronix.de>
 <20180619215521.13688-7-bigeasy@linutronix.de>
 <2f8cbd9b-55ad-d543-d26a-c4452717b121@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from Galois.linutronix.de (galois.linutronix.de [146.0.238.70])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A216267610
 for <alsa-devel@alsa-project.org>; Thu, 21 Jun 2018 23:16:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <2f8cbd9b-55ad-d543-d26a-c4452717b121@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: alsa-devel@alsa-project.org, linux-usb@vger.kernel.org, tglx@linutronix.de, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On 2018-06-21 22:19:32 [+0200], Daniel Mack wrote:
> On Tuesday, June 19, 2018 11:55 PM, Sebastian Andrzej Siewior wrote:
> > Using usb_fill_int_urb() helps to find code which initializes an
> > URB. A grep for members of the struct (like ->complete) reveal lots
> > of other things, too.
> 
> Acked-by: Daniel Mack <zonque@gmail.com>

nope, please don't.
Takashi, please ignore the usb_fill_.* patches. I will be doing another
spin with usb_fill_iso_urb() instead.

Sebastian
