From: =?ISO-8859-1?Q?=C1kos_Mar=F3y?= <akos@maroy.hu>
Subject: opening a device multiple times?
Date: Wed, 29 Jun 2011 13:47:59 +0200
Message-ID: <4E0B10EF.60208@maroy.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perec.tyrell.hu (perec.tyrell.hu [173.244.180.170])
	by alsa0.perex.cz (Postfix) with ESMTP id BA0501038B6
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jun 2011 13:48:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by perec.tyrell.hu (Postfix) with ESMTP id 935D510269B0
	for <alsa-devel@alsa-project.org>; Wed, 29 Jun 2011 07:48:15 -0400 (EDT)
Received: from perec.tyrell.hu ([127.0.0.1])
	by localhost (perec.tyrell.hu [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 6HpIFITnDakJ for <alsa-devel@alsa-project.org>;
	Wed, 29 Jun 2011 07:48:05 -0400 (EDT)
Received: from [192.168.1.135] (dsl5401C0B2.pool.t-online.hu [84.1.192.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: akos@maroy.hu)
	by perec.tyrell.hu (Postfix) with ESMTPSA id 783FC10269A4
	for <alsa-devel@alsa-project.org>; Wed, 29 Jun 2011 07:48:04 -0400 (EDT)
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

Hi,

I'm writing a piece of code that uses ALSA audio devices, where I open
the same output device multiple times, as a simple way to have parallel
audio channels, where I can send audio data to each 'channel' (PCM
handle) simultaneously, and the ALSA layer will mix the audio together.

My experience is that this works with some audio devices (for example,
with a pulse audio - ALSA gateway), but not on some other devices (for
example, on a USB sound device, driven by ALSA). In the latter case,
snd_pcm_open() will refuse to open the audio device multiple times.

I wonder what the generic concept here is - is it generally 'OK' to open
an audio device multiple times? If not, why not? :)


Akos
