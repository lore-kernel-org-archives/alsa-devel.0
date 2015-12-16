From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 0/5] ALSA: oxfw: code refactoring for
 model-dependent quirks
Date: Wed, 16 Dec 2015 20:03:16 +0900
Message-ID: <567144F4.7080603@sakamocchi.jp>
References: <1450191381-16352-1-git-send-email-o-takashi@sakamocchi.jp>
 <s5hy4cug4rn.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 6173F265327
 for <alsa-devel@alsa-project.org>; Wed, 16 Dec 2015 12:03:21 +0100 (CET)
In-Reply-To: <s5hy4cug4rn.wl-tiwai@suse.de>
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

On Dec 16 2015 17:46, Takashi Iwai wrote:
> On Tue, 15 Dec 2015 15:56:16 +0100,
> Takashi Sakamoto wrote:
>>
>> Hi,
>>
>> ALSA oxfw driver has got some patches to expand its functionalities. As a
>> result, current code includes some inefficiencies and confusions.
>>
>> This patchset is a code refactoring about model-dependent quirks. This
>> patchset is a part of my previous RFCv2 (patch 01-05) and a preparation for
>> the rest of patches:
>>
>> [alsa-devel] [RFC][PATCH 00/17 v2] ALSA: oxfw: refactoring and merging scs1x module
>> http://mailman.alsa-project.org/pipermail/alsa-devel/2015-December/101558.html
>>
>> Takashi Sakamoto (5):
>>   ALSA: oxfw: rename a file for control elements so that it's for
>>     model-specific
>>   ALSA: oxfw: rename local functions for control elements so that they
>>     represent as local
>>   ALSA: oxfw: change function prototype for AV/C Audio Subunit command
>>   ALSA: oxfw: reuse driver entry to detect quirk
>>   ALSA: oxfw: gather model-dependent conditions to a function
> 
> Applied all five patches.  Thanks.

Thanks.

If possible, would you please apply fireworks patches on
'topic/firewire-update' to 'for-next' branch, too?


Regards

Takashi Sakamoto
