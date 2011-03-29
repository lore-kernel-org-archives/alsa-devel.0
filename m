From: hong zhang <henryzhang62@yahoo.com>
Subject: capture file size is 44 bytes only from "arecord
	audio.wav"
Date: Mon, 28 Mar 2011 18:11:12 -0700 (PDT)
Message-ID: <144414.26449.qm@web161714.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm1.bullet.mail.bf1.yahoo.com (nm1.bullet.mail.bf1.yahoo.com
	[98.139.212.160])
	by alsa0.perex.cz (Postfix) with SMTP id 0ECD8103806
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Mar 2011 03:11:14 +0200 (CEST)
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

List,

I create a HDMI interface for TI davinic SoC. But capture file, my.wav, size is only 44 bytes after "arecord my.wav".

1. "arecord -l" display interface as:

root@c6a816x-evm:~# arecord -l
**** List of CAPTURE Hardware Devices ****
card 0: hdmi [TI81XX hdmi], device 0: HDMI McASP Receive hdmi_sii9135-0 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0

2. root@c6a816x-evm:/dev/snd# ls
controlC0  pcmC0D0c   timer

I check sound/soc/davinci and see snd_pcm_lib_ioctl() is useless. 

Could anyone please give me hint where to start debug?

Thanks.

---henry
