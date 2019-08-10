From: Paul Pawlowski <mrarmdev@gmail.com>
Subject: Re: Writing /usr/share/alsa/cards/ files
Date: Sat, 10 Aug 2019 14:10:14 +0200
Message-ID: <CAKSqxP-dJJAFigGgUQRww1va4uAeVQv=hQu2EMaWSmbGE2gLaQ@mail.gmail.com>
References: <CAKSqxP-f+4KCUU79prHaLi2--3H8jAA9iXYxK-EoA8oQKNv=XA@mail.gmail.com>
 <s5htvaumudc.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7A8A6F801A4
 for <alsa-devel@alsa-project.org>; Sat, 10 Aug 2019 14:10:26 +0200 (CEST)
Received: by mail-ed1-x542.google.com with SMTP id k21so98480957edq.3
 for <alsa-devel@alsa-project.org>; Sat, 10 Aug 2019 05:10:26 -0700 (PDT)
In-Reply-To: <s5htvaumudc.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,
I am writing a driver for a device with the following PCM outputs:
- Speaker
- Codec Output (Headphone/Jack)
There's also Loopback, but right now I'm unsure how does it work, I
don't think it's something I should be concerned with right now. There
are also two audio inputs (an internal Microphone as well as Codec
Input).

Thank you,
Paul Pawlowski

On Tue, Aug 6, 2019 at 1:00 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Fri, 02 Aug 2019 14:53:52 +0200,
> Paul Pawlowski wrote:
> >
> > Hello,
> > Is there any documentation on writing /usr/share/alsa/cards/ files?
>
> No documentation, unfortunately.
>
> > I painfully tried to create one in order to enable 2 separate audio outputs,
> > but I ultimately failed to due to the lack of any sort of error reporting.
> > Is there a way to enable any error reporting when parsing these files? It
> > seems that the error output when parsing any hooks goes to nowhere.
> >
> > Also, is this the correct mailing list to get help regarding alsa driver
> > development and configuration?
>
> What kind of "2 separate audio outputs" do you need to create?
>
>
> Takashi
