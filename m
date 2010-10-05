From: Daniel Mack <daniel@caiaq.de>
Subject: Re: S51 usb support
Date: Wed, 6 Oct 2010 00:04:46 +0200
Message-ID: <20101005220446.GR7159@buzzloop.caiaq.de>
References: <4CA8F3F8.6010705@gmail.com>
	<20101004044152.GC7159@buzzloop.caiaq.de>
	<4CAA3458.9080007@gmail.com>
	<20101005073853.GL7159@buzzloop.caiaq.de>
	<4CAB787E.1050409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id D6E71103939
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Oct 2010 00:04:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4CAB787E.1050409@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Matti Picus <matti.picus@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 05, 2010 at 09:11:58PM +0200, Matti Picus wrote:
> On 10/05/2010 09:38 AM, Daniel Mack wrote:
> >
> >Normally, the volume would be controlled by a feature unit. Just post
> >the whole output of 'lsusb -v' to some pastebin website and post the
> >link.
> >
> http://pastebin.com/e8ZcX9TN

Hmm, there is no feature unit in this dump, so the volume is most
probably set with an vendor-specific USB request. Unless the Windows
driver does something similar than PulseAudio and handles the volume
level control in software (iow, modify each sample before sending it to
the hardware) rather than setting any actual hardware volume level.

> >>Any guidance you can give toward getting the volume controls
> >>recognized would be greatly appreciate.
> >The best way is to sniff the USB communication when Windows sets the
> >volume
> Is there an example in the alsa source tree of some of this?

Of a sniff dump you mean? I doubt so, but once you manage to get one
with any of the software tools around or with a hardware analyzer, the
dump itself shouldn't be hard to understand. You just need to understand
the packet layout and where they store the actual volume information.

Once you got this information, feel free to share it, so we can figure
out a nice way of generating the same kind of messages from inside the
kernel driver.

Daniel
