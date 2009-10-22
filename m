From: Szabolcs Erki <szabolcs@szabolcserki.com>
Subject: Developing and cross-compiling an ASoC driver
Date: Thu, 22 Oct 2009 16:08:18 +0200
Message-ID: <1608652916.20091022160818@szabolcserki.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay01.digicable.hu (relay01.digicable.hu [92.249.128.189])
	by alsa0.perex.cz (Postfix) with ESMTP id 44A7C1037F1
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Oct 2009 16:08:23 +0200 (CEST)
Received: from [94.21.107.64] (helo=szabolcs-PC)
	by relay01.digicable.hu with esmtpa
	id 1N0yKz-0001uE-Ox for <alsa-devel@alsa-project.org>;
	Thu, 22 Oct 2009 16:08:21 +0200
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

Hello,

I recently designed a custom board based on an AT91SAM9 microcontroller
connected with an ADC via I2S.
In the project we need a data acquisition application, which can store
audio stream to wav files. On my opinion arecord fulfills our requirements. The "only" thing we have to do
is writing an ASoC driver especially for the ADC (ADS1274), and cross
compile it to the Linux4SAM embedded Linux environment.

I didn't find any suitable description how to do a cross-platform driver development process.
Could you please give me some introduction how to:

- cross compile alsa-driver (AFAIK ASoC is part of it, and ALSA is
part of the linux kernel), and alsa-utils (for getting arecord)
- cross compile the newly developed alsa driver
- integrate ASoC and the custom driver to the patched kernel
(Linux4SAM) and cross compile them to one image.

Thank you for your help in advance!

Br,
Szabolcs Erki
