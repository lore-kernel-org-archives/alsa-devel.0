From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Fw: Support for M-Audio VENOM?
Date: Fri, 26 Oct 2012 10:10:31 +0200
Message-ID: <508A4577.5090706@ladisch.de>
References: <20121025222846.340c0f7f@n0n4m3.alchemist.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 53DDB2650F0
 for <alsa-devel@alsa-project.org>; Fri, 26 Oct 2012 10:10:39 +0200 (CEST)
In-Reply-To: <20121025222846.340c0f7f@n0n4m3.alchemist.homelinux.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xavier Miller <xavier.miller@cauwe.org>
Cc: alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Xavier Miller wrote:
> I would like to have support for the M-Audio Venom synthesizer. It has
> a USB audio and USB MIDI interface, but the current usb audio driver
> fails to configure it correctly : the system hangs during a long time
> when the USB connection is established: for example, lsusb takes 24
> seconds with the Venom attached,

This sounds like a basic problem with the Venom's firmware; there's
nothing much Linux can do about this.

> and alsamixer/aconnect -io end with

with what?

> 12:1:1: cannot get freq at ep 0x2
> 12:2:1: cannot set freq 44100 to ep 0x84

Another firmware bug; but this device has only one sample rate, so the
driver should not treat this as a fatal error.


Regards,
Clemens
