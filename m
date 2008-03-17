From: "Alexander Indenbaum" <alexander.indenbaum@gmail.com>
Subject: Re: /usr/share/alsa/alsa.conf :and file extention
Date: Mon, 17 Mar 2008 05:35:57 +0200
Message-ID: <cab05a880803162035o1c4d077erf289dcae4371969f@mail.gmail.com>
References: <cab05a880803161957j7a82e04cma094afda62d5cdab@mail.gmail.com>
	<47DDE2F7.7000904@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.169])
	by alsa0.perex.cz (Postfix) with ESMTP id 6316F24179
	for <alsa-devel@alsa-project.org>; Mon, 17 Mar 2008 04:35:59 +0100 (CET)
Received: by wf-out-1314.google.com with SMTP id 25so7065112wfa.23
	for <alsa-devel@alsa-project.org>; Sun, 16 Mar 2008 20:35:57 -0700 (PDT)
In-Reply-To: <47DDE2F7.7000904@keyaccess.nl>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: alsa-user <alsa-user@lists.sourceforge.net>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 17, 2008 at 5:18 AM, Rene Herman <rene.herman@keyaccess.nl>
wrote:

> On 17-03-08 03:57, Alexander Indenbaum wrote:
>
> > I'm playing with embedded system without any hardware sound device. I'd
> like
> > to grab sound from ALSA application, for instance Firefox displaying
> YouTube
> > clip inside flash plugin and to store  output PCM stream into file on
> local
> > disk. I got an advice to use File extension. So I defined following
> > /usr/share/alsa/alsa.conf
>
> Don't do it there. Use /etc/asound.conf or $HOME/.asoundrc ...
>

Generally I'd agree with you that $HOME/.asoundrc is way to go if it was my
desktop workstation. But this is an embedded system, so I'd like to force it
on system level.


> > pcm.default{
> >         type
> > file
> >         file
> > /tmp/pcm.out
> > }
>
> ... and make it
>
> pcm.!default {
>         type    file
>         slave   {
>                 pcm     null
>         }
>         file    "/tmp/pcm.out"
> }
>

Still it does not  work ( I still use system alsa.conf though ). Now I get:
"Unknown PCM null"
"Unknown PCM plughw:0,0"


> Exactly why you need that slave definition I'm not sure either, but it
> seems
> you do. Also note that /tmp/pcm.out will be headerless PCM and is
> recreated
> for individual opens. I don't believe there's an append mode or anything
> (and you'd need to make sure that everyone plays the same format) so not
> toot sure if this is what you need to have a catch all audio-sink...


You touching here an interesting point. How  indeed I could get an PCM
header?


>
>
> Rene.
>

Thank you for your help, Rene.

-- 
Alexander Indenbaum
