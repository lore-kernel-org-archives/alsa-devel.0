From: Hector Martin <hector@marcansoft.com>
Subject: Re: [PATCH] RESEND: Acer Aspire 8930G support
Date: Tue, 02 Jun 2009 11:04:05 +0200
Message-ID: <4A24EB05.8060500@marcansoft.com>
References: <4A24CD7B.4060809@marcansoft.com>	<s5heiu3rrqo.wl%tiwai@suse.de>	<4A24E4DB.2050801@marcansoft.com>
	<s5h7hzvroun.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.marcansoft.com (marcansoft.com [80.68.93.119])
	by alsa0.perex.cz (Postfix) with ESMTP id E1C4D244D8
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Jun 2009 11:04:12 +0200 (CEST)
In-Reply-To: <s5h7hzvroun.wl%tiwai@suse.de>
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
> This should be != instead of ==, right?

Yeah. That was one of the last changes; it used to be
if(preset->const_channel_count). Serves me right for not going over the
last version more carefully. Thanks for catching it.

> I applied the patch with slight fix like the above and the reorder of
> the quirk entry together with the addition to HD-Audio-Models.txt now.
Thanks!


-- 
Hector Martin (hector@marcansoft.com)
Public Key: http://www.marcansoft.com/marcan.asc
