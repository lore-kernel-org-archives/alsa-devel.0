From: Daniel Mack <daniel@zonque.org>
Subject: Re: Audio usb switch to alternate setting 0
Date: Mon, 20 Jan 2014 11:25:14 +0100
Message-ID: <52DCF98A.4080509@zonque.org>
References: <52DBD817.8050304@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id ECE122610A1
 for <alsa-devel@alsa-project.org>; Mon, 20 Jan 2014 11:25:15 +0100 (CET)
In-Reply-To: <52DBD817.8050304@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Konstantinos Georgantas <k.georgantas@samsung.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On 01/19/2014 02:50 PM, Konstantinos Georgantas wrote:
> I am trying to control from the client side which Alternate Setting to 
> use. Basically I would like to be able to switch from Alternate Setting 
> 0 to 1 and vice versa so that I am not receiving any set interface 
> requests in the meantime. From the audio class 2.0 documentation I 
> understand that I should be able to do something like this by using the 
> active alternate setting control, and here comes my main problem.

I'm not quite following from which side you're looking at the system,
IOW, who should be "receiving" requests. Are you talking about the
device or the host side?

As the spec says (5.2.6.1.1), such a control is read-only, and it "does
not allow an interface to change from one active Alternate Setting to
another without Host intervention". "The main purpose of this Control is
to notify the Host (through an interrupt) that the last
selected Alternate Setting is no longer valid.".

Active alt setting switching is done implictly by (de)activating the PCM
streams that are associated with them.

> When I generate an interrupt to the interrupt endpoint I should expect a 
> GET request which I never see in the host side (hope I am right here).
> 
> Here comes the interrupt:
> interrupt->bInfo          = 0x00;
> interrupt->bAttribute  = 0x01;
> interrupt->wValue       = 0x0100;
> interrupt->wIndex       = 0x0004;
> 
> Could you please tell me if such a functionality is supported and how 
> the interrupt should look like?

This type of interrupt is currently unsupported, but it should be easy
to add. Note, however, that the only interesting use case is to tear the
audio stream down and send active users XRUNs.

Not sure if this is what you want.

As always: patches are welcome :)


Daniel
