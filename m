From: Dan MacDonald <allcoms@gmail.com>
Subject: Re: CM6206, S/PDIF + JACK
Date: Tue, 13 Nov 2012 13:25:27 +0000
Message-ID: <CANOoOjtGq5OYYkhVHrxivCSrPmvzid1_-vbvuzDtgDqChUHTSQ@mail.gmail.com>
References: <CANOoOjsvRWz6N7eUgJRyFohqih4_d9-sCXhHpWs3M7i4wXjbWQ@mail.gmail.com>
 <50A2434A.8000803@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f179.google.com (mail-vc0-f179.google.com
 [209.85.220.179])
 by alsa0.perex.cz (Postfix) with ESMTP id AC196260309
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2012 14:25:28 +0100 (CET)
Received: by mail-vc0-f179.google.com with SMTP id f13so7147367vcb.38
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2012 05:25:27 -0800 (PST)
In-Reply-To: <50A2434A.8000803@ladisch.de>
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

Hi Clemens!

Thanks for pointing that out! I was expecting to see separate input ports
for the mic, line in and SPDIF under JACK but they must all be rolled into
one if thats what the datasheet says - I've not looked myself yet.

However, I had a quick go at capturing audio from SPDIF and the default
stereo inputs (after making sure SPDIF in was enabled under alsamixer)
 this morning but I got nothing. I have zero experience with SPDIF devices
and Linux (or any other OS) so I dunno what to watch out for - I have only
ever used SPDIF in the past to copy CDs onto Minidiscs (remember them?).

In my quick test I was trying to capture audio from a audio CDR so there
won't have been any copy protection on the disc. CDs are 44.1Khz of course
but I was running JACK at 48Khz - that shouldn't be an issue should it or
would I need to run JACK at 44.1 to capture an audio CD via SPDIF? Maybe rt
resampling isn't supported?

Another thing thats just come to mind is I think that the mic and line
inputs were also set to capture so maybe I'd need to only enable capture
for the SPDIF input but nothing else?

If there is anything else I should know about using SPDIF with
ALSA/Linux/JACK then please let me know!

Thanks!

Dan


On Tue, Nov 13, 2012 at 12:55 PM, Clemens Ladisch <clemens@ladisch.de>wrote:

> Dan MacDonald wrote:
> > I've got a Startech USB device based on the CM6206 chipset. It does work
> > with JACK although I can only access the two mic inputs as JACK capture
> > ports even though under alsamixer I can also see line in and SPDIF In.
> >
> > I get no SPDIF capture port.
>
> Have a look at section 5 of the CM6206 datasheet.
> There is no S/PDIF capture port; all inputs end up at the default
> stereo input port.
>
>
> Regards,
> Clemens
>
