From: Anders Alex <alibobar@gmail.com>
Subject: Re: twl4030 and Puredata/jack
Date: Mon, 11 Mar 2013 19:21:21 +0100
Message-ID: <CAAuz6ar0AvrsE6oif5VfhjKxK1f3=smt9cS-vBE9uXbxbH7ZPQ@mail.gmail.com>
References: <CAAuz6aqqixPxBZQQ5GJinPDfseSVKcnBCvMnLt-6Uad4fP9uPw@mail.gmail.com>
 <513DE004.2060305@ti.com> <513E14EA.7000305@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f48.google.com (mail-qa0-f48.google.com
 [209.85.216.48])
 by alsa0.perex.cz (Postfix) with ESMTP id D4964265368
 for <alsa-devel@alsa-project.org>; Mon, 11 Mar 2013 19:21:22 +0100 (CET)
Received: by mail-qa0-f48.google.com with SMTP id j8so1133532qah.7
 for <alsa-devel@alsa-project.org>; Mon, 11 Mar 2013 11:21:21 -0700 (PDT)
In-Reply-To: <513E14EA.7000305@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 11, 2013 at 6:31 PM, Peter Ujfalusi <peter.ujfalusi@ti.com>wrot=
e:

> On 03/11/2013 02:45 PM, Peter Ujfalusi wrote:
> > On 03/08/2013 04:31 PM, Anders Alex wrote:
> >> With 'jackd -d alsa -S'  (need s16_le):
> >
> > I'm not really a jack user, but can you try:
> > jackd -d alsa -o 2 -i 2 -S -C hw:0,1 -P hw:0,0
> >
> > So you tell jack to play on hw:0,0 record on hw:0,1 use stereo for both.
>
> I have tried jack on my BeagleBoard (using twl4030 codec):
>
> jackd -d alsa -o 2 -i 2 -S -C hw:0,0 -P hw:0,0
> mplayer -ao jack media/music/nin-echoplex.flac
>
> It works fine.
>

With jack1 I was still having problems. Also occasionally the known
alignment-trap issue. I now built jack2 from latest git and it works!
(with your suggested 'jackd -d alsa -o 2 -i 2 -S -C hw:0,1 -P hw:0,0' to
specify the devices)
Also built vanilla Puredata with build-optimizations for pandora (and
enabled jack and disabled direct alsa) and this now works as well!



> --
> P=E9ter
>
