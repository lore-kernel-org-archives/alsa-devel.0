From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 0/2 v2] ALSA: oxfw: implement retries for
 scs1x at transaction failure
Date: Thu, 25 Feb 2016 11:00:59 +0900
Message-ID: <56CE605B.2000706@sakamocchi.jp>
References: <1456273593-6082-1-git-send-email-o-takashi@sakamocchi.jp>
 <s5hbn76dsxi.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id D014C261687
 for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2016 03:01:02 +0100 (CET)
In-Reply-To: <s5hbn76dsxi.wl-tiwai@suse.de>
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

On Feb 25 2016 00:33, Takashi Iwai wrote:
> On Wed, 24 Feb 2016 01:26:31 +0100,
> Takashi Sakamoto wrote:
>>
>> Hi,
>>
>> This patchset updates my former post below. Changes are just adding my sign
>> (I forgot it...) and improvements of commit messages.
>>
>> [alsa-devel] [PATCH 0/2] ALSA: oxfw: implement retries for scs1x at transaction failure
>> http://mailman.alsa-project.org/pipermail/alsa-devel/2016-February/104579.html
>>
>> In thread of the post, I got some comments about work to extend ALSA
>> rawmidi core. I've investigated it in a few days ago and realized that it
>> may not so light work, mainly because of a lack of unified state
>> management[0].
>>
>> In this development cycle, I'd like to give it up and use my time for the
>> other work within my plan for the cycle. Please just apply these two patches.
>>
>> [0] In short, the state management is understandable for developers who
>> can understand it, and I'm not.
>>
>> Regards
>>
>> Takashi Sakamoto (2):
>>    ALSA: oxfw: retry MIDI transferring for scs1x at transaction failure
>>    ALSA: oxfw: discontinue MIDI substream for scs1x at transaction
>>      failure
>
> Applied both now.  Thanks.

Thanks.

ALSA rawmidi core handles substreams for both directions, therefore 
state management may not so simple as we expected (at least, for driver 
based on packet streaming such as IEC 61883-1/6, there're more items to 
be considered. So as USB MIDI Device class, too, I think). I'd like to 
schedule the work to next developing cycle for Linux 4.7 or later.


Regards

Takashi Sakamoto
