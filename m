From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: alsactl restore: unknown hardware: ymf724f
Date: Sun, 28 Feb 2010 09:29:18 +0800
Message-ID: <4f3252891002271729p6eb66724v62ce97ea9a6eb577@mail.gmail.com>
References: <hm5aba$p65$1@dough.gmane.org>
	<alpine.LNX.2.00.1002250915480.28127@eeebox2.perex-int.cz>
	<hm5u2i$2h7$1@dough.gmane.org>
	<alpine.LNX.2.00.1002251502380.28127@eeebox2.perex-int.cz>
	<4f3252891002251511p4605f104jdac236e589d01149@mail.gmail.com>
	<hm8cus$56i$1@dough.gmane.org>
	<1267193154.29204.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f187.google.com (mail-px0-f187.google.com
	[209.85.216.187])
	by alsa0.perex.cz (Postfix) with ESMTP id 71CB62446F
	for <alsa-devel@alsa-project.org>; Sun, 28 Feb 2010 02:29:20 +0100 (CET)
Received: by pxi17 with SMTP id 17so1199303pxi.2
	for <alsa-devel@alsa-project.org>; Sat, 27 Feb 2010 17:29:19 -0800 (PST)
In-Reply-To: <1267193154.29204.0.camel@localhost.localdomain>
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

2010/2/26 Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>

> El vie, 26-02-2010 a las 13:57 +0200, Angel Tsankov escribi=F3:
> > Raymond Yau wrote:
> > > 2010/2/25 Jaroslav Kysela <perex@perex.cz>
> > >
> > >> On Thu, 25 Feb 2010, Angel Tsankov wrote:
> > >>
> > >>> Jaroslav Kysela wrote:
> > >>>> On Thu, 25 Feb 2010, Angel Tsankov wrote:
> > >>>>
> > >>>>> Hello,
> > >>>>>
> > >>>>> I run 'alsactl restore' on a machine with 2 sound cards -- a
> built-in
> > >>>>> Intel Corporation 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller
> (rev
> > >>>>> 02) and a non-built-in Yamaha Corporation YMF-724F [DS-1 Audio
> > >>>>> Controller] (rev 03) -- and get the following message:
> > >>>>>
> > >>>>> Unknown hardware: "YMF724F" "SigmaTel STAC9700,83,84"
> "AC97a:83847600"
> > >>>>> "0x1073" "0x000d"
> > >>>>> Hardware is initialized using a guess method
> > >>>>>
> > >>>>> As a consequence the volume levels of the Yamaha card do not get
> > >>>>> restored to the levels stored in /etc/asound.state.  The volume
> levels
> > >>>>> of the built-in card however are properly restored.  The
> asound.state
> > >>>>> file has been created by executing 'alsactl store'.
> > >>>>>
> > >>>>> The kernel has been built with support for ALSA.  I've built and
> > >>>>> installed the kernel modules for both cards (not the ones in the
> > >>>>> alsa-driver package but those that come with kernel version
> 2.6.30.2).
> > >>>>> Any ideas why alsactl cannot find the hardware it has previously
> > >>>>> identified as "YMF724F", "SigmaTel STAC9700,83,84", and so on?
> > >>>> The logic of alsactl is to restore the state from /etc/asound.state
> if
> > >> it
> > >>>> is valid. It seems like the set_controls() function in
> alsactl/state.c
> > >>>> returns an error code for a reason.
> > >>>>
> > >>>> Could you try to compile the latest alsa-utils snapshot
> > >>>> (http://www.alsa-project.org/snapshot/) and run './alsactl -d
> restore'
> > >> in
> > >>>> alsa-utils/alsactl directory? A warning (fail reason) should be
> printed.
> > >>> I've attached a bash shell script that I used to download, configur=
e,
> > >>> compile, and run alsactl.  I've also attached a .log file with stdo=
ut
> and
> > >>> stderr that I got while executing the script.
> > >> Thanks. I've added more debug print lines to state.c. Could you rerun
> your
> > >> script and append also '/etc/asound.state' file and output from
> > >> 'alsa-info.sh --no-upload' to your output tarballs? Send me this
> tarball
> > >> privately or just an URL to this list.
>
>
> Looks similar to my problem:
> http://www.spinics.net/lists/alsa-devel/msg31422.html
>
>
>
your problem is "alsactl restore" become "alsactl init" when the number of
controls is more than those in state file.

"Hardware is initialized using a guess method" instead of restore from
asound.state

alsactl -f /var/lib/alsa/asound.state restore
Unknown hardware: "VIA8237" "Realtek ALC658D" "AC97a:414c4781" "0x147b"
"0x1415"
Hardware is initialized using a guess method
