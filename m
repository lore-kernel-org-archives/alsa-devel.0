From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH] intel8x0m: enable AMD8111 modem
Date: Thu, 19 May 2011 19:04:16 +0400
Message-ID: <BANLkTikCyH1_8R-1qRXpDVReb9fQRW2vYA@mail.gmail.com>
References: <1305816507-9227-1-git-send-email-dbaryshkov@gmail.com>
	<s5h39kavj2a.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6287D103A3B
	for <alsa-devel@alsa-project.org>;
	Thu, 19 May 2011 17:04:18 +0200 (CEST)
Received: by vxi40 with SMTP id 40so2250834vxi.38
	for <alsa-devel@alsa-project.org>; Thu, 19 May 2011 08:04:16 -0700 (PDT)
In-Reply-To: <s5h39kavj2a.wl%tiwai@suse.de>
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

Hello,

On 5/19/11, Takashi Iwai <tiwai@suse.de> wrote:
> At Thu, 19 May 2011 18:48:27 +0400,
> Dmitry Eremin-Solenikov wrote:
>>
>> AMD 8111 southbridges contain a controller for MC'97 modem. Enable support
>> for this controller in intel8x0m driver.
>
> Just to be sure -- did you test whether it actually works?

I was able to read controller registers, read the data. No codec
connected (yet).
Even if this is not 'a prove' to commit the enable, we should change
device_id present
in the file, according to datasheet.

>
>
> thanks,
>
> Takashi
>
>>
>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>> ---
>>  sound/pci/intel8x0m.c |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/pci/intel8x0m.c b/sound/pci/intel8x0m.c
>> index 27709f0..f3353b4 100644
>> --- a/sound/pci/intel8x0m.c
>> +++ b/sound/pci/intel8x0m.c
>> @@ -235,8 +235,8 @@ static DEFINE_PCI_DEVICE_TABLE(snd_intel8x0m_ids) = {
>>  	{ PCI_VDEVICE(NVIDIA, 0x0069), DEVICE_NFORCE }, /* NFORCE2 */
>>  	{ PCI_VDEVICE(NVIDIA, 0x0089), DEVICE_NFORCE }, /* NFORCE2s */
>>  	{ PCI_VDEVICE(NVIDIA, 0x00d9), DEVICE_NFORCE }, /* NFORCE3 */
>> +	{ PCI_VDEVICE(AMD, 0x746e), DEVICE_INTEL },	/* AMD8111 */
>>  #if 0
>> -	{ PCI_VDEVICE(AMD, 0x746d), DEVICE_INTEL },	/* AMD8111 */
>>  	{ PCI_VDEVICE(AL, 0x5455), DEVICE_ALI },   /* Ali5455 */
>>  #endif
>>  	{ 0, }
>> @@ -1261,9 +1261,9 @@ static struct shortname_table {
>>  	{ PCI_DEVICE_ID_NVIDIA_MCP2_MODEM, "NVidia nForce2" },
>>  	{ PCI_DEVICE_ID_NVIDIA_MCP2S_MODEM, "NVidia nForce2s" },
>>  	{ PCI_DEVICE_ID_NVIDIA_MCP3_MODEM, "NVidia nForce3" },
>> +	{ 0x746e, "AMD AMD8111" },
>>  #if 0
>>  	{ 0x5455, "ALi M5455" },
>> -	{ 0x746d, "AMD AMD8111" },
>>  #endif
>>  	{ 0 },
>>  };
>> --
>> 1.7.4.4
>>
>


-- 
With best wishes
Dmitry
