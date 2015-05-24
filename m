From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 0/4] ALSA: firewire-lib: code cleanup
Date: Sun, 24 May 2015 20:41:24 +0900
Message-ID: <5561B8E4.6090408@sakamocchi.jp>
References: <1432304474-6533-1-git-send-email-o-takashi@sakamocchi.jp>
 <s5ha8wu32kx.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 37799260668
 for <alsa-devel@alsa-project.org>; Sun, 24 May 2015 13:41:28 +0200 (CEST)
In-Reply-To: <s5ha8wu32kx.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

On May 24 2015 15:35, Takashi Iwai wrote:
> At Fri, 22 May 2015 23:21:10 +0900,
> Takashi Sakamoto wrote:
>>
>> Current implementation includes several macros and functions with improper
>> name, hard-coded numerical value and so on.
>>
>> This patchset is for code cleanup.
>>
>> Takashi Sakamoto (4):
>>   ALSA: firewire-lib: rename local functions for code cleanup
>>   ALSA: firewire-lib: macro arrangement for code cleanup
>>   ALSA: firewire-lib: use dev_err() when detecting incoming streaming
>>     error
>>   ALSA: firewire-lib: use protocol error when detecting wrong value in
>>     CIP header
> 
> Applied all four patches.  Thanks.

Thanks for your reviewing.


Regards

Takashi Sakamoto
