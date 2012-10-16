From: Pete Leigh <pete.leigh@gmail.com>
Subject: Re: Fwd: Support for Roland VG-99 (working code,
 but could use help)
Date: Tue, 16 Oct 2012 12:38:23 +0100
Message-ID: <CABn3OEHgc5RHDX-C3yJsHj9iVFH6Zn9hg3Z0umUhK6SyPVqVJw@mail.gmail.com>
References: <CABn3OEFatrnhGs1xzpmOfXSxpSLuGwgRtN8v=1B96i6=7_9vTg@mail.gmail.com>
 <CABn3OEHRK7TLp+J_pZjMoFts4bZ=-FquQX0WKCzUcaaMZ8Nrpg@mail.gmail.com>
 <507D0F6D.1000102@gmail.com>
 <CABn3OEF1L7hqVAcjs5E5NveA741HPVd4a9eq0w9sS77PYg+2hQ@mail.gmail.com>
 <507D268E.2070609@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f179.google.com (mail-ie0-f179.google.com
 [209.85.223.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 983AE2650D1
 for <alsa-devel@alsa-project.org>; Tue, 16 Oct 2012 13:38:25 +0200 (CEST)
Received: by mail-ie0-f179.google.com with SMTP id c10so9260656ieb.38
 for <alsa-devel@alsa-project.org>; Tue, 16 Oct 2012 04:38:24 -0700 (PDT)
In-Reply-To: <507D268E.2070609@ladisch.de>
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
Cc: alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Clemens, thanks for looking..

On 16 October 2012 10:19, Clemens Ladisch <clemens@ladisch.de> wrote:
> Please check if QUIRK_AUDIO_STANDARD_INTERFACE works.

It does! :)

> Are you sure there are three MIDI ports per direction, and not two?

No, that sounds wrong, in fact I didn't realise I'd set this. I guess
the two ports would be one for sysex and one for normal messages? Two
seems to fit with what lsusb shows

I've tested with .out_cables and .in_cables both set to 0x0011 (is
that two?) and midi in and out continue to work..

Physically, there are two midi connectors, "IN" and "OUT".

Thanks again for the help..

- Pete.

>
> Regards,
> Clemens
