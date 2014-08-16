From: =?ISO-8859-1?Q?Jo=EBl_Kr=E4hemann?= <weedlight@gmail.com>
Subject: Re: A minimal playback program does't work on my system
Date: Sat, 16 Aug 2014 02:36:01 +0200
Message-ID: <1408149361.5228.2.camel@debian>
References: <1408123183.97230.YahooMailNeo@web171303.mail.ir2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f177.google.com (mail-wi0-f177.google.com
 [209.85.212.177])
 by alsa0.perex.cz (Postfix) with ESMTP id BAA23265065
 for <alsa-devel@alsa-project.org>; Sat, 16 Aug 2014 02:36:09 +0200 (CEST)
Received: by mail-wi0-f177.google.com with SMTP id ho1so1445892wib.4
 for <alsa-devel@alsa-project.org>; Fri, 15 Aug 2014 17:36:09 -0700 (PDT)
In-Reply-To: <1408123183.97230.YahooMailNeo@web171303.mail.ir2.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Carpon =?ISO-8859-1?Q?fr=E9d=E9ric?= <frederic.carpon@yahoo.fr>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 2014-08-15 at 18:19 +0100, Carpon fr=E9d=E9ric wrote:
> Hello,
> =

> Yesterday i have written.
> I answer to everybody. I am new and I don't know if there is special rule=
. =

> Note : It would be good to have a forum to see the messages and answers i=
n a pretty form. =

> =

> the programme in c comes from =

> =

> http://equalarea.com/paul/alsa-audio.html
> you can download it at
> https://mon-partage.fr/f/uvyw39wo/
> =

> To answer to Michael i have sound in my HDMI with that : =

> >speaker-test -c2 -D hw:0,0
> =

> so i did that =

> >gcc -o    minimal_playback     minimal_playback.c     -lasound (warning =
comes)
> and
> >./minimal_playback "plughw:0,0"
> and i have this result :
> >Error of segmentation
> =

> Where i can an exemple with the possibility to do something like that  :
> >./minimal_playback  "plughw:0,0"  "mywave.wav"
> =

> =

> Thank you for your help
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

Probably you want to use a library that does type and endianes
conversion like:

http://www.mega-nerd.com/libsndfile/

 =
