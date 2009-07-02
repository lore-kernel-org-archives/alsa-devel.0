From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: Help required with debugging
Date: Thu, 2 Jul 2009 10:38:42 +0530
Message-ID: <98769532B4BB14429434178695419EAE5BAEB764@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 26ACC245E5
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Jul 2009 07:09:37 +0200 (CEST)
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
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi,

I see the following behavior and have a couple of questions that would help me debug my new driver/hardware.

snd_pcm_lib_read1()     - > snd_pcm_update_hw_ptr()
->ops->ack()
            This enables the driver to send data to hardware for capture
snd_pcm_period_elapsed() -> hw_ptr_interrupt
            This updates the runtime->hw_ptr_jiffies. The jdelta calculated is proper and I find no issues with this.
snd_pcm_lib_read1() is returned back

Alsa calls driver's ack inbetween here
snd_pcm_period_elapsed() -> snd_pcm_update_ hw_ptr_interrupt
            This updates the runtime->hw_ptr_jiffies. The jdelta calculated is proper and I find no issues with this.

snd_pcm_lib_read1()     - > snd_pcm_update_ hw_ptr()
            Here the runtime->hw_ptr_jiffies is updated and this causes my next jdelta to be very less in snd_pcm_period_elapsed() -> snd_pcm_update_hw_ptr_interrupt.

Why is runtime->hw_ptr_jiffies updated in hw_ptr()? This should be only updated in the interrupt context right? Without this statement, my driver/hardware works fine.
Or is there any constraint I can set somehow such that the hw_ptr_jiffies is only updated in the hw_ptr_interrupt function?

Thanks,
Harsha
