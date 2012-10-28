From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] ALSA: core: fix 64-bit
	SNDRV_PCM_IOCTL_STATUS ABI breakage
Date: Sun, 28 Oct 2012 11:45:35 +0100
Message-ID: <508D0CCF.5010408@ladisch.de>
References: <508C3C2F.7070009@ladisch.de> <s5hvcdvc6yl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 25193265CC6
 for <alsa-devel@alsa-project.org>; Sun, 28 Oct 2012 11:45:45 +0100 (CET)
In-Reply-To: <s5hvcdvc6yl.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Clemens Ladisch wrote:
>> Commit 4eeaaeaea (ALSA: core: add hooks for audio timestamps) added the
>> new audio_tstamp field to struct snd_pcm_status.  However, struct
>> timespec requires 64-bit alignment, so the 64-bit compiler would insert
>> 32 bits of padding before this field, which broke SNDRV_PCM_IOCTL_STATUS
>> with error messages like this:
>>
>>   kernel: unknown ioctl = 0x80984120
>>
>> To solve this, insert the padding explicitly so that it can be taken
>> into account when calculating the ABI structure size.
>>
>> Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
>
> Oops, that's bad.  Thanks for catching this.
> I applied it now to for-next branch.
>
> Could you fix alsa-lib code as well?

Oops; done.


Regards,
Clemens
