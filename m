From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 02/29] ALSA: dice: Move file to its
	own	directory
Date: Wed, 19 Nov 2014 00:29:29 +0900
Message-ID: <546B65D9.9090901@sakamocchi.jp>
References: <1414328610-12729-1-git-send-email-o-takashi@sakamocchi.jp>
 <1414328610-12729-3-git-send-email-o-takashi@sakamocchi.jp>
 <546B4237.30706@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 324EB2604B0
 for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2014 16:29:33 +0100 (CET)
In-Reply-To: <546B4237.30706@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Nov 18 2014 21:57, Clemens Ladisch wrote:
> Takashi Sakamoto wrote:
>> In followed commits, dice driver is split into several files. For easily
>> managing these files, this commit adds subdirectory and move file into
>> the directory.
> 
>> -// TODO: rx index
>> +/* TODO: rx index */
> 
>> -		event.dice_notification.type = SNDRV_FIREWIRE_EVENT_DICE_NOTIFICATION;
>> +		event.dice_notification.type =
>> +					SNDRV_FIREWIRE_EVENT_DICE_NOTIFICATION;
> 
>> -		count = min(count, (long)sizeof(event.dice_notification));
>> +		count = min_t(long, count, sizeof(event.dice_notification));
> 
>> -static void dice_bus_reset(struct fw_unit *unit)
>> +static void dice_update(struct fw_unit *unit)
> 
> Please mention these changes in the commit message, or move them into
> a separate patch.

OK. The breaking-line and replacing with min_t is due to checkpatch.pl.
The renaming is to apply the same way which I use on bebob/fireworks but
is unnecessary.

As you mentioned, it's better to add a separete patch as a fix for them.


Thanks

Takashi Sakamoto
