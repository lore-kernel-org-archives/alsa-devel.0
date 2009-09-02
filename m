From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: Re: No sound with C-Media CMI8788
Date: Wed, 02 Sep 2009 19:23:08 +0300
Message-ID: <4A9E9BEC.4080205@pardus.org.tr>
References: <4A9E2C4C.4010108@pardus.org.tr> <4A9E36F3.2030909@ladisch.de>
	<4A9E63D0.207@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lider.pardus.org.tr (lider.uludag.org.tr [193.140.100.216])
	by alsa0.perex.cz (Postfix) with ESMTP id C7B1724617
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Sep 2009 18:23:15 +0200 (CEST)
In-Reply-To: <4A9E63D0.207@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> I wrote:
>   
>> In the file sound/pci/oxygen/oxygen_lib.c, after the line containing
>> "subdevice = oxygen_read_eeprom(chip, 2);" (about line number 262),
>> please add the line
>>
>>   printk(KERN_INFO "subdevice ID: %04x\n", subdevice);
>>     
>
> I think the cause for your unknown subdevice ID is that your card does
> not have an EEPROM chip.  (This is a feature, it saves you $0.25!)
> In this case, adding the following lines at that place should make
> the driver load correctly:
>
> 	if (subdevice == 0xffff)
> 		subdevice = 0x8788;
>   

Okay, that worked. But I assume that this is a device specific solution
right? If there are other cards without an EEPROM chip, forcing them to
0x8788 shouldn't make sense? How should this be correctly handled?

Thanks!
