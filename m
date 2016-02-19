From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 0/2] ALSA: oxfw: implement retries for
 scs1x at transaction failure
Date: Fri, 19 Feb 2016 17:51:17 +0900
Message-ID: <56C6D785.3030602@sakamocchi.jp>
References: <1455843350-10156-1-git-send-email-o-takashi@sakamocchi.jp>
 <s5hr3g915cn.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id DE5C3261521
 for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2016 09:51:20 +0100 (CET)
In-Reply-To: <s5hr3g915cn.wl-tiwai@suse.de>
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

On Feb 19 2016 17:17, Takashi Iwai wrote:
> On Fri, 19 Feb 2016 01:55:48 +0100,
> Takashi Sakamoto wrote:
>>
>> Hi,
>>
>> Current ALSA oxfw driver has a TODO to retry IEEE 1394 asynchronous
>> transactions when transaction failure occurs. This patchset is for it.
>> Additionally, this patchset classifies reason of the failure and stop
>> the retries to prevent from endless loop of scheduling work.
>>
>> Regards
>>
>> Takashi Sakamoto (2):
>>    ALSA: oxfw: retry MIDI transferring for scs1x at transaction failure
>>    ALSA: oxfw: discontinue MIDI substream for scs1x at transaction
>>      failure
>
> Your sign-off is missing in both patches.  Please give it explicitly.

Oops. I had the oversight. I usually execute checkpatch.pl before 
posting, but I might have forgot even it in this morning, sorry...


Takashi Sakamoto
o-takashi@sakamocchi.jp
