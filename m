From: Torstein Hegge <hegge@resisty.net>
Subject: Re: [PATCH v3] ALSA: usb: Work around CM6631 sample
 rate change bug
Date: Tue, 12 Mar 2013 09:28:29 +0100
Message-ID: <20130312082829.GQ20417@pvv.ntnu.no>
References: <20130305220303.GD20417@pvv.ntnu.no>
 <20130311213908.GP20417@pvv.ntnu.no> <513EDF8B.6000504@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from microbel.pvv.ntnu.no (microbel.pvv.ntnu.no [129.241.210.179])
 by alsa0.perex.cz (Postfix) with ESMTP id BFC64265D36
 for <alsa-devel@alsa-project.org>; Tue, 12 Mar 2013 09:28:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <513EDF8B.6000504@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 12, 2013 at 08:55:55AM +0100, Clemens Ladisch wrote:
> Torstein Hegge wrote:
> > There are still some issues with the Schiit Bifrost as described by
> > Chris Hermansen in "Status of CM6631 USB" on alsa-user [1]. While the
> > workaround fixes the sample rate change issue in some cases, he still
> > sometimes get mangled audio on sample rate change.
> >
> > Any ideas on what could be causing this difference between seemingly
> > similar hardware would be appreciated.
> 
> Different firmware.
> 
> > One difference is that 'lsusb -v' from the Schiit Bifrost [2] lists
> > interface 2-5, 7 and 8. My Corda [3] and the Asus card only lists
> > 0, Audio, Control Device
> > 1, Audio, Streaming
> > 2, Human Interface Device (this is number 6 in the Schiit)
> >
> > The extra interfaces listed by the Schiit is probably not backed by any
> > hardware in the CM6631.
> 
> Does the Schiit have all those Line/Mic/SPDIF/MIDI ports?

It only has a USB input. The SPDIF output of the CM6631 is connected to
a CS8416 SPDIF receiver.


Torstein
