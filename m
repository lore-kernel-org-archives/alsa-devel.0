From: Daniel Mack <zonque@gmail.com>
Subject: Re: usb-audio: Reloop Play support (TI TUSB3200AC)
Date: Fri, 19 Oct 2012 20:06:20 +0200
Message-ID: <5081969C.1060203@gmail.com>
References: <1350652166.5549.8.camel@didier-laptop> <5081539E.40705@gmail.com>
 <1350654327.8310.4.camel@didier-laptop> <50815B51.3090402@gmail.com>
 <1350660503.5494.15.camel@didier-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 95708265CBF
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2012 20:06:23 +0200 (CEST)
Received: by mail-bk0-f51.google.com with SMTP id e19so283387bku.38
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2012 11:06:23 -0700 (PDT)
In-Reply-To: <1350660503.5494.15.camel@didier-laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Didier 'Ptitjes' Villevalois <ptitjes@free.fr>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 19.10.2012 17:28, Didier 'Ptitjes' Villevalois wrote:
> Daniel,
> 
> I noticed something strange on the screenshots. AudioMIDISetup says the
> Reloop Play is a 24bit device (and indeed this is what is advertised on
> the Reloop page http://www.reloop.com/reloop-play). However, when I
> inspect the proposed audio formats through Javasound the only format
> proposed are:

[...]

> Is it possible that ALSA does not correctly see that it is a 24-bit
> soundcard ?

Yes, but I doubt that the only reason for them to ship an own driver.

Could you post the output of "lsusb -v" please? For both cases: the
device freshly plugged in under Linux, and after the OSX driver
downloaded its firmware. You can already check whether you spot any
differences between them ...


Daniel
