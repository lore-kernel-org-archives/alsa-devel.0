From: Tom Yan <tom.ty89@gmail.com>
Subject: Re: [PATCH - alsa-lib 1/1] add surround21 for Echo3G
	devices
Date: Mon, 18 Jan 2016 14:17:37 +0800
Message-ID: <CAGnHSEkvXSsJB+hGBR0TKGE0_Xzi5DGknMLQLoVrqEc7WZJfeQ@mail.gmail.com>
References: <569a947e.870d620a.17535.2cf0@mx.google.com>
 <CAGnHSEk0jCPjhveut_g9=Pja3ZfOV+=qwND-NDCOYyjjkv5_HA@mail.gmail.com>
 <CAN8ccibo3rEqvAEEqH6yqHwVAipJAFH576-VF-QpaRv=d8274g@mail.gmail.com>
 <CAGnHSEmG_9DLW6EQS2229Kq9hDF-u0J01gJXP6ozdr67Zrsb_g@mail.gmail.com>
 <CAN8ccibfwq+tuXc6RO2aVJb7qBymtFMGA=bs7Brf8iqnT6G_+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f176.google.com (mail-yk0-f176.google.com
 [209.85.160.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 32DAB260481
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2016 07:17:38 +0100 (CET)
Received: by mail-yk0-f176.google.com with SMTP id v14so509405503ykd.3
 for <alsa-devel@alsa-project.org>; Sun, 17 Jan 2016 22:17:38 -0800 (PST)
In-Reply-To: <CAN8ccibfwq+tuXc6RO2aVJb7qBymtFMGA=bs7Brf8iqnT6G_+g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Then what about this:
http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=src/conf/cards/SB-XFi.conf;h=eb2218bfdcc704e4bf39e0e0c21539ee7f9ff8f8;hb=HEAD
It seems to be allow the "multi-streaming" you mentioned but it
doesn't need the multi plugin.

Hmm, I feel like definitions for "ttable PCMs" in Echo_Echo3G.conf
should be cleaned up...

On 18 January 2016 at 09:50, Raymond Yau <superquad.vortex2@gmail.com> wrote:
>
>>
>> On 18 January 2016 at 00:12, Raymond Yau <superquad.vortex2@gmail.com>
>> wrote:
>> > 7>
>> >
>> >
>> >> There is actually ONE card conf, AACI.conf, that supports surround51
>> >> but not surround20/surround41/surround50, but I don't feel like
>> >> touching it, coz it's in the ideal state of what I proposed here:
>> >>
>> >>
>> >> http://mailman.alsa-project.org/pipermail/alsa-devel/2016-January/103121.html
>> >>
>> >> On 17 January 2016 at 03:05,  <tom.ty89@gmail.com> wrote:
>> >> > From: Tom Yan <tom.ty89@gmail.com>
>> >> >
>> >> > It's the only card conf that make use of surround41.conf and
>> >> > surround50.conf but not surround21.conf; Adding it for consistency,
>> >> > since
>> >> > all three of them are derived from surround51.
>> >> >
>> >> > Signed-off-by: Tom Yan <tom.ty89@gmail.com>
>> >> >
>> >> > diff --git a/src/conf/cards/Echo_Echo3G.conf
>> >> > b/src/conf/cards/Echo_Echo3G.conf
>> >> > index 766f13f..93d9ce4 100644
>> >> > --- a/src/conf/cards/Echo_Echo3G.conf
>> >> > +++ b/src/conf/cards/Echo_Echo3G.conf
>> >> > @@ -50,6 +50,40 @@ Echo_Echo3G.pcm.side.0 {
>> >> >         subdevice 6
>> >> >  }
>> >> >
>> >> > +<confdir:pcm/surround21.conf>
>> >> > +Echo_Echo3G.pcm.surround21.0 {
>> >> > +       @args [ CARD ]
>> >> > +       @args.CARD {
>> >> > +               type string
>> >> > +       }
>> >> > +       type multi
>> >> > +       slaves [
>> >> > +               {
>> >> > +                       pcm {
>> >> > +                               @func concat
>> >> > +                               strings [
>> >> > +
>> >> > "cards.Echo_Echo3G.pcm.front.0:CARD=" $CARD
>> >> > +                               ]
>> >> > +                       }
>> >> > +                       channels 2
>> >> > +               }
>> >> > +               {
>> >> > +                       pcm {
>> >> > +                               @func concat
>> >> > +                               strings [
>> >> > +
>> >> > "cards.Echo_Echo3G.pcm.center_lfe.0:CARD=" $CARD
>> >> > +                               ]
>> >> > +                       }
>> >> > +                       channels 2
>> >> > +               }
>> >> > +       ]
>> >> > +       bindings [
>> >> > +               { slave 0 channel 0 }
>> >> > +               { slave 0 channel 1 }
>> >> > +               { slave 1 channel 0 }
>> >> > +       ]
>> >> > +}
>> >> > +
>> >
>> > Have you tested with real hardware for surround21 since pulseaudio fail
>> > with
>> > multi plugin with error -77  ?
>> >
>> >
>> > http://lists.freedesktop.org/archives/pulseaudio-discuss/2014-November/022670.html
>
>> Nope, not tested with one that uses a card conf that make use of the
>> multi plugin.
>>
>> I just happen to have found this particular conf have surround21
>> missing, so I add it back for consistency:
>>
>> http://mailman.alsa-project.org/pipermail/alsa-devel/2016-January/103123.html
>>
>> But I do wonder why some card conf needs the multi plugin while others
>> doesn't. I wonder if it had been abused. Feels like it is something
>> that should be implemented in the actual driver code instead.
>
> Those cards allow user to play two audio streams to front and rear devices,
> they need multi plugin for multi channel playback
>
> http://git.alsa-project.org/?p=alsa-plugins.git;a=commit;h=a0693150dfd428fdd4df474efdc6b5e26a41ba21
>
> It seem that playback of some plugins can be started at first write when
> start threshold is -1
>
> Pulseaudio call snd_pcm_start when pcm state is already running
