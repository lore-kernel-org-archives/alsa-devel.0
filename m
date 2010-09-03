From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [RESENT] [PATCH - Fix Fast Track Ultra series:
 44.1/88.1 kHz 1/Fix playback/capture issues and related chrashes at 44100
 Hz and 88200 Hz for M-Audio Fast Track Ultra series.
Date: Fri, 03 Sep 2010 09:26:29 +0200
Message-ID: <4C80A325.1030502@ladisch.de>
References: <20100902120531.2e99a5e8.dhubsith@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 56FAA2450F
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Sep 2010 09:25:56 +0200 (CEST)
In-Reply-To: <20100902120531.2e99a5e8.dhubsith@comcast.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Garnet MacPhee <dhubsith@comcast.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Garnet MacPhee wrote:
> Clemens Ladisch wrote:
> > I've got several reports that devices no longer work since UAC2 support got
> > added.  But I've just noticed this is not related to the interface class
> > but to the interface protocol: the new code added checks for UAC_VERSION_1
> > or _2, but real devices apparently write just random junk into this field.
> > 
> > We need something like the following (untested), unless you have a better
> > idea:
> 
> I retro-fitted Clemens' patch to kernel 2.6.35 and tested it. There is
> a problem in card.c and endpoint.c in that KERN_WARN needs to be
> KERN_WARNING,

That's why I wrote "untested".  :-)

> but otherwise the patch works. I get this in dmesg:
> 
> ALSA sound/usb/endpoint.c:279: 2:1:1: unknown interface protocol 0xff, assuming v1
> ALSA sound/usb/endpoint.c:439: 2:1:1: add audio endpoint 0x1
> ALSA sound/usb/endpoint.c:279: 2:2:1: unknown interface protocol 0xff, assuming v1
> ALSA sound/usb/endpoint.c:439: 2:2:1: add audio endpoint 0x81
> ALSA sound/usb/endpoint.c:279: 2:2:2: unknown interface protocol 0xff, assuming v1
> ALSA sound/usb/endpoint.c:439: 2:2:2: add audio endpoint 0x81
> ALSA sound/usb/clock.c:243: current rate 48000 is different from the runtime rate 96000
> 
> It is still necessary to have the following bit of code in endpoint.c,
> otherwise sample rates of 44100 or 88200 do not work (the original
> problem).

The sample rate problems are handled by Felix' patch, which I applied
yesterday.

All known FTU problem should now be fixed in the alsa-kernel tree.


Regards,
Clemens
