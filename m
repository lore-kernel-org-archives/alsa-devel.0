From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: Sample format coversion bug?
Date: Mon, 29 Oct 2007 16:01:12 +0500
Message-ID: <4725BD78.6040709@ums.usu.ru>
References: <4721E932.5090603@ums.usu.ru> <s5hpryyny19.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay4.usu.ru (relay4.usu.ru [194.226.235.39])
	by alsa0.perex.cz (Postfix) with ESMTP id AD69D243A5
	for <alsa-devel@alsa-project.org>; Mon, 29 Oct 2007 12:01:36 +0100 (CET)
Received: from relay4.usu.ru (localhost [127.0.0.1])
	by relay4.usu.ru (PostSystem) with ESMTP id 3B3DA17E98
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Oct 2007 16:04:03 +0500 (YEKT)
Received: from usu2.usu.ru (usu2.usu.ru [194.226.237.16])
	by relay4.usu.ru (PostSystem) with ESMTP id E487917E98
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Oct 2007 16:04:02 +0500 (YEKT)
Received: from usu2.usu.ru (localhost.usu2.usu.ru [127.0.0.1])
	by usu2.usu.ru (Postfix) with ESMTP id B75CFA7EB0
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Oct 2007 16:01:20 +0500 (YEKT)
Received: from ums.usu.ru (ums.usu.ru [194.226.236.116])
	by usu2.usu.ru (Postfix) with ESMTP id 74A57A7E95
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Oct 2007 16:01:15 +0500 (YEKT)
In-Reply-To: <s5hpryyny19.wl%tiwai@suse.de>
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
> Well, apparently something wrong with mmap, then.

Do you mean "something is wrong with the kernel driver" or "plug really 
expects mmap access to the card to be available"?

>   Does the device really support 24bit format?

No, it doesn't - that's the whole point of the test. I expected "plug" 
to guess that the device supports a 16-bit format, record 16-bit samples 
from the hardware, multiply all recorded samples by 256, and return the 
result as 32-bit words (so that the result is a set of valid S24_LE 
samples, even though the least significant byte is always zero).

>   S24_LE isn't 3bytes format but packed
> into the lower 3 bytes in 4 byte frames.
>   

Yes, I know.

-- 
Alexander E. Patrakov
