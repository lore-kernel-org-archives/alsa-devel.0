From: Erik <assie2@zonnet.nl>
Subject: Re: problems with snd_au8830 module under mandriva 2005
Date: Wed, 14 Sep 2005 05:32:27 +0200
Message-ID: <1126668747.6835.11.camel@pc-erik.lan>
References: <4317CC51.3040709@netvigator.com>
	 <200509042134.23916.alien999999999@users.sourceforge.net>
	 <1126131309.17399.8.camel@pc-erik.lan>
	 <44272.62.59.249.250.1126163238.squirrel@62.59.249.250>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <44272.62.59.249.250.1126163238.squirrel@62.59.249.250>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alien <alien999999999@users.sourceforge.net>
Cc: Raymond <rayau@netvigator.com>, Igor Kovalenko <garrison@mail.ru>, openvortex-dev@nongnu.org, alsa-devel@lists.sourceforge.net, Manuel Jander <manuel.jander@gmail.com>
List-Id: alsa-devel@alsa-project.org

yup i have the first problem   
 1. the ones where if you get 49% it's loud and on 51% quite silently? 

but then from 51 to 100% is again soft to loud .

next week i can find time to recompile the whole kernel

erik


On Thu, 2005-09-08 at 09:07 +0200, Alien wrote:
> > i'm busy with home improving but when i have time i will try the patch
> > again on 2.6.12 kernel. I have not checked if it is the same alsa
> > version as 2.6.11 but i think it is.
> >
> > b.t.w. the volume bar problem is in XMMS (didn't try other programs
> > because i haven't a lot of time) (just online for mail checking etc.
> > that's it)
> > but i think alien can tell you about the volume bar problems.
> 
> which volume bar problems are you talking about?
> 1. the ones where if you get 49% it's loud and on 51% quite silently?
> 2. or irregular sound volume when you are about halfway (without changing
> volume yourself).
> 
> actually after experimenting I think it might be something hardware
> related (ie with the volume control of my speaker system, not the
> au8810)...
> 
> > pc information:
> >
> > mandriva 2005 le
> > kernel 2.6.11
> > amd 64 bit 3500+
> > diamond monster sound mx300 au8830 card
> >
> >
> > Erik
> >
> >
> >
> > On Sun, 2005-09-04 at 21:34 +0200, Alien wrote:
> >> Op vrijdag 2 september 2005 05:51, schreef Raymond:
> >> > I am not sure Alien's au8810 patch is as same as Igor Kovalenko 's
> >> > au8820 patch. They seem to have their own patches.
> >> >
> >> > The EQ part in diff11.diff seem to be not tested since EQ is not
> >> present
> >> > in au8820.
> >> >
> >> > You should cc your reply to openvortex-dev@nongnu.org and
> >> > alsa-devel@lists.sourceforge.net so that the others can keep track of
> >> > your problem.
> >> >
> >> > There are 3 bug reports for AMD64 in ALSA BTS.
> >> > 1047 - au8810
> >> > 1138 - au8820
> >> > 1025 - au8830
> >> >
> >> > Need feedback from testers with au8810/au8820/au8830 and 32bits/64bits
> >> > machines to debug this patch.
> >> >
> >> > 1) EQ, SPDIF of au8810/au8830 are not present in au8820,
> >> > 2) WT of au8820/au8830 are not present in au8810,
> >> > 3) SoftModem of au8810 are not present in au8820.
> >> > 4) 3D of au8830 is not present in au8810/au8820.
> >> >
> >> > Please correct me if I am wrong, I think au8810 do not have any 3D
> >> > effect hardware.
> >>
> >> i'm not entirely sure, but i think it has some 3D stuff, since i've
> >> always had
> >> controls to manage 3D depth, etc...
> >>
> >> unless you are speaking of something else...
> >
> >
> >
> 
> 



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
