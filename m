From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [alsa-lib][PATCH 0/5] ctl: support extra
 information for user-defined element set
Date: Thu, 30 Jun 2016 23:22:35 +0900
Message-ID: <57752B2B.6030503@sakamocchi.jp>
References: <1467207783-19792-1-git-send-email-o-takashi@sakamocchi.jp>
 <s5hoa6jrwse.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 715BC2651DB
 for <alsa-devel@alsa-project.org>; Thu, 30 Jun 2016 16:22:40 +0200 (CEST)
In-Reply-To: <s5hoa6jrwse.wl-tiwai@suse.de>
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

On Jun 30 2016 15:54, Takashi Iwai wrote:
> On Wed, 29 Jun 2016 15:42:58 +0200,
> Takashi Sakamoto wrote:
>>
>> Hi,
>>
>> This patchset adds support extra information to the type-specific for
>> user-defined element set. Currently, 'dimension' is such an extra
>> information.
>>
>> In ALSA kernel/userspace interface, information to an element is described
>> in this structure.
>>
>> struct snd_ctl_elem_info {
>>     struct snd_ctl_elem_id id;
>>     unsigned int access;
>>     unsigned int count;
>>     pid_t owner;
>>     union value;
>>
>>     union dimen;
>>     unsigned char reserved[64 - 4 * sizeof(unsigned short)];
>> };
>>
>> This structure includes reserved fields, thus it's possible to add
>> more fields for future extension.
>>
>> Currently, APIs to add user-defined element set don't support such extra
>> fields. Meanwhile, supporting just the dimension field is not good as
>> stable library APIs.
>>
>> This patchset changes prototype of the APIs with 'snd_ctl_elem_info_t'
>> instead of adding more parameters. Callers are expected to fill the parameter
>> with identification information and the extra information.
> 
> Applied, thanks.
> 
> But at the next time, try to avoid changing the API functions you
> added.  They must not be changed once when published, in general.

In general, it's true. But it's in development cycle now. We don't
publish the APIs yet. I think it better to permit to change APIs just
included in the same development period, till releasing. Unless, the
cost to develop this userspace library becomes quite expensive, at least
to me.

In this time, I realized the probability of extension of information
structure, after committing previous patchset, several days after
reading a thread about extension of data structure which Intel
developers proposed[1]. I'm not so clever developer, and you're not so,
too. We should have enough rest to assure the changes.

[1]
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-November/069483.html


Thanks

Takashi Sakamoto
