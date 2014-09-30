From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: [FFADO-devel] [RFC] libhinawa: a light-weight I/O
 library for status/transactions to ALSA FireWire devices
Date: Tue, 30 Sep 2014 11:19:19 +0930
Message-ID: <20140930014919.GE5605@marvin.atrad.com.au>
References: <54215BF6.5090600@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F16D2606AB
 for <alsa-devel@alsa-project.org>; Tue, 30 Sep 2014 03:49:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <54215BF6.5090600@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, jwoithe@just42.net, "ffado-devel@lists.sf.net" <ffado-devel@lists.sf.net>
List-Id: alsa-devel@alsa-project.org

Hi Takashi S

On Tue, Sep 23, 2014 at 08:39:34PM +0900, Takashi Sakamoto wrote:
> For some reasons (I describe later), I start to develop a light-weight
> I/O library for status/transactions to ALSA FireWire devices.
> https://github.com/takaswie/libhinawa
> 
> This library gives ways to use ALSA FireWire driver functionality such as
> lock/unlock kernel  streaming, EFW transaction. This is one of my
> solutions to some issues between ALSA/FFADO.

As I understand it, this library will be a thin wrapper around whatever
kernel interface is used to communicate these details out to userspace (I
think byte-type mixer controls are the preferred avenue at present).  In
principle I have no problem with this approach so long as it remains
lightweight.  The situation to avoid is the one we had with libraw1394; when
the new stack came about the preferred way to interact with it switched back
to the native kernel interface since (as I understand the situation) it was
felt that libraw1394 didn't really provide a worthwhile API abstraction.

Out of interest, is there any signficance in the library's name "hinawa"?

> I hope to merge this library into alsa-tools package in future, and this
> is a first RFC for it. It's under development and I require your
> comments about its APIs and structure ...

I will try to find some time to look at the current proposal in the next
week or so.

> Dice notification is an actual example. Dice based devices transfer
> notification to a specific address on host controller. The address space
> is exclusive resources on an system. For Dice notification, ALSA Dice
> driver gives a way to utilize it for applications As well as Fireworks
> situation, some userspace stuffs are needed to use this functionality.

For sure.  One thing to keep in mind is that while this is an issue for DICE
devices it may not apply to others.  The library API should be structured to
keep in mind that not all features will be needed across the board.  We
don't want to burden all subsequent firewire-audio streaming drivers with
baggage which is only required for a small subset.

Regards
  jonathan
