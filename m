From: Stefan Schoenleitner <dev.c0debabe@gmail.com>
Subject: implement delay in ioplug alsa plugin
Date: Wed, 19 Aug 2009 12:29:59 +0200
Message-ID: <4A8BD427.7000607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from netfinity.tbmn.org (mail.tbmn.org [88.117.197.126])
	by alsa0.perex.cz (Postfix) with ESMTP id B629E24532
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Aug 2009 12:30:13 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by netfinity.tbmn.org (Postfix) with ESMTP id 5725A4BE05
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Aug 2009 12:30:18 +0200 (CEST)
Received: from netfinity.tbmn.org ([127.0.0.1])
	by localhost (netfinity.tbmn.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XJ5tqdc1ZDqS for <alsa-devel@alsa-project.org>;
	Wed, 19 Aug 2009 12:30:18 +0200 (CEST)
Received: from [192.168.1.5] (chello080108001212.35.11.tuwien.teleweb.at
	[80.108.1.212])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mne@tbmn.org)
	by netfinity.tbmn.org (Postfix) with ESMTPSA id EB04B4BDFA
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Aug 2009 12:30:17 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I managed to write an ioplug plugin which dumps a raw PCM stream to a
file (similar to the way the file or tee plugins do, but without a slave
device).

However, instead of immediately writing all the samples to the file, I
would like to add some delay so that the samples are written to the file
in real time at the frequency of the sampling rate.

Thus if there is a single channel stream with 16bits being played at a
sampling rate of 8kHz, each 1/8000sec exactly 16 bits should be written
to the file.

The reason for this is that I have a DSP attached over SPI which needs
exactly one audio sample per interval.
In order to talk to the DSP there is a SPI device-file which my ioplugin
would use to write the samples to.

What is the best way to implement such a delay ?

I'm pretty sure that just adding some usleep calls() won't work very
well, since the write operations to the device file probably don't take
the same amount of time every time.
Maybe it would work with non-blocking writes to the device file and a
high precision timer ?

cheers,
Stefan
