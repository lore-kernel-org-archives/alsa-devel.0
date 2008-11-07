From: "Baek Chang" <baeksan@ccrma.stanford.edu>
Subject: S24_BLE does not play using aplay.
Date: Thu, 6 Nov 2008 16:59:31 -0800
Message-ID: <aceb60a00811061659o11eec5f4s6c5b6c4ba470b873@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.184])
	by alsa0.perex.cz (Postfix) with ESMTP id D2108103860
	for <alsa-devel@alsa-project.org>; Fri,  7 Nov 2008 01:59:32 +0100 (CET)
Received: by nf-out-0910.google.com with SMTP id e27so614842nfd.32
	for <alsa-devel@alsa-project.org>; Thu, 06 Nov 2008 16:59:31 -0800 (PST)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I am testing some things with aplay and I am trying to play a stereo Signed
24-bit 3 byte, 48kHz PCM file.

I get the following error:

Playing WAVE 'sine_24_48k.wav' : Signed 24 bit Little Endian in 3bytes, Rate
48000 Hz, Stereo
aplay: set_params:961: Sample format non available


Does aplay only work for S24_LE in 4 bytes?

Thanks in advance

Baek
