From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: Re: [PATCH] [RFC 3/13] Intel SST driver include headers
Date: Tue, 7 Jul 2009 12:21:00 +0530
Message-ID: <98769532B4BB14429434178695419EAE5BBC2366@bgsmsx501.gar.corp.intel.com>
References: <1246604545-12854-1-git-send-email-vinod.koul@intel.com>
	<s5hiqia2ftw.wl%tiwai@suse.de>
	<98769532B4BB14429434178695419EAE5BBC220A@bgsmsx501.gar.corp.intel.com>
	<s5hocrxauik.wl%tiwai@suse.de>
	<98769532B4BB14429434178695419EAE5BBC22D0@bgsmsx501.gar.corp.intel.com>
	<s5hhbxpat2z.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 5E8341038D5
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jul 2009 08:51:34 +0200 (CEST)
In-Reply-To: <s5hhbxpat2z.wl%tiwai@suse.de>
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
>> >>
>> >> >> +/* Firmware Version info */
>> >> >> +struct snd_sst_fw_version {
>> >> >> +	__u8 build;	/* build number*/
>> >> >> +	__u8 minor;	/* minor number*/
>> >> >> +	__u8 major;	/* major number*/
>> >> >> +	__u8 type; /* build type*/
>> >> >> +};
>> >> >> +
>> >> >> +/* Port info structure */
>> >> >> +struct snd_sst_port_info {
>> >> >> +	__u16 port_type;
>> >> >
>> >> >Just wondering -- is there big-endian support?
>> >> We have not tested this on big-endian, Could you tell us that should
>> >> we make it endian safe?
>> >
>> >When a field is more than one byte, you'd need endian conversion at
>> >read/write.  I didn't find it thus I suspected it.
>> So, does it look safe to keep the code as such?
>
>Unlikely...
>
>> We are using the bit
>> field in union only for ease of setting/getting bit values and not
>> for communication.
>
>What I meant is the data used for the communication.  Not the
>communication method itself.  Here the communication includes the
>firmware data, too.
>
>If the data is created by the driver locally and used only inside the
>driver, then it's fine.  Otherwise, you shouldn't use bit fields.


Yes. This is the case. The data is generated internally to the driver and used inside the driver only. When the data is communicated to the firmware, only the 32bit register is passed and the bit fields are not used.

Thanks,
Harsha
