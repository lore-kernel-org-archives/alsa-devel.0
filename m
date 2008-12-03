From: Hector Martin <hector@marcansoft.com>
Subject: Re: HDA: CLFE DAC on ALC889 (Acer Aspire 8930G)
Date: Wed, 03 Dec 2008 15:41:39 +0100
Message-ID: <49369AA3.4010909@marcansoft.com>
References: <4935D9E2.1040704@marcansoft.com> <s5hocztpwll.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.marcansoft.com (marcansoft.com [80.68.93.119])
	by alsa0.perex.cz (Postfix) with ESMTP id 6192D1037FC
	for <alsa-devel@alsa-project.org>; Wed,  3 Dec 2008 15:41:43 +0100 (CET)
In-Reply-To: <s5hocztpwll.wl%tiwai@suse.de>
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
> Did you change "Channel Mode" setting?
Yes, of course.

> The only concern with your change is the possible incompatibility with
> the existing 4930g model.  If the pin mapping is identical, then it's
> fine to change the existing code.  If not, it'd be safer to create a
> new model preset.

Right. I'm just adding new output pin configurations, so there's a good 
chance that it can be unified with the existing 4930g model. Someone 
would have to test it on 4930g to make sure it doesn't break anything 
though.

-- 
Hector Martin (hector@marcansoft.com)
Public Key: http://www.marcansoft.com/marcan.asc
