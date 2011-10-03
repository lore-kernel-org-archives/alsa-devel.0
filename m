From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH resend] ALSA: firewire-speakers: fix locking
Date: Mon, 03 Oct 2011 23:28:17 +0200
Message-ID: <4E8A28F1.8070009@ladisch.de>
References: <20110827164528.1b3a2fc0@stein>	<20111001155746.53e902b9@stein>	<s5hehyusdhf.wl%tiwai@suse.de>
	<20111003104601.4facd6c7@stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 310A2103935
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Oct 2011 23:28:48 +0200 (CEST)
In-Reply-To: <20111003104601.4facd6c7@stein>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Stefan Richter wrote:
> On Oct 03 Takashi Iwai wrote:
>> Stefan Richter wrote:
>>> There is a lock inversion between fwspk->mutex and pcm->open_mutex
>>> reported by lockdep when fwspk_hw_free is called.
>>
>> We should put cc to stable kernel, right?
>
> I am not sure.  While I could reproduce the lockdep report reliably at
> device unplugs, I never encountered a deadlock.

The reported scenario requires that the same PCM device is freed twice
at the same time, which is prevented by the file reference counting.

Going through the entire dependency chain would require the device being
unplugged, being independently close()d, and a ioctl being called with
a swapped-out data buffer all happening at the same time.

This doesn't look like an actual problem.


Regards,
Clemens
