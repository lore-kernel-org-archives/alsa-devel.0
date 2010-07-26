From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Which project to choose?
Date: Mon, 26 Jul 2010 13:53:31 +0800
Message-ID: <AANLkTimv83-3PHMCUQ=LSyY51vtPCgtLhgyyyFpDW7sP@mail.gmail.com>
References: <1279062131.24837.22.camel@localhost.localdomain>
	<AANLkTikEf4gf-oeQf4hNGUEvNi0YVrvutnSMCbxGwtJ8@mail.gmail.com>
	<1279065709.24837.29.camel@localhost.localdomain>
	<AANLkTimdM5__SzYFxrQqwsbOrxdit2uWOvkazPvZ4PND@mail.gmail.com>
	<1279071115.29042.0.camel@localhost.localdomain>
	<AANLkTimNSRELBq7i1Ypi9K2tmFu9NKLvQAOOqPwuU13x@mail.gmail.com>
	<1279074303.29042.3.camel@localhost.localdomain>
	<AANLkTimNYxIm9M6Mglrzh3YtJRiq1C8wdZwx-JUhLk9d@mail.gmail.com>
	<1279145758.29042.11.camel@localhost.localdomain>
	<AANLkTinN15BWNC2cn78rc5xCSXNo79SDE2_WkBNEg5I2@mail.gmail.com>
	<1279157921.2668.1.camel@localhost.localdomain>
	<i1n0mf$87c$1@dough.gmane.org>
	<AANLkTinXvthWBZ4oQg9D18cfAtkXveWHkB08vsXknGgB@mail.gmail.com>
	<i2hgrq$ub3$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 6F91824642
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Jul 2010 07:53:33 +0200 (CEST)
Received: by vws20 with SMTP id 20so2415528vws.38
	for <alsa-devel@alsa-project.org>; Sun, 25 Jul 2010 22:53:32 -0700 (PDT)
In-Reply-To: <i2hgrq$ub3$1@dough.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/7/25 Colin Guthrie <gmane@colin.guthr.ie>

> 'Twas brillig, and Raymond Yau at 24/07/10 04:51 did gyre and gimble:
> > 2010/7/15 Colin Guthrie <gmane@colin.guthr.ie>
> >
> >> 'Twas brillig, and Chris at 15/07/10 02:38 did gyre and gimble:
> >>> On Thu, 2010-07-15 at 08:08 +0800, Raymond Yau wrote:
> >>>
> >>>>> I posted both of those bug reports. Honestly, I just want it to work
> >>>>> without all the error output to syslog and thrashing of my HD for
> >>>>> minutes at a time. As I said, I've got the output of pulseaudio
> -vvvvv
> >>>>> if anyone would like to look at it and tell me what I need to do to
> fix
> >>>>> the problem.
> >>>>>
> >>>>> Chris
> >>>>>
> >>>>>
> >>>>>
> >>>> Just upload your current pulseaudio.log and output of alsa-info.sh to
> >>>> mandriva 's bugzilla
> >>>>
> >>>> Cannot obtain any conclusion based on the log which you have posted
> last
> >>>> year ( xmms)
> >>>>
> >>>> as Jaroslav Kysela said , need the real system time between I/O
> >> operations
> >>>> and you'll see if it's issue in the ALSA driver or a task scheduling
> >>>> problem.
> >>>
> >>> Here is the bug report with the outputs uploaded.
> >>>
> >>> https://qa.mandriva.com/show_bug.cgi?id=60169
> >>
> >> Well seeing as my process when getting such a bug is to report it here
> >> on behalf of the user, I suspect that this has reached a stalemate....
> >>
> >>
> >>
> > Can I remove pulseaudio from mandriva 2000 ?
> >
> > I just want to test libcanberra-alsa alone ( i.e. libcanberra without
> > pulseaudio )
> >
> > when PA server abort, and libcanberra-pulse cannot connect to PA server ,
> >
> > Will libcanberra use libcanberra-alsa connect to PA using alsa-pulse
> plugin
> > ?
>
> Use draksound (or via Mandriva Control Center) to disable pulseaudio and
> the ALSA backend for canberra should be used instead.
>
> It's based on the alternatives system and the file
> /etc/sound/profiles/alsa/canberra.conf
>
>
> Col
>  <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>
>

I have used Mandriva Control Centerl to disable pulseaudio and select alsa
driver .
Perform logout and login by MCC

aplay -v test.wav  indicate that it is using dmix

there is no driver specified in .mplayer/config but when I run

mplayer -v test.wav

AO : [pulse] 44100 Hz

it seem that mplayer auto spawn PA server .

Did I miss out anything to disable pulseaudio since I assume that MCC had
performed all the necessary action ?

more /etc/asound/profiles/alsa/canberra.conf
CANBERRA_DRIVER=alsa

but

ls /etc/asound/profiles/current seem to be empty
