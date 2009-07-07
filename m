From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: Re: [PATCH] [RFC 3/13] Intel SST driver include headers
Date: Tue, 7 Jul 2009 11:59:37 +0530
Message-ID: <98769532B4BB14429434178695419EAE5BBC22D0@bgsmsx501.gar.corp.intel.com>
References: <1246604545-12854-1-git-send-email-vinod.koul@intel.com>
	<s5hiqia2ftw.wl%tiwai@suse.de>
	<98769532B4BB14429434178695419EAE5BBC220A@bgsmsx501.gar.corp.intel.com>
	<s5hocrxauik.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 07F1B246B6
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jul 2009 08:29:55 +0200 (CEST)
In-Reply-To: <s5hocrxauik.wl%tiwai@suse.de>
Content-Language: en-US
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
Cc: "Koul, Vinod" <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>>
>> >> +/* Firmware Version info */
>> >> +struct snd_sst_fw_version {
>> >> +	__u8 build;	/* build number*/
>> >> +	__u8 minor;	/* minor number*/
>> >> +	__u8 major;	/* major number*/
>> >> +	__u8 type; /* build type*/
>> >> +};
>> >> +
>> >> +/* Port info structure */
>> >> +struct snd_sst_port_info {
>> >> +	__u16 port_type;
>> >
>> >Just wondering -- is there big-endian support?
>> We have not tested this on big-endian, Could you tell us that should
>> we make it endian safe?
>
>When a field is more than one byte, you'd need endian conversion at
>read/write.  I didn't find it thus I suspected it.
So, does it look safe to keep the code as such? We are using the bit field in union only for ease of setting/getting bit values and not for communication.

>
>
>> >> +struct snd_sst_vol {
>> >> +	unsigned int	stream_id;
>> >> +	int		volume;
>> >> +	unsigned long	ramp_duration;
>> >
>> >Are you sure to use long?
>> >Long can be different between 32 and 64bit architectures.
>> We will change it to u32.
>>
>> >
>> >> +struct snd_sst_buff_entry {
>> >> +	union {
>> >> +		void *user;
>> >> +		unsigned int offset;
>> >> +	} buffer;
>> >
>> >Is it OK?
>> >The pointer and int can be different sizes.
>> void* user - is the pointer to the buffer
>> unsigned int offset - is the offset inside the buffer area.
>> Not sure if I understand your comment. Please let us know if there
>> is any issue you see with this structure.
>
>A pointer can be 64bit while offset is always 32bit.
>If they don't have to share the same space, why need to be a union?
I think I will give more clear explanation here before this structure declaration. I know its confusing. Basically we support both mmap and user buffers. When user buffers are passed to the driver then void *user field is used and when mmap buffers are passed to the driver, the offset in the mmap buffer is passed in this structure. Either mmap buffer's offset or user buffer address will be used and not both.

Thanks,
Harsha
