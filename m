From: Mads Kiilerich <mads@kiilerich.com>
Subject: Re: Support for ALC662 on FUJITSU SIEMENS AMILO Li3710
Date: Sun, 26 Jul 2009 19:39:28 +0200
Message-ID: <4A6C94D0.8040705@kiilerich.com>
References: <4A6B8D20.6070601@kiilerich.com> <s5hskgjddzq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.knis.dk (smtp.knis.dk [213.150.52.155])
	by alsa0.perex.cz (Postfix) with ESMTP id D5F1224C4B
	for <alsa-devel@alsa-project.org>;
	Sun, 26 Jul 2009 19:39:31 +0200 (CEST)
In-Reply-To: <s5hskgjddzq.wl%tiwai@suse.de>
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

Takashi Iwai wrote, On 07/26/2009 10:50 AM:
> At Sun, 26 Jul 2009 00:54:24 +0200,
> Mads Kiilerich wrote:
>    
>> On a friends FUJITSU SIEMENS AMILO Li3710 10601011427 sound didn't work
>> with kernel-PAE-2.6.29.6-213.fc11.i686
>>      
> How about with the latest alsa-driver snapshot?
>      ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-driver-snapshot.tar.gz
>    

Thanks.

I looked at your sound-2.6.git tree and found no quirk for this card 
(AFAICS) and assumed that it hadn't been reported and fixed yet. I 
assume that that tree is pretty close to alsa-driver-snapshot?

I am a developer, but for alsa I am a user, no expert, and honestly I 
don't plan to become one. Can you give a pointer to a description of how 
can I test the snapshot? On Fedora 11?

(http://www.alsa-project.org/main/index.php/Main_Page has a "How do I 
install the ALSA driver from source" link, but it just points to the 
download page without any explanation.)

> Also, please give alsa-info.sh output.  Run with --no-upload and attach
> the generated file.
>    

I became aware of that command after having visited my friend. I have 
output of dmesg and  lshal and lspci - is that sufficient?

/Mads
