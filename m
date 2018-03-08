From: Kai Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH 2/2] platform/x86: dell-*: Add interface
 for switchable graphics status query
Date: Thu, 8 Mar 2018 16:20:00 +0800
Message-ID: <3B4D9410-9CD4-410D-A1FB-7EB6CD2C058B@canonical.com>
References: <20180308071207.19850-1-kai.heng.feng@canonical.com>
 <20180308071207.19850-2-kai.heng.feng@canonical.com>
 <d96477ef9ee24fb59d251f29dc0a3f81@ausx13mpc124.AMER.DELL.COM>
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.15\))
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="yes"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 334552673D6
 for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2018 09:20:07 +0100 (CET)
Received: from mail-pf0-f200.google.com ([209.85.192.200])
 by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.76) (envelope-from <kai.heng.feng@canonical.com>)
 id 1etqmV-0000wJ-6H
 for alsa-devel@alsa-project.org; Thu, 08 Mar 2018 08:20:07 +0000
Received: by mail-pf0-f200.google.com with SMTP id w9so2656894pfl.2
 for <alsa-devel@alsa-project.org>; Thu, 08 Mar 2018 00:20:07 -0800 (PST)
In-Reply-To: <d96477ef9ee24fb59d251f29dc0a3f81@ausx13mpc124.AMER.DELL.COM>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mario.Limonciello@dell.com
Cc: mjg59@srcf.ucam.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, platform-driver-x86@vger.kernel.org, pali.rohar@gmail.com, dvhart@infradead.org, andy@infradead.org
List-Id: alsa-devel@alsa-project.org



> On Mar 8, 2018, at 3:34 PM, Mario.Limonciello@dell.com wrote:
>
>> -----Original Message-----
>> From: Kai-Heng Feng [mailto:kai.heng.feng@canonical.com]
>> Sent: Thursday, March 8, 2018 3:12 PM
>> To: mjg59@srcf.ucam.org; pali.rohar@gmail.com; dvhart@infradead.org;
>> andy@infradead.org; Limonciello, Mario <Mario_Limonciello@Dell.com>;
>> tiwai@suse.com
>> Cc: platform-driver-x86@vger.kernel.org; linux-kernel@vger.kernel.org;  
>> alsa-
>> devel@alsa-project.org; Kai-Heng Feng <kai.heng.feng@canonical.com>
>> Subject: [PATCH 2/2] platform/x86: dell-*: Add interface for switchable  
>> graphics
>> status query
>>
>> On some Dell platforms, there's a BIOS option "Enable Switchable
>> Graphics". This information is useful if we want to do different things
>> based on this value, e.g. disable unused audio controller that comes
>> with the discrete graphics.
>
> I was expecting the follow on patch that uses this interface too as part  
> of the
> series. This patch itself however looks like.

I thought it should be easier to separate patch series for different  
subsystems.
But of course I can make them the as one series.

I'll resend a v2 for this.

Kai-Heng

>
> Reviewed-by: Mario Limonciello <mario.limonciello@dell.com>
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>>  drivers/platform/x86/dell-laptop.c | 23 +++++++++++++++++++++++
>>  drivers/platform/x86/dell-smbios.c |  2 ++
>>  drivers/platform/x86/dell-smbios.h |  2 ++
>>  3 files changed, 27 insertions(+)
>>
>> diff --git a/drivers/platform/x86/dell-laptop.c  
>> b/drivers/platform/x86/dell-laptop.c
>> index 8ba820e6c3d0..3f6fc07b8cf2 100644
>> --- a/drivers/platform/x86/dell-laptop.c
>> +++ b/drivers/platform/x86/dell-laptop.c
>> @@ -2116,6 +2116,29 @@ int dell_micmute_led_set(int state)
>>  }
>>  EXPORT_SYMBOL_GPL(dell_micmute_led_set);
>>
>> +int dell_switchable_gfx_enabled(bool *enabled)
>> +{
>> +	struct calling_interface_buffer buffer;
>> +	struct calling_interface_token *token;
>> +	int ret;
>> +
>> +	*enabled = false;
>> +
>> +	token = dell_smbios_find_token(SWITCHABLE_GRAPHICS_ENABLE);
>> +	if (!token)
>> +		return -ENODEV;
>> +
>> +	dell_fill_request(&buffer, token->location, 0, 0, 0);
>> +	ret = dell_send_request(&buffer, CLASS_TOKEN_READ,
>> SELECT_TOKEN_STD);
>> +	if (ret)
>> +		return ret;
>> +
>> +	*enabled = !!buffer.output[1];
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(dell_switchable_gfx_enabled);
>> +
>>  static int __init dell_init(void)
>>  {
>>  	struct calling_interface_token *token;
>> diff --git a/drivers/platform/x86/dell-smbios.c  
>> b/drivers/platform/x86/dell-smbios.c
>> index 8541cde4cb7d..ca38b9d9dcf4 100644
>> --- a/drivers/platform/x86/dell-smbios.c
>> +++ b/drivers/platform/x86/dell-smbios.c
>> @@ -86,6 +86,8 @@ struct token_range {
>>  static struct token_range token_whitelist[] = {
>>  	/* used by userspace: fwupdate */
>>  	{CAP_SYS_ADMIN,	CAPSULE_EN_TOKEN,	CAPSULE_DIS_TOKEN},
>> +	/* can indicate to userspace Switchable Graphics enable status */
>> +	{CAP_SYS_ADMIN,	SWITCHABLE_GRAPHICS_ENABLE,
>> 	SWITCHABLE_GRAPHICS_DISABLE},
>>  	/* can indicate to userspace that WMI is needed */
>>  	{0x0000,	WSMT_EN_TOKEN,		WSMT_DIS_TOKEN}
>>  };
>> diff --git a/drivers/platform/x86/dell-smbios.h  
>> b/drivers/platform/x86/dell-smbios.h
>> index 138d478d9adc..b012d4abd239 100644
>> --- a/drivers/platform/x86/dell-smbios.h
>> +++ b/drivers/platform/x86/dell-smbios.h
>> @@ -37,6 +37,8 @@
>>  #define KBD_LED_AUTO_100_TOKEN	0x02F6
>>  #define GLOBAL_MIC_MUTE_ENABLE	0x0364
>>  #define GLOBAL_MIC_MUTE_DISABLE	0x0365
>> +#define SWITCHABLE_GRAPHICS_ENABLE	0x037A
>> +#define SWITCHABLE_GRAPHICS_DISABLE	0x037B
>>
>>  struct notifier_block;
>>
>> --
>> 2.15.1
