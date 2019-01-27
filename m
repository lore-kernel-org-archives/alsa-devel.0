From: Tomas Nordin <tomasn@posteo.net>
Subject: Re: Record stereo from one input on the soundcard
Date: Sun, 27 Jan 2019 19:35:55 +0100
Message-ID: <87h8dux81g.fsf@fliptop.i-did-not-set--mail-host-address--so-tickle-me>
References: <87muo6uhww.fsf@fliptop.i-did-not-set--mail-host-address--so-tickle-me>
 <87sgxgxy9l.fsf@fliptop.i-did-not-set--mail-host-address--so-tickle-me>
 <e285bd85-2f7b-b7f8-5b1d-83bf50eb42ec@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C845266A89
 for <alsa-devel@alsa-project.org>; Sun, 27 Jan 2019 19:35:57 +0100 (CET)
Received: from submission (posteo.de [89.146.220.130])
 by mout01.posteo.de (Postfix) with ESMTPS id BB418160061
 for <alsa-devel@alsa-project.org>; Sun, 27 Jan 2019 19:35:56 +0100 (CET)
In-Reply-To: <e285bd85-2f7b-b7f8-5b1d-83bf50eb42ec@ivitera.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pavel Hofman <pavel.hofman@ivitera.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pavel Hofman <pavel.hofman@ivitera.com> writes:

> Hi Tomas,
>
> Dne 25. 01. 19 v 21:44 Tomas Nordin napsal(a):
>>>
>>> The following command lets me record audio from the card,
>>>
>>> $ arecord -c 2 -d 60 -f S24_3LE -r 48000 -D hw:1,0 s3.wav
>>>
>>> The resulting wav file has all hearable audio in the left speaker when
>>> listening.
>
> If you really feed stereo signal into your soundcard stereo input jack 
> and the card is not somehow configured to merge the input channels, the 
> above command does record stereo signal.

Ok, thanks. I have been a bit confused about the relation between the -c
option argument and the number of inputs on a card. If I understand
correctly, the -c option does not say anything about what inputs to
record from, it is saying what kind of audiofile to produce?

> Available controls of the card are listed by command
>
> amixer -c 1 contents

Here is the output of that:

$ amixer -c 1 contents
numid=2,iface=PCM,name='Capture Channel Map'
  ; type=INTEGER,access=r----R--,values=2,min=0,max=36,step=0
  : values=0,0
  | container
    | chmap-fixed=FL,FR

numid=1,iface=PCM,name='Playback Channel Map'
  ; type=INTEGER,access=r----R--,values=2,min=0,max=36,step=0
  : values=0,0
  | container
    | chmap-fixed=FL,FR

And I didn't mention that in my original post but, alsamixer has been
informing me that "This soundcard does not have any controls." when I
select the AudioBox via F6.

Is this giving any more hints on what I can do?

Best regards
--
Tomas
