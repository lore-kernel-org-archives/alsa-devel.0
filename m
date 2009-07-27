From: Mads Kiilerich <mads@kiilerich.com>
Subject: Re: Support for ALC662 on FUJITSU SIEMENS AMILO Li3710
Date: Mon, 27 Jul 2009 12:04:22 +0200
Message-ID: <4A6D7BA6.4020402@kiilerich.com>
References: <4A6B8D20.6070601@kiilerich.com>	<s5hskgjddzq.wl%tiwai@suse.de>	<4A6C94D0.8040705@kiilerich.com>
	<s5hd47m7iv2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.knis.dk (smtp.knis.dk [213.150.52.155])
	by alsa0.perex.cz (Postfix) with ESMTP id 799862437F
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Jul 2009 12:04:25 +0200 (CEST)
In-Reply-To: <s5hd47m7iv2.wl%tiwai@suse.de>
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

Takashi Iwai wrote, On 07/27/2009 08:14 AM:
> At Sun, 26 Jul 2009 19:39:28 +0200,
> Mads Kiilerich wrote:
>    
>> Takashi Iwai wrote, On 07/26/2009 10:50 AM:
>>      
>>> At Sun, 26 Jul 2009 00:54:24 +0200,
>>> Mads Kiilerich wrote:
>>>
>>>        
>>>> On a friends FUJITSU SIEMENS AMILO Li3710 10601011427 sound didn't work
>>>> with kernel-PAE-2.6.29.6-213.fc11.i686
>>>>
>>>>          
>>> How about with the latest alsa-driver snapshot?
>>>       ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-driver-snapshot.tar.gz
>>>
>>>        
>> Thanks.
>>
>> I looked at your sound-2.6.git tree and found no quirk for this card
>> (AFAICS) and assumed that it hadn't been reported and fixed yet.
>>      
> When no quirk is set, the automatic mode is used as default.
> And, it's possible that the automatic mode has been fixed in the
> upstream.  That's why I asked to test with the latest one.
> We should avoid any device-specific quirk as much as possible, but
> rather fix the automatic parser.
>    

Ok, if you think that would be possible. I assumed that it was broken 
beond repair.

>> I am a developer, but for alsa I am a user, no expert, and honestly I
>> don't plan to become one. Can you give a pointer to a description of how
>> can I test the snapshot? On Fedora 11?
>>
>> (http://www.alsa-project.org/main/index.php/Main_Page  has a "How do I
>> install the ALSA driver from source" link, but it just points to the
>> download page without any explanation.)
>>      
> Did you take a look at INSTALL file in alsa-driver?
>    

alsa-driver-snapshot.tar.gz README says "integrated to 2.6+ kernels", so 
I assumed that this somehow only applied to 2.4 - which obviously would 
be very strange.

I missed the big overview. It seems like it would have been helpful to 
me (and the next guy) if something like the following blurb could be 
found somewhere - in README or INSTALL or from the "How do I install the 
ALSA driver from source" link or on 
http://www.alsa-project.org/main/index.php/Driver_Compilation :

"ALSA project develops both Linux kernel drivers as well as support 
libraries and tools for user-space. The kernel drivers are also included 
in vanilla Linux kernels, and usually the stock drivers are fine and 
should be used. It is however also possible to build the alsa-driver 
kernel modules for an existing compiled kernel and replace its drivers, 
for example from alsa-driver-snapshot.tar.gz to get the latest ALSA 
development and fixes. Note that the modules will have to be rebuild 
when a new kernel is installed."


INSTALL is very demotivating for use with distribution kernels. It would 
be helpful if you could add something like:

"On Fedora 11 (with PAE kernels) it works fine, but you need the package 
kernel-PAE-devel of the same version as the running kernel-PAE."

http://www.linlap.com/wiki/configuring+the+audio+and+updating+alsa+for+fedora+10 
might also be helpful.

I assume something similar applies to Suse.

>>> Also, please give alsa-info.sh output.  Run with --no-upload and attach
>>> the generated file.
>>>
>>>        
>> I became aware of that command after having visited my friend. I have
>> output of dmesg and  lshal and lspci - is that sufficient?
>>      
> No

Ok, thanks for the hints to help me understand.

I will try alsa-drivers-snapshot and alsa-info.sh next time I get access 
to that computer - that will probably take more than a month.

/Mads
