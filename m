From: Jussi Laako <jussi@sonarnerd.net>
Subject: Re: [PATCH] ALSA: usb-audio: Expose sample resolution
 through proc interface
Date: Mon, 18 Feb 2019 11:23:47 +0200
Message-ID: <9803bae5-1a8a-6532-ad74-6818ffacaa94@sonarnerd.net>
References: <20190217221721.6396-1-jussi@sonarnerd.net>
 <s5hk1hx8p68.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [194.142.149.154])
 by alsa0.perex.cz (Postfix) with ESMTP id D647D266FA9
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2019 10:23:48 +0100 (CET)
In-Reply-To: <s5hk1hx8p68.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 2/18/19 10:40 AM, Takashi Iwai wrote:
> 
> The code change looks but, just some minor issues:
> 
> Please use tabs.  checkpatch will catch such a problem, so please run
> it at the next time before submission.
> 
> I applied the patch with these fixed locally.

OK, thanks! Will do!

Ultimately I would like to get the sample resolution for example through 
snd_pcm_hw_params_get_sbits(), but I didn't find a nice way to get this 
information to the ALSA API without lot of changes all over the place, 
or alternatively introducing a new sample format which I think is not a 
good idea in this case.

I can parse the stream info from proc though, so it is not so much issue.


Best regards,

	- Jussi
