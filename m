From: Trent Piepho <xyzzy@speakeasy.org>
Subject: BT87x ALSA driver patches
Date: Wed, 25 Jul 2007 15:43:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0707251520530.30561@shell4.speakeasy.net>
References: <Pine.LNX.4.58.0707211727490.2511@shell2.speakeasy.net>
	<1185200670.8251.3.camel@gaivota>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1913207790921377603=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.sea5.speakeasy.net (mail1.sea5.speakeasy.net
	[69.17.117.3]) by alsa0.perex.cz (Postfix) with ESMTP id 59E6E1038DC
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Jul 2007 00:43:53 +0200 (CEST)
In-Reply-To: <1185200670.8251.3.camel@gaivota>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============1913207790921377603==
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 23 Jul 2007, Mauro Carvalho Chehab wrote:
> Em S=C3=A1b, 2007-07-21 =C3=A0s 17:36 -0700, Trent Piepho escreveu:
> > 01/01: bttv: Fix Viewcast Osprey 440 support
> > http://linuxtv.org/hg/~tap/v4l-dvb?cmd=3Dchangeset;node=3D8e72fe5675b3
> >
> > I have two other changes that only affect the ALSA driver part.  Should=
 I
> > send those to ALSA or to you?
>
> Please send to ALSA guys, c/c me.

Ok, I'll do that.  What about the two lines to bt87x.c that this patch adde=
d?
I seemed logical to me that they should be part of the same patch at git as
the changes to bttv-cards.c, but I suppose it's not 100% necessary to do so=
,
the kernel will still compile and not crash.

Do you plan to send this to git as one patch, or to strip out the ALSA chan=
ge?
I'm just wondering if I should send these two lines to the ALSA people as a
separate patch, of if they will get them into their hg via a kernel-sync
patch.  My bt87x patches depend on this one, so somehow the ALSA hg needs
to get this change before I can send them the next two.

The problem really, is that having two divers for the same chip split into
v4l-dvb and ALSA like this a pain.  IMHO, it would make a lot more sense
to put the bttv alsa driver into v4l-dvb, like the saa7134 alsa and oss
and cx88 alsa drivers are.

> >  drivers/media/video/bt8xx/bttv-cards.c |  240 ++++++++++++++++++------=
---------
> >  sound/pci/bt87x.c                      |    2
> >  2 files changed, 137 insertions(+), 105 deletions(-)

--===============1913207790921377603==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1913207790921377603==--
