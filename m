From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: Re: [PATCH] [RFC 3/13] Intel SST driver include headers
Date: Tue, 7 Jul 2009 11:33:23 +0530
Message-ID: <98769532B4BB14429434178695419EAE5BBC220A@bgsmsx501.gar.corp.intel.com>
References: <1246604545-12854-1-git-send-email-vinod.koul@intel.com>
	<s5hiqia2ftw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 46B2E246A3
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jul 2009 08:05:21 +0200 (CEST)
In-Reply-To: <s5hiqia2ftw.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, "Koul, Vinod" <vinod.koul@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>> +/* Firmware Version info */
>> +struct snd_sst_fw_version {
>> +	__u8 build;	/* build number*/
>> +	__u8 minor;	/* minor number*/
>> +	__u8 major;	/* major number*/
>> +	__u8 type; /* build type*/
>> +};
>> +
>> +/* Port info structure */
>> +struct snd_sst_port_info {
>> +	__u16 port_type;
>
>Just wondering -- is there big-endian support?
We have not tested this on big-endian, Could you tell us that should we make it endian safe?

>
>> +struct snd_sst_vol {
>> +	unsigned int	stream_id;
>> +	int		volume;
>> +	unsigned long	ramp_duration;
>
>Are you sure to use long?
>Long can be different between 32 and 64bit architectures.
We will change it to u32.

>
>> +struct snd_sst_buff_entry {
>> +	union {
>> +		void *user;
>> +		unsigned int offset;
>> +	} buffer;
>
>Is it OK?
>The pointer and int can be different sizes.
void* user - is the pointer to the buffer
unsigned int offset - is the offset inside the buffer area.
Not sure if I understand your comment. Please let us know if there is any issue you see with this structure.

Thanks,
Harsha
