From: "Ash Willis" <ashwillis@programmer.net>
Subject: Re: porter wanted: AMD Geode SCx200 driver OSS to ALSA
Date: Sun, 20 May 2007 03:01:34 -0500
Message-ID: <20070520080134.9BB521F50B1@ws1-2.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webmail-outgoing.us4.outblaze.com
	(webmail-outgoing.us4.outblaze.com [205.158.62.67])
	by alsa0.perex.cz (Postfix) with ESMTP id 981582455B
	for <alsa-devel@alsa-project.org>;
	Sun, 20 May 2007 10:01:30 +0200 (CEST)
Received: from unknown (unknown [192.168.8.90])
	by webmail-outgoing.us4.outblaze.com (Postfix) with QMQP id
	ECAD91800130
	for <alsa-devel@alsa-project.org>; Sun, 20 May 2007 08:01:34 +0000 (GMT)
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
To: =?utf-8?B?TWFydGluLcOJcmljIFJhY2luZQ==?= <q-funk@iki.fi>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sorry for this really late reply, I just wanted to add a note:

> > (Would now also be a good time to ask for snd-sc5535audio to be
> > renamed snd-sc5535 for consistence with other driver names?)
> >

I agree with you, I think it should be renamed. I've just ported
the SND_KAHLUA driver from OSS (patch not released yet). It covers
the cs5530 (VSA1 only). I've named it snd-cs5530.

This audio suffix seems a bit wacky to me. Surely the snd prefix is
adequate to distinguish it from an IDE driver, for example :)

Ash


=
Nose Surgery Specialist in Manhattan, NY
Rhinoplasty surgeon Geoffrey W. Tobias has pioneered the "un-nose job," the nose job that doesn't look like one. Chosen by "New York Magazine" as a nose expert. Video clips.
http://a8-asy.a8ww.net/a8-ads/adftrclick?redirectid=1b57edb21974e0b43470c0cd64d0d6ea
