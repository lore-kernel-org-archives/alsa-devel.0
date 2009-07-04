From: Christian Esken <esken@kde.org>
Subject: Re: Testers wanted: New SB X-Fi driver
Date: Sat, 4 Jul 2009 23:27:04 +0200
Message-ID: <200907042327.05365.esken@kde.org>
References: <1246384544.6380.6.camel@ubuntu.ubuntu-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42]) by alsa0.perex.cz (Postfix) with ESMTP id A4C6F24BC3
	for <alsa-devel@alsa-project.org>;
	Sat,  4 Jul 2009 23:27:09 +0200 (CEST)
Received: from mail-in-09-z2.arcor-online.net (mail-in-09-z2.arcor-online.net
	[151.189.8.21]) by mx.arcor.de (Postfix) with ESMTP id 018D23FE4BC
	for <alsa-devel@alsa-project.org>;
	Sat,  4 Jul 2009 23:27:07 +0200 (CEST)
Received: from mail-in-17.arcor-online.net (mail-in-17.arcor-online.net
	[151.189.21.57])
	by mail-in-09-z2.arcor-online.net (Postfix) with ESMTP id 02F2028F79A
	for <alsa-devel@alsa-project.org>;
	Sat,  4 Jul 2009 23:27:07 +0200 (CEST)
Received: from firefly.localnet (dslb-084-062-067-006.pools.arcor-ip.net
	[84.62.67.6])
	by mail-in-17.arcor-online.net (Postfix) with ESMTPS id 93BD33B260C
	for <alsa-devel@alsa-project.org>;
	Sat,  4 Jul 2009 23:27:06 +0200 (CEST)
In-Reply-To: <1246384544.6380.6.camel@ubuntu.ubuntu-domain>
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

Am Dienstag 30 Juni 2009 19:55:44 schrieb Matthias Diehl:
> > At Tue, 30 Jun 2009 16:10:45 +0200,
> >
> > Matthias Diehl wrote:
> > > hi,
> > >
> > > i guess you dont speak german, do you? well, i'll try it in
> >
> > english ;-)
> >
> > > i tried to install your newest x-fi "hack" in ubuntu 9.04 64bit.

Interesting enough, I don't manage to get it working under 64 ("SuSE 11.1, 64 
Bit, Xen") bit either. Could you check if you also see something in your 
syslog (e.g. /var/log/messages) when running speaker-test ? 

When I tested the same on the same hardware  on "Kubuntu  Karmic alpha 2, 32 
bit", I get sound.

It might be an indication of a either:
- a 32/64 bit issue
- the kernel version (Kubuntu karmic ships with 2.6.30)
- Xen vs non-Xen
- something else

   Christian
