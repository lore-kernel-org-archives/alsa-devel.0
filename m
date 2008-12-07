From: Hector Martin <hector@marcansoft.com>
Subject: Re: HDA: CLFE DAC on ALC889 (Acer Aspire 8930G)
Date: Sun, 07 Dec 2008 17:17:36 +0100
Message-ID: <493BF720.7090100@marcansoft.com>
References: <4935D9E2.1040704@marcansoft.com> <s5hocztpwll.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.marcansoft.com (marcansoft.com [80.68.93.119])
	by alsa0.perex.cz (Postfix) with ESMTP id 1BE002435D
	for <alsa-devel@alsa-project.org>; Sun,  7 Dec 2008 17:17:43 +0100 (CET)
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

Spent another couple hours tinkering, but still nothing. I've dumped out 
all GET requests for the DAC nids and the mixer nids. No difference 
between the working ones and the nonworking ones (other than the 
StreamID). Argh.

I hope this doesn't have anything to do with that stupid undocumented 
"decryption module" that Realtek puts in front of the DACs.

Does Realtek usually handle queries about these things? Maybe I should 
fire them an e-mail and see if they can provide any suggestions.

-- 
Hector Martin (hector@marcansoft.com)
Public Key: http://www.marcansoft.com/marcan.asc
