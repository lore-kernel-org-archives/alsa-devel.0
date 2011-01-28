From: "Babu, Ramesh" <ramesh.babu@intel.com>
Subject: ASoC: Configuring codec PCM port question
Date: Fri, 28 Jan 2011 18:30:59 +0530
Message-ID: <12D0C12AF19E15409D57F22566E88EF50937515E81@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id EA3552455C
	for <alsa-devel@alsa-project.org>; Fri, 28 Jan 2011 14:01:05 +0100 (CET)
Content-Language: en-US
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi

My codec has 2 ports, PCM1 and PCM2 ports.
PCM2 port is used for playback and capture operations and
PCM1 is connected to Modem.
The ASoC driver has to configure, enable and disable PCM1 port during voice
call activity.

I am thinking of following two options to configure PCM1 port:

1. AlSA Mixer control:  Create mixer control and provide options like VOICE_HS,
	VOICE_IHF, VOICE_EP and VOICE_DISABLE. Application will use one of the option to
	Configure the PCM1 port.

2. IOCTL : Application invokes IOCTL in hardware specific driver code and then it enables
	PCM1 port (cross-path DAPM ?) 

Which is the best way to implement it?
Are there any other existing way to implement it?

Thanks
Ramesh
