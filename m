From: Grzegorz Daniluk <g.daniluk@elproma.com.pl>
Subject: Re: [PATCH 1/2] acore: deprecated function in
	wrappers.c
Date: Fri, 25 Feb 2011 16:51:53 +0100
Message-ID: <4D67D019.80807@elproma.com.pl>
References: <4D67CC36.4090004@elproma.com.pl> <s5hk4goqfz7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailmxout.mailmx.agnat.pl (mailmxout4.mailmx.agnat.pl
	[193.239.44.248])
	by alsa0.perex.cz (Postfix) with ESMTP id 9E7B724158
	for <alsa-devel@alsa-project.org>; Fri, 25 Feb 2011 16:51:59 +0100 (CET)
In-Reply-To: <s5hk4goqfz7.wl%tiwai@suse.de>
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

Takashi Iwai wrote:
>
> Erm... this code is defined _only_ for very old kernels just for
> compatible wrapper, so following the rule for new kernels doesn't make
> sense.
>
>
>   
Then something else is wrong, since this code caused the compilation 
error(attached below) when I was doing the cross-compilation for the 
system without PCI for the 2.6.35 kernel (the kernel version was 
correctly recognized during ./configure):

/root/alsa-driver-1.0.24/acore/wrappers.c: In function 
'snd_pci_dev_present':
/root/alsa-driver-1.0.24/acore/wrappers.c:200: error: implicit 
declaration of function 'pci_find_device'
make[3]: *** [/root/alsa-driver-1.0.24/acore/wrappers.o] Error 1

Greg

>> Signed-off-by: Grzegorz Daniluk <g.daniluk@elproma.com.pl>
>> ---
>>
>> diff -uprN a/acore/wrappers.c b/acore/wrappers.c
>> --- a/acore/wrappers.c    2011-01-27 12:09:20.000000000 +0000
>> +++ b/acore/wrappers.c    2011-02-25 13:41:46.000000000 +0000
>> @@ -197,7 +197,7 @@ EXPORT_SYMBOL(snd_compat_devfs_mk_cdev);
>>  int snd_pci_dev_present(const struct pci_device_id *ids)
>>  {
>>      while (ids->vendor || ids->subvendor) {
>> -        if (pci_find_device(ids->vendor, ids->subvendor, NULL))
>> +        if (pci_get_device(ids->vendor, ids->subvendor, NULL))
>>              return 1;
>>          ids++;
>>      }
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
>>     
>
>   
