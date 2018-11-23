From: Meelis Roos <mroos@linux.ee>
Subject: Re: Undefined behaviour in ac97_codec.c - shift
 exponent 68 is too large for 32-bit type 'int'
Date: Fri, 23 Nov 2018 19:02:06 +0200
Message-ID: <c946a97c-f115-0413-571f-3ab84543dc6e@linux.ee>
References: <0f267366-2ecc-9a53-a5fb-d7bf29da99b4@linux.ee>
 <s5hmupz3kyt.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.cyber.ee (mx2.cyber.ee [193.40.6.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 825CA2678DF
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2018 18:02:09 +0100 (CET)
In-Reply-To: <s5hmupz3kyt.wl-tiwai@suse.de>
Content-Language: et-EE
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

>> [   19.668078] UBSAN: Undefined behaviour in sound/pci/ac97/ac97_codec.c:836:7
>> [   19.668268] shift exponent 68 is too large for 32-bit type 'int'
> 
> Wow, this is an old bug.
> 
> The patch below should fix the problem.

Yes, it does - thank you!

I also found another machine (with SiS ac97 audio) that gave the same warning and the
warning is gone there too.

Can not test actual audio since both machines are remote for now, but aplay thinks it
plays WAV files fine.

Tested-by: Meelis Roos <mroos@linux.ee>

-- 
Meelis Roos <mroos@linux.ee>
