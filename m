From: Adam Goode <adam@spicenitz.org>
Subject: Re: OPL3 on cmipci doesn't survive suspend/resume
Date: Wed, 27 May 2015 09:35:39 -0400
Message-ID: <CADN=Wdo5-Nkc-dLGwawq59w82RMv_VwUQw04i1YYwuD57h_ByQ@mail.gmail.com>
References: <CADN=WdrzMgQCSYA_vp0VVWm0guVWdRXyhVO7CFXXJpvQCgPfqw@mail.gmail.com>
 <alpine.DEB.2.02.1505271529450.22011@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f51.google.com (mail-oi0-f51.google.com
 [209.85.218.51])
 by alsa0.perex.cz (Postfix) with ESMTP id C1367265A70
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2015 15:36:00 +0200 (CEST)
Received: by oifu123 with SMTP id u123so7369987oif.1
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2015 06:35:59 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1505271529450.22011@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, May 27, 2015 at 9:31 AM, Ricard Wanderlof
<ricard.wanderlof@axis.com> wrote:
>
> On Wed, 27 May 2015, Adam Goode wrote:
>
>> 05:00.0 Multimedia audio controller: C-Media Electronics Inc
>> CMI8738/CMI8768 PCI Audio (rev 10)
>> ...
>>
>> When I suspend/resume, the sound from the OPL3 is permanently
>> distorted. It sounds like not all of the operators are active. I can
>> fix this by doing a full PCI remove/rescan cycle: the driver correctly
>> initializes the card at this time.
>>
>> Any ideas before I peek into the code?
>
> Not really, except that it is a very old card by now. No real work has
>  been done in the driver for many years.
>
> (I still have one around in an ancient Linux box, for its S/PDIF
> capability (for which it was very good value for money in its day).)
>


Thanks! I'm surprised it works at all.

I have this card, which is still in production (and with a gameport +
MIDI UART even!):
http://www.amazon.com/gp/product/B001KUSYSO


Adam
