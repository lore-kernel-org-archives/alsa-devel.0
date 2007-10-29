From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: cmipci CM_FLINKOFF disables multinchannel playback
Date: Mon, 29 Oct 2007 17:38:42 +0100
Message-ID: <1193675922.7613.1218416245@webmail.messagingengine.com>
References: <4725EAB8.9070804@ipi.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 96C4E243AD
	for <alsa-devel@alsa-project.org>; Mon, 29 Oct 2007 17:38:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4725EAB8.9070804@ipi.ac.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Timofei V. Bondarenko" <tim@ipi.ac.ru>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Timofei V. Bondarenko wrote:
> I found the latest cmipci driver cannot playback in multichannel mode 
> anymore.
> 
> My hardware is 'CMI8738 model 55' attempting to play 2 or 4 channels 
> through the 2nd DAC i get no sound at all. 6 ch produces sound only at 
> center/bass while front and rear still mute.
> 
> I found the root of problem in redefinition of some bits of the 
> CM_REG_MISC_CTRL (0x18) register.
> Was: CM_FLINKON=0x40, CM_FLINKOFF=0x20
> Now it is: CM_FLINKON=0x80 CM_FLINKOFF=0x40
> 
> Note the CM_FLINKOFF does collide with the CM_MUTECH1=0x40 bit.
> This bit disables playback on 2nd DAC.
> 
> The CM_FLINKOFF/CM_FLINKON bits used in the 'Modem' mixer control only.
> During startup the mixer turns the modem off somewhere and this disables
> 2nd DAC as well.
> 
> Complete removal of this 'Modem' control fixes the problem.

Do you have any information about the exact chip version where this
change happened?  It appears chip versions 39 and newer don't have
a modem.


Regards,
Clemens
