From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: The sense or non-sense of the device listing API
 (was: Status of ALSA "simple" mixer interface])
Date: Sun, 25 Nov 2007 21:38:43 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0711252113580.7688@tm8103.perex-int.cz>
References: <20071120005151.GA25276@tango.0pointer.de>
	<s5hy7crhmzs.wl%tiwai@suse.de>
	<1195658628.10273.1222565901@webmail.messagingengine.com>
	<20071125195615.GA10832@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id B58EA24610
	for <alsa-devel@alsa-project.org>; Sun, 25 Nov 2007 21:38:43 +0100 (CET)
In-Reply-To: <20071125195615.GA10832@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lennart Poettering <mznyfn@0pointer.de>
Cc: ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, 25 Nov 2007, Lennart Poettering wrote:

> On Wed, 21.11.07 16:23, Clemens Ladisch (cladisch@fastmail.net) wrote:
> 
> > Takashi Iwai wrote:
> > > Lennart Poettering wrote:
> > > > aplay -L suggest to use "surround71:" (and *only* that) as plugin for my
> > > > usb webcam that only has a single mono channel.  What's going wrong?
> > > > Any idea where I should be looking?
> > > 
> > > Since it's a USB device, maybe Clemens has a better clue...
> > 
> > USB-Audio.conf defines all the surround devices because there are some
> > devices that actually use them.  I could understand if "aplay -L" shows
> > all the default device names _including_ surround71.
> > 
> > I'm not sure how the device name list gets constructed; AFAICT the card-
> > specific .conf files are not supposed to define hints.
> 
> Hmm, that would would be a serious limitation.

Card specific files can give information to device name hint functions. 
Unfortunately, all USB cards have only one configuration file which is too 
much generic (basically all PCM devices are described there even if they 
do not exist in hardware). I think we need to extend our configuration 
files here.

Also if only surround71 device is available, it appears like a bug in the 
device name hint function. Anyway, users can create own device name hints,
so the result of device name hint function can be forced until a right 
behaviour is not implemented by default.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project
