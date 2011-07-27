From: Julian Sikorski <belegdol@gmail.com>
Subject: Re: Bug#635362: Realtek ALC889: HDA Intel and kernel
 3.0 gives choppy sound
Date: Wed, 27 Jul 2011 07:51:52 +0200
Message-ID: <j0o91o$2k6$1@dough.gmane.org>
References: <4E2F2E47.8080902@herbesfolles.org> <j0ngeg$bav$3@dough.gmane.org>
	<4E2F4C40.9000805@herbesfolles.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 2139C1037EA
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Jul 2011 07:52:14 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1Qlx2K-0006oD-Ua
	for alsa-devel@alsa-project.org; Wed, 27 Jul 2011 07:52:04 +0200
Received: from 178-83-206-236.dynamic.hispeed.ch ([178.83.206.236])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 27 Jul 2011 07:52:04 +0200
Received: from belegdol by 178-83-206-236.dynamic.hispeed.ch with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 27 Jul 2011 07:52:04 +0200
In-Reply-To: <4E2F4C40.9000805@herbesfolles.org>
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

W dniu 27.07.2011 01:22, Colomban Wendling pisze:
> Le 27/07/2011 00:52, Julian Sikorski a =E9crit :
>> I am probably wrong, but did you try setting CONFIG_SND_HDA_BUFFER_SIZE
>> to a larger value?
> =

> I'm afraid I can't find the setting. However, I tried to set
> CONFIG_SND_HDA_PREALLOC_SIZE to 2048 as suggested in the doc since my
> system is supposed to run pulseaudio [1], but anyway it hasn't changed
> anything than with the default (64) value.
> =

> Regards,
> Colomban
> =

> =

> [1] even though I don't really know what this setting is supposed to
> improve -- I can only guess a bigger value avoids resizing the buffer
> every time if a bigger size is needed?
Yes, that's what I meant. Sorry it did not help.

Julian
