From: Tom Yan <tom.ty89@gmail.com>
Subject: Re: [PATCH - alsa-lib 1/1] add surround21 for Echo3G
	devices
Date: Sun, 17 Jan 2016 03:17:30 +0800
Message-ID: <CAGnHSEk0jCPjhveut_g9=Pja3ZfOV+=qwND-NDCOYyjjkv5_HA@mail.gmail.com>
References: <569a947e.870d620a.17535.2cf0@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f177.google.com (mail-yk0-f177.google.com
 [209.85.160.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E99E2604D3
 for <alsa-devel@alsa-project.org>; Sat, 16 Jan 2016 20:17:31 +0100 (CET)
Received: by mail-yk0-f177.google.com with SMTP id a85so498690516ykb.1
 for <alsa-devel@alsa-project.org>; Sat, 16 Jan 2016 11:17:31 -0800 (PST)
In-Reply-To: <569a947e.870d620a.17535.2cf0@mx.google.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

There is actually ONE card conf, AACI.conf, that supports surround51
but not surround20/surround41/surround50, but I don't feel like
touching it, coz it's in the ideal state of what I proposed here:
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-January/103121.html

On 17 January 2016 at 03:05,  <tom.ty89@gmail.com> wrote:
> From: Tom Yan <tom.ty89@gmail.com>
>
> It's the only card conf that make use of surround41.conf and surround50.conf but not surround21.conf; Adding it for consistency, since all three of them are derived from surround51.
>
> Signed-off-by: Tom Yan <tom.ty89@gmail.com>
>
> diff --git a/src/conf/cards/Echo_Echo3G.conf b/src/conf/cards/Echo_Echo3G.conf
> index 766f13f..93d9ce4 100644
> --- a/src/conf/cards/Echo_Echo3G.conf
> +++ b/src/conf/cards/Echo_Echo3G.conf
> @@ -50,6 +50,40 @@ Echo_Echo3G.pcm.side.0 {
>         subdevice 6
>  }
>
> +<confdir:pcm/surround21.conf>
> +Echo_Echo3G.pcm.surround21.0 {
> +       @args [ CARD ]
> +       @args.CARD {
> +               type string
> +       }
> +       type multi
> +       slaves [
> +               {
> +                       pcm {
> +                               @func concat
> +                               strings [
> +                                       "cards.Echo_Echo3G.pcm.front.0:CARD=" $CARD
> +                               ]
> +                       }
> +                       channels 2
> +               }
> +               {
> +                       pcm {
> +                               @func concat
> +                               strings [
> +                                       "cards.Echo_Echo3G.pcm.center_lfe.0:CARD=" $CARD
> +                               ]
> +                       }
> +                       channels 2
> +               }
> +       ]
> +       bindings [
> +               { slave 0 channel 0 }
> +               { slave 0 channel 1 }
> +               { slave 1 channel 0 }
> +       ]
> +}
> +
>  <confdir:pcm/surround40.conf>
>  Echo_Echo3G.pcm.surround40.0 {
>         @args [ CARD ]
> --
> 2.7.0
>
