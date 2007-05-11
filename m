From: Joachim =?ISO-8859-1?Q?F=F6rster?= <mls.JOFT@gmx.de>
Subject: Re: embedded sound architecture question
Date: Fri, 11 May 2007 17:21:05 +0200
Message-ID: <1178896865.5727.18.camel@localhost>
References: <1178743654.29464.1.camel@localhost>
	<20070509142044.33de8ba2@jutz-fc6.na.corp.dmxmusic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id A121F24391
	for <alsa-devel@alsa-project.org>;
	Fri, 11 May 2007 17:21:06 +0200 (CEST)
In-Reply-To: <20070509142044.33de8ba2@jutz-fc6.na.corp.dmxmusic.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2007-05-09 at 14:20 -0700, John L. Utz III wrote:
> On Wed, 09 May 2007 22:47:34 +0200
> "Joachim F=F6rster" <mls.JOFT@gmx.de> wrote:
> > My question is: Does the architecture described below make sense/is
> > reasonable with ALSA and Linux?
> =

> i think you might have to answer an earlier question first; 'does it
> make sense to call this an ac97 controller?' I dont recall seeing a
> ring buffer as part of the ac97 standard. i'd suggest that you take the
> time to flesh out completely how the ring buffer is supposed to replace
> dma and ram while still presenting an ac97 set of verbs because i am
> stuck with the gut feeling that you will some important things will
> have to be really different.

Hmmm, well is there a standard document for AC97 controllers, too? So
far, I know about the AC97 Codec standard, only. Anyway, just ignore the
"AC97" in front of "controller" - a custom controller for an AC97 Codec,
which uses the described way of operation and features. The/My question
is, if such a thing is reasonable and fits into ALSA/Linux.

> > I read, that many applications don't work, if MMAP mode is not
> > supported and classic read/write (copy()/silence()) is used, only. Is
> > there a black list of apps, which don't work?
> =

> i doubt seriously that such a thing exists, how could it? new apps are
> written everyday, old apps in binary only form get 'shimmed' forward
> with comaptibility libraries to work in newer operating systems.

So, not using MMAP mode is just a no-go ... ? I don't want to write a
driver which cannot be used with most ALSA applications out there.

 Joachim
