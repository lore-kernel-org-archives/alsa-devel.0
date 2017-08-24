From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC][PATCH 0/3] ALSA: control: delegate TLV
 eventing to each driver
Date: Thu, 24 Aug 2017 10:50:58 +0900
Message-ID: <09faa6d2-d652-cd96-ebfa-d3b6bfccfdb1@sakamocchi.jp>
References: <20170821234222.25556-1-o-takashi@sakamocchi.jp>
 <s5hziast8vd.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 6882E266BED
 for <alsa-devel@alsa-project.org>; Thu, 24 Aug 2017 03:51:03 +0200 (CEST)
In-Reply-To: <s5hziast8vd.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, fulup.arfoll@iot.bzh
List-Id: alsa-devel@alsa-project.org

Hi,

On Aug 22 2017 15:27, Takashi Iwai wrote:
> On Tue, 22 Aug 2017 01:42:19 +0200,
> Takashi Sakamoto wrote:
>>
>> Hi,
>>
>> This patchset is to avoid a trouble on ALSA control core, kernel API of
>> ALSA control component and ALSA control interface/protocol to handle TLV
>> operations from user space.
>>
>> In a design of ALSA control core, a set of elements is represented by
>> 'struct snd_kcontrol' to share common attributes. The set of elements
>> shares TLV (Type-Length-Value) data, too.
>>
>> On the other hand, in ALSA control interface/protocol for applications,
>> a TLV operation is committed to an element. Totally, the operation can
>> have sub-effect to the other elements in the set. For example, TLV_WRITE
>> operation is expected to change TLV data, which returns to applications.
>> Applications attempt to change the TLV data per element, but in the above
>> design, they can effect to elements in the same set.
>>
>> As a default, ALSA control core has no implementation except for TLV_READ
>> operation. Thus, the above design looks to have no issue. However, in
>> kernel APIs of ALSA control component, developers can program a handler
>> for any request of the TLV operation. Therefore, for elements in a set
>> which has the handler, applications can commit TLV_WRITE and TLV_COMMAND
>> requests.
>>
>> For the above scenario, ALSA control core assist notification. When the
>> handler returns positive value, the core queueing an event for a requested
>> element. However, this includes design defects that the event is not
>> queued for the other element in a set. Actually, developers can program
>> the handlers to keep per-element TLV data, but it depends on each driver.
>>
>> In this patchset, I attempts to solve the above issue, by delegating the
>> event notification to each driver of ALSA control component.
>>
>> Additionally, this patchset includes a solution against an issue in below
>> message thread:
>>
>> [alsa-devel] snd_ctl_add_enumerated_elem_set and TLV
>> http://mailman.alsa-project.org/pipermail/alsa-devel/2017-July/123364.html
>>
>>
>> Takashi Sakamoto (3):
>>    ALSA: control: delegate TLV eventing to each driver
>>    ALSA: control: queue TLV event for all of elements in an user-defined
>>      set
>>    ALSA: control: disable TLV data at initial state of user-defined
>>      element set
> 
> The patch set looks OK to me through a quick glance.
> If it's confirmed to work with your tests, feel free to resubmit as
> the patches for merge.

Thanks for your positive comment. After re-investigating again and I 
posted it with a patch for test program in alsa-lib.


Takashi Sakamoto
