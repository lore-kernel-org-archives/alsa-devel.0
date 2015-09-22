From: Luis de Bethencourt <luisbg@osg.samsung.com>
Subject: Re: [PATCH] sound: oss: ad1848: Fix returned errno code in ad1848_init()
Date: Tue, 22 Sep 2015 20:11:13 +0100
Message-ID: <5601A7D1.3010008@osg.samsung.com>
References: <1442936257-8988-1-git-send-email-luisbg@osg.samsung.com> <20150922164642.GA14353@sudip-pc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150922164642.GA14353@sudip-pc>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: linux-kernel@vger.kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 22/09/15 17:46, Sudip Mukherjee wrote:
> On Tue, Sep 22, 2015 at 04:37:37PM +0100, Luis de Bethencourt wrote:
>> The driver is using -1 instead of the -ENOMEM defined macro to specify
>> that a buffer allocation failed. Since the error number is propagated,
>> the caller will get a -EPERM which is the wrong error condition.
>>
>> Smatch tool warning:
>> ad1848_init() warn: returning -1 instead of -ENOMEM is sloppy
>>
>> Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
>> ---
>>  sound/oss/ad1848.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/sound/oss/ad1848.c b/sound/oss/ad1848.c
>> index 10c8de1..6b35656 100644
>> --- a/sound/oss/ad1848.c
>> +++ b/sound/oss/ad1848.c
>> @@ -1992,7 +1992,7 @@ int ad1848_init (char *name, struct resource *ports, int irq, int dma_playback,
>>  	portc = kmalloc(sizeof(ad1848_port_info), GFP_KERNEL);
>>  	if(portc==NULL) {
>>  		release_region(devc->base, 4);
>> -		return -1;
>> +		return -ENOMEM;
>  The return value of ad1848_init is stored in hw_config->slots[0].
> And in sound/oss/pss.c hw_config->slots[0] is checked like: 
> if (hw_config->slots[0] != -1)
> 
> So, you just changed the functionality of the driver.
> 
> regards
> sudip
> 

Hi Sudip,

True! I missed that.

This change will mean the block for 'if (hw_config->slots[0] != -1)' will
run and it shouldn't.

In ad1848.c:1998 sound_install_audiodrv() can return -ENOMEM as well, but this
is turned into -1 also. All errno codes are ignored in sound/oss/pss.c, not
worth it.

I'm withdrawing my patch. Sorry for this.

Is there any other way to silence the smatch warning?

Thanks for the review,
Luis
