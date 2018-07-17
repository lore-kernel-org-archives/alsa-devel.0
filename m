From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH RFC] usb: add usb_fill_iso_urb()
Date: Tue, 17 Jul 2018 08:54:34 +0200
Message-ID: <d05f2d3a-dfa7-d94a-a115-925158b31b5f@ladisch.de>
References: <20180620164945.xb24m7wlbtb6cys5@linutronix.de>
 <Pine.LNX.4.44L0.1806201322260.1758-100000@iolanthe.rowland.org>
 <20180712223527.5nmxndignujo7smt@linutronix.de>
 <20180713072923.GA31191@kroah.com>
 <20180713074728.itw7ua7zygazotuk@linutronix.de>
 <20180716225357.v25f6rurz56q4yes@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dubhe.uberspace.de (dubhe.uberspace.de [185.26.156.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 9CD4226739D
 for <alsa-devel@alsa-project.org>; Tue, 17 Jul 2018 08:54:09 +0200 (CEST)
In-Reply-To: <20180716225357.v25f6rurz56q4yes@linutronix.de>
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
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, tglx@linutronix.de, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Sebastian Andrzej Siewior wrote:
> sound/ is (almost) the only part where struct usb_iso_packet_descriptor
> init does not fit. It looks like it is done just before urb_submit() and
> could be avoided there (moved to the init funtcion instead).

For playback, the packet lengths change dynamically, because the nominal
sample rate (let alone the actual sample rate) often is not an integer
multiple of the 1 kHz/8 kHz USB frame rate.


Regards,
Clemens
