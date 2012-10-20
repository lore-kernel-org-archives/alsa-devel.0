From: Didier 'Ptitjes' Villevalois <ptitjes@free.fr>
Subject: Re: usb-audio: Reloop Play support (TI TUSB3200AC)
Date: Sat, 20 Oct 2012 12:22:48 +0200
Message-ID: <1350728568.5932.6.camel@didier-laptop>
References: <1350652166.5549.8.camel@didier-laptop>
 <5081539E.40705@gmail.com> <1350654327.8310.4.camel@didier-laptop>
 <50815B51.3090402@gmail.com> <1350659344.5494.11.camel@didier-laptop>
 <508195B4.2090809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by alsa0.perex.cz (Postfix) with ESMTP id 34278264F1A
 for <alsa-devel@alsa-project.org>; Sat, 20 Oct 2012 12:22:53 +0200 (CEST)
In-Reply-To: <508195B4.2090809@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On ven., 2012-10-19 at 20:02 +0200, Daniel Mack wrote:
[...]
> Let me know of you make any progress here.
> 
I diff-ed the ioreg output when the play is connected without the driver
(-) and with the driver (+). So I can see that it is using its
proprietary driver.

http://ptitjes.free.fr/reloop-play/play-ioreg-without-and-with-driver.diff

I also traced (with Apple's USB Probe tool) the USB when connecting the
PLAY.

At log level 6:
http://ptitjes.free.fr/reloop-play/usb-log-withdriver-l6.txt

At log level 7: (3.5Mo!!)
http://ptitjes.free.fr/reloop-play/usb-log-withdriver-l7.txt

I have to do the same thing when streaming some sound. But should I
output some easily recognizable sound ? Something like a sine or some
silence ?

Didier.
