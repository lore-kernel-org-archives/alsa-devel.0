From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Re: MIDI on ice1724 -  fixing HG
Date: Fri, 25 Apr 2008 09:06:19 +0200
Message-ID: <481182EB.1010800@insite.cz>
References: <480E495B.20607@insite.cz>	<s5h63u8evih.wl%tiwai@suse.de>	<480F189A.7030500@insite.cz>	<480F99B8.3010408@insite.cz>	<s5hod7zb4j7.wl%tiwai@suse.de>	<4810F1FA.4020300@insite.cz>
	<s5hhcdq4fnz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.insite.cz (cable.insite.cz [84.242.84.93])
	by alsa0.perex.cz (Postfix) with ESMTP id CB3962470A
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Apr 2008 09:06:27 +0200 (CEST)
In-Reply-To: <s5hhcdq4fnz.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



Takashi Iwai wrote:
>>
>> I do not know the reason for MPU401_INFO_NO_ACK. You removed it from the
>> original patch, but without it I always get the input/output error.
> 
> Ah, thanks, I overlooked it.
> Fixed now.

Takashi, thanks, but the patch I sent you sets MPU401_INFO_INPUT and 
MPU401_INFO_OUTPUT flags too. They enable the actual input/output 
methods in mpu401_uart.c.

Thanks a lot for fixing.

Pavel.
