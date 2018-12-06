From: shuah <shuah@kernel.org>
Subject: Re: [RFC PATCH v8 3/4] media: media.h: Enable ALSA MEDIA_INTF_T*
 interface types
Date: Thu, 6 Dec 2018 08:29:14 -0700
Message-ID: <bfab725e-f283-cb71-f1df-d6444b7b81f7@kernel.org>
References: <cover.1541118238.git.shuah@kernel.org>
 <0f47952fd84fd275646e3c9a18e208ced08dd6bb.1541109584.git.shuah@kernel.org>
 <76e1a986-fb47-869d-ee7e-8c9b919718cb@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <76e1a986-fb47-869d-ee7e-8c9b919718cb@xs4all.nl>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Hans Verkuil <hverkuil@xs4all.nl>, mchehab@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, shuah <shuah@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Hans,

On 11/20/18 4:22 AM, Hans Verkuil wrote:
> On 11/02/2018 01:31 AM, shuah@kernel.org wrote:
>> From: Shuah Khan <shuah@kernel.org>
>>
>> Move ALSA MEDIA_INTF_T* interface types back into __KERNEL__ scope
>> to get ready for adding ALSA support to the media controller.
>>
>> Signed-off-by: Shuah Khan <shuah@kernel.org>
>> ---
>>   include/uapi/linux/media.h | 25 ++++++++++---------------
>>   1 file changed, 10 insertions(+), 15 deletions(-)
>>
>> diff --git a/include/uapi/linux/media.h b/include/uapi/linux/media.h
>> index 36f76e777ef9..07be07263597 100644
>> --- a/include/uapi/linux/media.h
>> +++ b/include/uapi/linux/media.h
>> @@ -262,6 +262,16 @@ struct media_links_enum {
>>   #define MEDIA_INTF_T_V4L_SWRADIO		(MEDIA_INTF_T_V4L_BASE + 4)
>>   #define MEDIA_INTF_T_V4L_TOUCH			(MEDIA_INTF_T_V4L_BASE + 5)
>>   
>> +#define MEDIA_INTF_T_ALSA_BASE			0x00000300
>> +#define MEDIA_INTF_T_ALSA_PCM_CAPTURE		(MEDIA_INTF_T_ALSA_BASE)
>> +#define MEDIA_INTF_T_ALSA_PCM_PLAYBACK		(MEDIA_INTF_T_ALSA_BASE + 1)
>> +#define MEDIA_INTF_T_ALSA_CONTROL		(MEDIA_INTF_T_ALSA_BASE + 2)
>> +#define MEDIA_INTF_T_ALSA_COMPRESS		(MEDIA_INTF_T_ALSA_BASE + 3)
>> +#define MEDIA_INTF_T_ALSA_RAWMIDI		(MEDIA_INTF_T_ALSA_BASE + 4)
>> +#define MEDIA_INTF_T_ALSA_HWDEP			(MEDIA_INTF_T_ALSA_BASE + 5)
>> +#define MEDIA_INTF_T_ALSA_SEQUENCER		(MEDIA_INTF_T_ALSA_BASE + 6)
>> +#define MEDIA_INTF_T_ALSA_TIMER			(MEDIA_INTF_T_ALSA_BASE + 7)
>> +
> 
> I would only enable those defines that you need for the next patch.
> 

Good plan. I fixed this to move just the ones I need for this work.

thanks,
-- Shuah
