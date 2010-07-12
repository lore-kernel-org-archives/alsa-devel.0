From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: issue with TWL4030
Date: Mon, 12 Jul 2010 13:12:48 +0300
Message-ID: <201007121312.48518.peter.ujfalusi@nokia.com>
References: <AANLkTilwdeNLChInBSaFIpVTLDONLXIIHVpLk3Aibk0v@mail.gmail.com>
	<1278366040.3258.238.camel@odin>
	<AANLkTilazb9awx-ncJF31JBx4O2wf2Fimzl9EWI9W7YT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id AFC762433E
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Jul 2010 12:12:56 +0200 (CEST)
In-Reply-To: <AANLkTilazb9awx-ncJF31JBx4O2wf2Fimzl9EWI9W7YT@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Grazvydas Ignotas <notasas@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi,

On Tuesday 06 July 2010 01:51:20 ext Grazvydas Ignotas wrote:
> On Tue, Jul 6, 2010 at 12:13 AM,  <peter.ujfalusi@nokia.com> wrote:
> > What I can think of is:
> > If only one (the master) stream has been opened, and the stream is not
> > running (the pcm_trigger has not been called yet), than we could allow
> > reconfiguration of the codec. Might work OK, but it might cause some
> > problems under different scenario.
> =

> This sounds good to me, I wonder what that different scenario could
> be.

It's hard to say what scenario, but if we start to fix application bugs in =

driver level, than surely it will not going to be an easy task.

> Is it worth trying implementing that (i.e. would such patch be
> even considered)?

As of it now, I'm not planning to add workaround to this, since I can not r=
eally =

test if it is working correctly.
Also I just came back from holiday, and my mailbox is quite full, so do not =

expect that I can even take a look at this in the near future.

Having said that.. since I do care about the twl4030 codec driver (and it's =

users), I will try to allocate time to fix it for you.

> On Tue, Jul 6, 2010 at 12:40 AM, Liam Girdwood <lrg@slimlogic.co.uk> wrot=
e:
> > Please port your app to ALSA, it's really the easiest option (look at
> > aplay.c for programming sequence).
> =

> The problem is not new apps, but legacy ones. Pandora is spiritual
> successor of Gamepark/GPH devices, which only had OSS drivers, so we
> have many apps/games outputing through OSS, some of them without
> source available. We will have to provide userspace OSS emulation at
> least, and in-kernel OSS emulation is attractive because of
> performance reasons.

I would advice to use the userspace emulation for now. There might be kerne=
l =

level fix for this, but it will take time.

-- =

P=E9ter
