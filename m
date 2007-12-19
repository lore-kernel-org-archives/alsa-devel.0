From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: How do I use SNDRV_PCM_INFO_JOINT_DUPLEX?
Date: Wed, 19 Dec 2007 09:27:34 +0100
Message-ID: <1198052854.5470.1227353809@webmail.messagingengine.com>
References: <47682492.7050500@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id CEC5D2449A
	for <alsa-devel@alsa-project.org>; Wed, 19 Dec 2007 09:27:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <47682492.7050500@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Timur Tabi wrote:
> I discovered the SNDRV_PCM_INFO_JOINT_DUPLEX option, but I can't figure out how 
> to use it.  I know it needs to be set in my snd_pcm_hardware.info, but then 
> what?  How do I tell ALSA that the "joint" part is just that the sample sizes 
> must be the same?

This flag just tells applications that this device may behave
somewhat differently when playback and capture are used at the same
time.

The actual behaviour must be implemented by the driver.  In the PCM open
callbacks, set a constraint on the sample format if the other stream is
already configured:
snd_pcm_hw_constraint_mask(runtime, SNDRV_PCM_HW_PARAM_FORMAT, SNDRV_PCM_FMTBIT_xxx);

Since it is possible to open both streams at the same time without yet
configuring them, you have to check again in the hw_params callback.


HTH
Clemens
