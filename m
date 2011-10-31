From: John Frankish <j-frankish@slb.com>
Subject: Re: No line out on latest Mac Mini
Date: Mon, 31 Oct 2011 13:05:29 +0000
Message-ID: <654DF80AD31A344E93DBCC6280BD6DEF2227EC22@NL0230MBX08N2.DIR.slb.com>
References: <654DF80AD31A344E93DBCC6280BD6DEF2226DCB3@NL0230MBX08N1.DIR.slb.com>
	<4EA2B49C.6090001@melix.org>
	<654DF80AD31A344E93DBCC6280BD6DEF2226DD53@NL0230MBX08N1.DIR.slb.com>
	<4EA2E18D.2040505@melix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nl0105mta01.mail.slb.com (sx003.ddc-nl0105.slb.com
	[199.6.154.22]) by alsa0.perex.cz (Postfix) with ESMTP id 31B8E246E2
	for <alsa-devel@alsa-project.org>; Mon, 31 Oct 2011 14:05:32 +0100 (CET)
In-Reply-To: <4EA2E18D.2040505@melix.org>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "kapouer@melix.org" <kapouer@melix.org>
List-Id: alsa-devel@alsa-project.org

> On 22/10/2011 16:01, John Frankish wrote:
> >> Hi,
> >> i have an imac 12,2 (2011) and i had to change GPIO with hda_analyzer
> >> to get some sound on line out.
> >>
> >> J=E9r=E9my.
> >
> > Thanks - I see something like this with hda_analyser:
> >
> > Global Input Amplifier Caps-> <- Global Output Amplifier Caps
> >
> > GPIO
> >                   out-dir enable unsol sticky wake data [0]
> > [1]            x             x                                         =
       [x]
> > [2]
> > [3]            x             x                                         =
       x
> >
> > ..where [1] data enables/disables line out and [3] data enables/disable=
s the
> internal speaker.
> > [1] data was not checked and doing so got things working - a big thank =
you
> for this.
> >
> > Line out continues to work after closing hda_analyser, but do you know
> > what it actually changes so I Can make it permanent across reboots?
> =

> A patch that applies to recent kernels :
> https://gist.github.com/1306112
> =

> The pincfg won't probably apply for you -- but it show how you can hack
> something.
> =

Thanks - I had a go at making a patch, but couldn't get things to work.

Is there a howto anywhere?

Otherwise, I guess I'll have to wait for a later version of alsa...
