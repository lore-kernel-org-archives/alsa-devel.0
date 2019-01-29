From: Prashant Malani <pmalani@chromium.org>
Subject: Re: [PATCH 1/1] seq: arecordmidi: Add num-events option
Date: Mon, 28 Jan 2019 21:34:59 -0800
Message-ID: <CACeCKacREMJDGWNJrdydu3+P1EZ81AyaY0sPfBhuiT11nnvV5A@mail.gmail.com>
References: <5c4fb010.1c69fb81.94ca0.01ae@mx.google.com>
 <f0c4b673-52a2-fc1d-c9d8-4e4b42f999f1@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com
 [209.85.160.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 523572674AD
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2019 06:35:11 +0100 (CET)
Received: by mail-qt1-f194.google.com with SMTP id u47so21012285qtj.6
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2019 21:35:11 -0800 (PST)
In-Reply-To: <f0c4b673-52a2-fc1d-c9d8-4e4b42f999f1@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, patch@alsa-project.org, Daniel Erat <derat@chromium.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

On Mon, Jan 28, 2019 at 7:36 PM Takashi Sakamoto <o-takashi@sakamocchi.jp>
wrote:

> Hi,
>
> On 2019/01/29 10:44, pmalani@chromium.org wrote:
> > @@ -775,6 +780,11 @@ int main(int argc, char *argv[])
> > +             case 'n':
> > +                     num_events = atoi(optarg);
> > +                     if (num_events <= 0)
> > +                             fatal("num_events must be greater than 0");
> > +                     break;
>
> We cannot distinguish two cases; 0 is given and including non-numeraical
> characters. Please use strtol() or so and check return value and errno
> for safe.
>
> For your information:
>
> http://git.alsa-project.org/?p=alsa-utils.git;a=blob;f=axfer/main.c;hb=HEAD#l44

Can I duplicate this in arecordmidi.c ? I'm loath to introduce a header,
and then refactor axfer/main.c.

>
>
>
> Regards
>
> Takashi Sakamoto
>
