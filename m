From: Joost Verdoorn <jpverdoorn@gmail.com>
Subject: No HDMI audio output, nVidia audio not listed in lspci
Date: Thu, 26 May 2011 11:47:34 +0200
Message-ID: <BANLkTimybCjUxvTEJZJ_qZZ8y+s7+cHcUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 50B2310380A
	for <Alsa-devel@alsa-project.org>;
	Thu, 26 May 2011 11:47:35 +0200 (CEST)
Received: by iym7 with SMTP id 7so591313iym.38
	for <Alsa-devel@alsa-project.org>; Thu, 26 May 2011 02:47:34 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi there,

After asking around on the IRC it was recommended to me that I should take
my problem to the alsa-devel mailing list. So here goes.

When I ran Windows (1 year+ ago) I never tried HDMI audio output, or any
HDMI output for that matter. Therefore I cannot verify that HDMI audio
worked in the first place. However, my GPU, and more specifically, my
laptop, is specced to be able to deliver audio through HDMI. I've been
looking on and off for a solution to this problem for a couple of months
now, but nowhere I found a solution to the specific symptoms that I'm
having.

My laptop in a nutshell:

Machine: HP Compaq 8510w Mobile Workstation
Chipset:  Mobile Intel PM965 with 800-MHz front side bus
GPU: NVIDIA Quadro FX 570M graphics with up to 256MB dedicated memory (512
MB TurboCache)
CPU: Intel Core 2 Duo Processor T9300 (2.50 GHz, 6 MB L2 cache, 800 MHz FSB)

OS: Linux x86-64 Ubuntu 11.04 Natty Narwhal
nVidia Driver Version: 270.41.06

Output of alsa-info:
http://paste.ubuntu.com/613101/

Output of lspci:
http://paste.ubuntu.com/613123/

I really hope this is the right place for me to find a solution, with your
help, and I thank you all for taking the time to read this email.

Joost Verdoorn
