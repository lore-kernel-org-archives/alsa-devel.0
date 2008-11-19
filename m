From: "Bryan Wu" <cooloney@kernel.org>
Subject: [Question] Can I open a substream in kernel space
	without attach to a file pointer?
Date: Wed, 19 Nov 2008 18:00:36 +0800
Message-ID: <386072610811190200l576d7735rb0188ab53f5185fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.153])
	by alsa0.perex.cz (Postfix) with ESMTP id C52FF245F4
	for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2008 11:00:37 +0100 (CET)
Received: by yw-out-1718.google.com with SMTP id 9so2369278ywk.2
	for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2008 02:00:36 -0800 (PST)
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
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA devel <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

I am developing a USB gadget driver compliant to USB Audio Class Spec 2.0.
So I want to open a PCM substream and do some playback of capture,
then close them?

I found snd_pcm_open_substream() is for opening a substream and attach
it to a file.
But in my application, there is no need to open a file before opening
a substream.

- Is there any interface for me to open a substream in kernel space
without attach to a file?
- How to playback and capture in kernel space, use snd_pcm_lib_write
and snd_pcm_lib_read?
- How to get the snd_pcm_hardware struct from low level driver,
because I have to get the hardware configuration of the snd pcm
device?

And I am reading the code of OSS emulator in ALSA. It provides some
info about the kernel space sound card programming.

Thanks a lot
-Bryan
