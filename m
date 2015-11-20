From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 4/9] ALSA: oxfw: apply model-specific
 functionality framework to firewire-speakers
Date: Fri, 20 Nov 2015 11:28:39 +0900
Message-ID: <564E8557.3040205@sakamocchi.jp>
References: <1447579565-4615-1-git-send-email-o-takashi@sakamocchi.jp>
 <1447579565-4615-5-git-send-email-o-takashi@sakamocchi.jp>
 <s5h8u5ve6ik.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D83D2614F4
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2015 03:28:43 +0100 (CET)
In-Reply-To: <s5h8u5ve6ik.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi,

On Nov 18 2015 23:17, Takashi Iwai wrote:
> On Sun, 15 Nov 2015 10:26:00 +0100,
> Takashi Sakamoto wrote:
>> -	err = spkr_volume_command(oxfw, &oxfw->volume_min,
>> +	if (strcmp(oxfw->card->driver, "FireWave") == 0) {
>> +		spkr->mixer_channels = 6;
>> +		spkr->mute_fb_id = 0x01;
>> +		spkr->volume_fb_id = 0x02;
>> +	}
>> +	if (strcmp(oxfw->card->driver, "FWSpeakers") == 0) {
>> +		spkr->mixer_channels = 1;
>> +		spkr->mute_fb_id = 0x01;
>> +		spkr->volume_fb_id = 0x01;
>> +	}
> 
> What's the merit of such explicit individual conditional over the
> constant table in the current implementation?  The latter is more
> error-prone and simpler in general.

I'm also concerned about it. Yes, the usage of 'struct
ieee1394_device_id.driver_data' is nicer than thse condition statements,
in this point.

My intension of a part of this patch series is to enclose
model-dependent parameters inner model-dependent files, instead of
adding module-public structure. This idea, itself, is not so bad, I think.

There may be better ways to detect models and assign to structure but I
don't still find it.


Thanks

Takashi Sakamoto
