From: Rajaram R <rajaram.officemail@gmail.com>
Subject: Re: USB Audio/ALSA
Date: Thu, 12 Sep 2013 22:41:17 +0530
Message-ID: <CAOiXhaKH87v67tx8cJS_Cn0npwPVmLSQC-agbmoZycvWwAmwWQ@mail.gmail.com>
References: <CAOiXha+sn0okoKFN9Q-C0PLmP1EqServFfFLSHsJT-NCq1+z=w@mail.gmail.com>
 <5231ECED.1010900@gmail.com>
 <CAAmECqSL5WkHP+omfiAtw14mEBDbY1Jws8W1gkkNuEevSB=bEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ve0-f170.google.com (mail-ve0-f170.google.com
 [209.85.128.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C40F2654CD
 for <alsa-devel@alsa-project.org>; Thu, 12 Sep 2013 19:11:18 +0200 (CEST)
Received: by mail-ve0-f170.google.com with SMTP id c14so74832vea.1
 for <alsa-devel@alsa-project.org>; Thu, 12 Sep 2013 10:11:17 -0700 (PDT)
In-Reply-To: <CAAmECqSL5WkHP+omfiAtw14mEBDbY1Jws8W1gkkNuEevSB=bEw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Radoslaw Szkodzinski <astralstorm@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

The one i use is broadcom chipset i guess (Samsung Grand). Any pointers
based on the above logcat message will be helpful ? I wonder if there is
any Android/Samsung mailing list that can answer this topic.

I am expecting some developers who worked on the above said platform will
be on this list.


On Thu, Sep 12, 2013 at 10:35 PM, Radoslaw Szkodzinski <
astralstorm@gmail.com> wrote:

> On Thu, Sep 12, 2013 at 6:33 PM, Daniel Mack <zonque@gmail.com> wrote:
> > On 12.09.2013 05:30, Rajaram R wrote:
> >> I am trying to bring up Android Accessory Audio in my Samsung Grand
> >> mobile.. I am using a Linux PC for the same. The mobile re-enumerates =
in
> >> AOA mode with an Audio interface. But when I play song, I see nothing =
on
> >> the bus.  I can see an AOA audio device entry in /proc/asound/cards. T=
he
> >> mobile runs Android JB
> >
> > If the card is present in /proc/asound/cards, alsa detected it just
> > fine, and you have to look at the Adroid sound system in order to find
> > out why it's not used. Unfortunately, Android decided not to use any of
> > the ALSA userspace code but reinvented the wheel, for which simple tools
> > like aplay are unavailable.
>
> Actually quite a few devices come with either tinyalsa or full alsa-lib.
>
> Qualcomm-based ones are the exception.
>
> --
> Rados=B3aw Szkodzi=F1ski
>
