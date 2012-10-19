From: Andre Schramm <andre.schramm@iosono-sound.com>
Subject: Re: HDSPM - Problems with SyncIn
Date: Fri, 19 Oct 2012 19:49:42 +0200
Message-ID: <20121019194942.71895b4a@desk27.iosono.home>
References: <20110625155632.4876f6e6@revell.mafea.no-ip.org>
 <4E06060E.2040404@stackingdwarves.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 289BD265CAD
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2012 19:58:49 +0200 (CEST)
In-Reply-To: <4E06060E.2040404@stackingdwarves.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-1?B?SvZybg==?= Nettingsmeier <nettings@stackingdwarves.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, 25 Jun 2011 18:00:14 +0200
J=F6rn Nettingsmeier <nettings@stackingdwarves.net> wrote:

> On 06/25/2011 03:56 PM, Andre Schramm wrote:
> >
> > Hello,
> >
> > I did some tests with the SyncIn-Feature of the HDSPe cards.
> >
> >
> > [root@localhost ~]# lspci |grep Mult
> > 01:00.0 Multimedia audio controller: Xilinx Corporation RME
> > Hammerfall DSP MADI (rev d2)
> > 02:00.0 Multimedia audio controller: Xilinx Corporation RME
> > Hammerfall DSP MADI (rev d2)
> >
> >
> > The SyncOut of card 2:00 was plugged to the SyncIn of 1:00 and 1:00
> > was put to AutoSync-mode automatically upon boot. Problem is that
> > the amixer output seems to be inconsistent and differs from the
> > proc output as well, so I'm not sure which one to trust.
> =

> for the record, i'm seeing the syncIn status reported as "sync" even =

> when there is no sync cable attached (same with tco), so either the =

> status is misinterpreted by alsamixer, or the driver really gets =

> confused about sync status.
> =

> =

This should be fixed now. [1] [2]


Cheers,
  Andre

[1]
http://mailman.alsa-project.org/pipermail/alsa-devel/2012-October/056382.ht=
ml
[2]
http://mailman.alsa-project.org/pipermail/alsa-devel/2012-October/056385.ht=
ml
