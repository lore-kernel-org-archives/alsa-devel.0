From: Colomban Wendling <lists.ban@herbesfolles.org>
Subject: Re: Bug#635362: Realtek ALC889: HDA Intel and kernel
 3.0 gives choppy sound
Date: Wed, 27 Jul 2011 01:22:40 +0200
Message-ID: <4E2F4C40.9000805@herbesfolles.org>
References: <4E2F2E47.8080902@herbesfolles.org> <j0ngeg$bav$3@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.herbesfolles.org (a4nancy.globenet.org [80.67.172.114])
	by alsa0.perex.cz (Postfix) with ESMTP id D3D1B1037F8
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Jul 2011 01:22:41 +0200 (CEST)
In-Reply-To: <j0ngeg$bav$3@dough.gmane.org>
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
Cc: Jonathan Nieder <jrnieder@gmail.com>, 635362@bugs.debian.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Le 27/07/2011 00:52, Julian Sikorski a =E9crit :
> I am probably wrong, but did you try setting CONFIG_SND_HDA_BUFFER_SIZE
> to a larger value?

I'm afraid I can't find the setting. However, I tried to set
CONFIG_SND_HDA_PREALLOC_SIZE to 2048 as suggested in the doc since my
system is supposed to run pulseaudio [1], but anyway it hasn't changed
anything than with the default (64) value.

Regards,
Colomban


[1] even though I don't really know what this setting is supposed to
improve -- I can only guess a bigger value avoids resizing the buffer
every time if a bigger size is needed?
