From: "Iovescu, Magdalena" <m-iovescu1@ti.com>
Subject: Noisy audio - ALSA Configuration
Date: Wed, 15 Aug 2007 16:03:54 -0500
Message-ID: <28FEEE653F330C4FA01F6C799E7BBA5E01CDD7D7@dlee10.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from soda.ext.ti.com (soda.ext.ti.com [198.47.26.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A07F243B8
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Aug 2007 23:04:01 +0200 (CEST)
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by soda.ext.ti.com (8.13.7/8.13.7) with ESMTP id l7FL3sQ8000764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <alsa-devel@alsa-project.org>; Wed, 15 Aug 2007 16:03:59 -0500
Received: from dlee70.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.7/8.13.7) with ESMTP id l7FL3s4I013604
	for <alsa-devel@alsa-project.org>; Wed, 15 Aug 2007 16:03:54 -0500 (CDT)
Content-class: urn:content-classes:message
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

Does anyone have examples or documentation on how to configure periods,
frames and buffers for various sample rates?

I am writing a program to route a mp3 decoder output to ALSA on an ARM
processor, and I get noisy audio. For a CD quality stream (S16_LE, 44100
kHz, Stereo, 128 bps) I am using an output buffer of 44100 bytes, a
period of 44100/(channels*2). With a buffer this big, I do not get
underruns, but all the writes are short writes. I have not been able to
find the right configuration to avoid short writes, and more
importantly, to get good quality audio.

What do 'short writes' (I am using writei) really mean? Is this a
performance issue in the driver, or is mainly because of buffer setup?

I would really appreciate any help with this.

Mag
