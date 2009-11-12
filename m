From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: PC Beep or PC Speaker or just Beep? and HDA Beep
 code...
Date: Thu, 12 Nov 2009 12:06:57 +0100 (CET)
Message-ID: <alpine.LNX.2.00.0911121203190.4806@eeebox2.perex-int.cz>
References: <alpine.LNX.2.00.0910221740280.5519@eeebox2.perex-int.cz>
	<s5h1vklythl.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0911031147520.5500@eeebox2.perex-int.cz>
	<s5hiqdrlu8n.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0911031235130.5500@eeebox2.perex-int.cz>
	<s5heioflt08.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0911031510170.5500@eeebox2.perex-int.cz>
	<alpine.LNX.2.00.0911121056030.4806@eeebox2.perex-int.cz>
	<s5hmy2sc8l8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 2B934103946
	for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2009 12:06:58 +0100 (CET)
In-Reply-To: <s5hmy2sc8l8.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 12 Nov 2009, Takashi Iwai wrote:

> IOW, I'm fine with an additional implementation for the dynamic beep
> on/off.  But, the mixer interface doesn't look like the best interface
> to me.

I would prefer something which is comfortable for user. The module 
parameter or sysfs file is not a good way to explain users how they can 
change the beep behaviour.

We have basically four ways:

1) module parameter (difficult tracking of changes through sysfs)
2) sysfs file
3) current implementation
4) create new control with different name (like "HDA Beep Enable Switch")

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
