From: Andrew Reyes <dsreyes1014@gmail.com>
Subject: Re: Behringer Uphoria UMC204 usb audio capture only
 pops and clicks
Date: Mon, 21 Apr 2014 13:33:23 -0500
Message-ID: <CAEYsuVOmTuJ7dHu8mvOF0currhfgwC9WO3hitbKEAgKRBj9eoQ@mail.gmail.com>
References: <CAEYsuVOBOGMwqhzx8ZROJ8+vbmfD6Ty=fnAtzccMqkFUGKPM4A@mail.gmail.com>
 <53551C5B.5010002@zonque.org>
 <CAEYsuVP1pr87v0y5SuKL87bCRr5RpfgLiSfjsZb4mis1yE_w1g@mail.gmail.com>
 <CAEYsuVML1ZFGGP35KB=3im_JTgNSCoNfPg1aMnzT6mjR=u1cJA@mail.gmail.com>
 <5355431F.3000501@zonque.org>
 <CAEYsuVNvr3WE+RCgCHKZHrBKybAc8muhx3nMu1NgfRgVbj9z1g@mail.gmail.com>
 <53555A0F.4080406@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f46.google.com (mail-qg0-f46.google.com
 [209.85.192.46])
 by alsa0.perex.cz (Postfix) with ESMTP id B8CB2260850
 for <alsa-devel@alsa-project.org>; Mon, 21 Apr 2014 20:33:24 +0200 (CEST)
Received: by mail-qg0-f46.google.com with SMTP id j107so967337qga.33
 for <alsa-devel@alsa-project.org>; Mon, 21 Apr 2014 11:33:23 -0700 (PDT)
In-Reply-To: <53555A0F.4080406@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> aplay -Dhw:xxx --buffer-size 2048 file.wav

> (again, xxx is the index or short name of your audio card).

> Which application do you normally use to play audio?


I'm using JACK right now for recording and gigging live and pulseaudio for
Youtube and movies.
Here is the pastebin link for the aplay command:
http://pastebin.com/3nquKW12



On Mon, Apr 21, 2014 at 12:49 PM, Daniel Mack <daniel@zonque.org> wrote:

> (Please, do not top-post but quote properly!)
>
> On 04/21/2014 06:51 PM, Andrew Reyes wrote:
> > The while shell command shows consistent 96k when set at 96khz and dmesg
> > shows nothing where it pops and clicks.  How do I use aplay to adjust
> > buffer-size?
>
> aplay -Dhw:xxx --buffer-size 2048 file.wav
>
> (again, xxx is the index or short name of your audio card).
>
> Which application do you normally use to play audio?
>
>
> Daniel
>
>
