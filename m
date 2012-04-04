From: Grant Diffey <gdiffey@gmail.com>
Subject: Re: trying to get an eleven rack to work
Date: Wed, 4 Apr 2012 14:33:10 +1000
Message-ID: <CACckToWXKYxmwd9aAqwU7kSr9caBRQVfv0Qcy=LtYuuMz5+zEA@mail.gmail.com>
References: <CAOyn=DH_BCQh-DksiLGQnQw1kq0eNNH+Zi7KdRdX5=uot9x2Eg@mail.gmail.com>
	<4F6883F9.4010405@ladisch.de>
	<CACckToUeX7oJmQ9NeRLGecxOxWaLpxbZDnNWA0+t5+XxFvf+FQ@mail.gmail.com>
	<4F718114.5020602@ladisch.de>
	<CAOyn=DFig0m1zFRWyTE6Neimrcy12PPAoNL8BdFVaAUrYEYbGw@mail.gmail.com>
	<4F740A6A.3030608@ladisch.de>
	<CAOyn=DGYAr5kCPTRcf=QN8ypMZy3SWpN--zvKBevWcr4Tnqr_w@mail.gmail.com>
	<CAOyn=DGXcm+0RfuNj5G+BvgrwofpO6TROsKRLiekNxW8FUupFg@mail.gmail.com>
	<CACckToX-kqDyM6sFW_9in64cgO5RQekA-J=EEHSXxgsxEuMk=Q@mail.gmail.com>
	<CAOyn=DGw0U572nKkEsGQ-KoZ_CfBsYbu5vBzxmZ+1Kjwu0d6_w@mail.gmail.com>
	<CAOyn=DF7+dfizJsxJUkwsbZsV-sO9LwbhJbp7s7o2v24Rc2Yqg@mail.gmail.com>
	<4F7B4D86.8080508@ladisch.de>
	<CAOyn=DEajHGkSwCZPGTWU3UUyAQLij6_UzBOJxvWujJQk6OLqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
	[209.85.212.169])
	by alsa0.perex.cz (Postfix) with ESMTP id 0C6AE104350
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Apr 2012 06:33:12 +0200 (CEST)
Received: by wibhm17 with SMTP id hm17so147490wib.2
	for <alsa-devel@alsa-project.org>; Tue, 03 Apr 2012 21:33:10 -0700 (PDT)
In-Reply-To: <CAOyn=DEajHGkSwCZPGTWU3UUyAQLij6_UzBOJxvWujJQk6OLqg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Alexander <lidxv0n@gmail.com>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

David,

Can you please paste the current quirk definition you're using from
quirk-table.h ?

from what I understand it should work. like get sound in/out playback
syncronisation is likely to be bad due to snd-usb-audio not supporting
implicit feedback.

Grant.


On Wed, Apr 4, 2012 at 5:37 AM, David Alexander <lidxv0n@gmail.com> wrote:

> Clemens,
>
> Thank you for the clarification.   Since we've tried the entries in
> the quirks-table.h and the change to mixer.c, and
> its still not working...have we went as far as we can until the other
> parts of the specification are implemented?
>
> Is there anything else device related that I can do, or is it a case
> of waiting until the backend infrastructure is in place?
>
> thank you,
> David
>
> On Tue, Apr 3, 2012 at 3:20 PM, Clemens Ladisch <clemens@ladisch.de>
> wrote:
> > David Alexander wrote:
> >> I have come across some code written for another device by the same
> >> company for another product (Digidesign MBox 2).
> >
> > The Mbox 2 uses a vendor-specific protocol; your device does not.
> >
> > The Eleven Rack would work with the USB Audio 2.0 support of the Linux
> > driver, except that some parts of the USB Audio 2.0 specification are
> > not implemented.
> >
> >
> > Regards,
> > Clemens
>
