From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: RFC: PCM extra attributes
Date: Fri, 19 Jun 2009 13:14:15 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0906191305430.3983@eeebox2.perex-int.cz>
References: <s5hiqiseiwj.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0906191031001.3983@eeebox2.perex-int.cz>
	<s5hbpokegf9.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0906191202590.3983@eeebox2.perex-int.cz>
	<alpine.LNX.2.00.0906191241060.3983@eeebox2.perex-int.cz>
	<s5htz2ch4w6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 07E5210381A
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Jun 2009 13:14:16 +0200 (CEST)
In-Reply-To: <s5htz2ch4w6.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 19 Jun 2009, Takashi Iwai wrote:

> At Fri, 19 Jun 2009 12:45:04 +0200 (CEST),
> Jaroslav Kysela wrote:
>>
>> On Fri, 19 Jun 2009, Jaroslav Kysela wrote:
>>
>>> On Fri, 19 Jun 2009, Takashi Iwai wrote:
>>>
>>>> At Fri, 19 Jun 2009 10:47:30 +0200 (CEST),
>>>> Jaroslav Kysela wrote:
>>>>>
>>>>> On Fri, 19 Jun 2009, Takashi Iwai wrote:
>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> this is yet another topic I'm (currently) working on -- the addition
>>>>>> of PCM ioctls to get/set some extra attributes.  Basically, it adds
>>>>>> two simple ioctls for getting/setting extra attributes to the PCM
>>>>>> substream.  The attribute has a sort of TLV form,
>>>>>>
>>>>>>  /* PCM extra attributes */
>>>>>>  struct snd_pcm_attr {
>>>>>>  	unsigned int type;	/* SNDRC_PCM_TYPE_ATTR_XXX */
>>>>>>  	unsigned int len;	/* GET R: the max elements in value array
>>>>>>  				 *     W: the actually written # elements
>>>>>>  				 * SET R/W: # elements to store
>>>>>>  				 */
>>>>>>  	unsigned int value[0];	/* value(s) to read / write */
>>>>>>  };
>>>>>>
>>>>>> And corresponding two ioctls
>>>>>>  #define SNDRV_PCM_IOCTL_GET_ATTR	_IOWR('A', 0x14, struct snd_pcm_attr)
>>>>>>  #define SNDRV_PCM_IOCTL_SET_ATTR	_IOWR('A', 0x15, struct snd_pcm_attr)
>>>>>
>>>>> I would prefer to implement similar TLV implementation as for the control
>>>>> API. The amount of information for reading (get) will be small, so
>>>>> filtering in this direction is not necessary. Also, common parts of
>>>>> implementation (future merging of more TLVs to compounds) can be shared.
>>>>
>>>> Actually it's a sort of TLV.  You see exactly it in snd_pcm_attr
>>>> struct, no? :)
>>>>
>>>> And, thinking twice after posting (that's a good effect of posting to
>>>> ML, BTW), I feel that using a callback would be a better way, such as
>>>> re-using the existing ops->ioctl with a new cmd tag rather than the
>>>> statically assigned thing.
>>>>
>>>> A similar method like control TLV can be used, too.  However, a
>>>> distinct from the existing control TLV is that this is intended for
>>>> just one type of information while the control TLV is supposed to
>>>> contain everything in a single shot.
>>>>
>>>> That is, this is a query with a key.  In that sense, sharing a small
>>>> amount of control TLV code (about 10 lines) doesn't give a big
>>>> benefit.  In anyways, it's a implementation detail, so one could
>>>> optimize somehow, though...
>>>
>>> I don't mean current implementation. TLVs can be nested. In this case, we
>>> need a set of functions which operates with TLVs (merging). These
>>> functions can be shared. It's also possible to share TLV code in
>>> the user space (search). But it's really implementation detail. We should
>>> focus on ioctl definitions now.
>>>
>>> I would defined 'struct snd_pcm_attr' as 'struct snd_tlv' - it's same as
>>> for control API.
>>>
>>> The control API has:
>>>
>>> SNDRV_CTL_IOCTL_TLV_READ	- read all static information
>>> SNDRV_CTL_IOCTL_TLV_WRITE	- write static information (userspace controls)
>>> SNDRV_CTL_IOCTL_TLV_COMMAND	- change some setup
>>>
>>> So, SNDRV_CTL_IOCTL_TLV_COMMAND == SNDRV_PCM_IOCTL_SET_ATTR in your
>>> proposal.
>>>
>>> SNDRV_CTL_IOCTL_TLV_WRITE is not probably useable unless we have virtual
>>> user-space PCM interface kernel implementation.
>>>
>>> SNDRV_CTL_IOCTL_TLV_READ might make sense for static-only information
>>> which don't change between open()/close() syscalls for given substream.
>>>
>>> SNDRV_PCM_IOCTL_GET_ATTR cannot be mapped at this time. Might be something
>>> like TLV_READONE, TLV_CONFIG, TLV_SETUP, TLV_GET or so - what's better
>>> for COMMAND word, if we agree on common names for all kernel interfaces.
>>
>> BTW: It's also question, if to divide TLVs to static/configuration ones.
>> TLV_READ might just return all TLVs and TLV_READONE filter only one, if
>> user space does not want to obtain all information.
>>
>> I would like to preserve TLV_READ to obtain all TLVs for possible user
>> space enumeration (for example for debugging purposes) rather that do a
>> single query for all possible TLV types.
>
> I disagree with "all-in-on-TLV" strategy.  That makes life much harder.
> Sorry, it's no go.

Sorry, the implementation can be more simple than you think. Imagine just 
a TLV callback in the lowlevel driver and switch/case statement in the 
callback. We can define a special type in kernel that queries for all 
present TLV types (bitmap) and the ioctl TLV_READ implementation can just 
compose results from single queries. So, the code in the lowlevel driver 
will grow only with 4 (or less) lines:

 	case TLV_TYPES:
 		tlv.length = 4;
 		tlv.data[0] = (1<<TLV_CHANNEL_MAP) | (1<<TLV_CONTROL_IDS);
 		return 0;

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
