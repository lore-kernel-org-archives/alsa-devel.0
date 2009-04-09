From: "Robert T. Drury" <rtdrury@earthlink.net>
Subject: oss emul: powerbook5,3 microphone to mono
Date: Thu, 09 Apr 2009 14:34:14 -0700
Message-ID: <49DE69D6.6050305@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from elasmtp-dupuy.atl.sa.earthlink.net
	(elasmtp-dupuy.atl.sa.earthlink.net [209.86.89.62])
	by alsa0.perex.cz (Postfix) with ESMTP id 7BB8C1037F0
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Apr 2009 23:33:17 +0200 (CEST)
Received: from [71.165.54.196] (helo=[192.168.1.33])
	by elasmtp-dupuy.atl.sa.earthlink.net with esmtpa (Exim 4.67)
	(envelope-from <rtdrury@earthlink.net>) id 1Ls1s3-0000YE-HY
	for alsa-devel@alsa-project.org; Thu, 09 Apr 2009 17:33:16 -0400
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

On machine powerbook5,3 the built-in microphone is attached to 
the right channel of the sound chip.  In the alsa oss emulation 
in linux-2.6.23.9 (alsa-*-1.0.12) the plugin layer copies the 
left input channel to a one-channel buffer when  calling ioctl 
SNDCTL_DSP_CHANNELS with one channel.  So no mic to mono on the 
powerbook5,3.

In the kernel source: linux-2.6.23.9/sound/core/oss/pcm_plugin.c:

The function snd_pcm_plug_read_transfer copies from the two 
channel hardware input buffer to the one channel user space 
buffer.   The left source channel appears to be selected for 
copy in function snd_pcm_plug_format_plugins.  One approach 
is to query line/mic input there for powerbook5,3 and select 
right channel source for copy.  Any ideas?
