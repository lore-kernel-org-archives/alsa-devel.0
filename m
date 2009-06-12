From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: plug:dmix slows playback
Date: Fri, 12 Jun 2009 12:43:34 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0906121240510.13028@eeebox2.perex-int.cz>
References: <000001c9eb46$24a60d30$6df22790$@langstaff@pebblebay.com>
	<alpine.LNX.2.00.0906121213520.13028@eeebox2.perex-int.cz>
	<000101c9eb48$8e0a9280$aa1fb780$@langstaff@pebblebay.com>
	<alpine.LNX.2.00.0906121229350.13028@eeebox2.perex-int.cz>
	<000501c9eb49$d2458080$76d08180$@langstaff@pebblebay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id CD32D24689
	for <alsa-devel@alsa-project.org>;
	Fri, 12 Jun 2009 12:43:35 +0200 (CEST)
In-Reply-To: <000501c9eb49$d2458080$76d08180$@langstaff@pebblebay.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Steve Langstaff <steve.langstaff@pebblebay.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 12 Jun 2009, Steve Langstaff wrote:

>> From: alsa-devel-bounces@alsa-project.org [mailto:alsa-devel-
>> bounces@alsa-project.org] On Behalf Of Jaroslav Kysela
>
>> On Fri, 12 Jun 2009, Steve Langstaff wrote:
>
>>> Slave: Hardware PCM card 0 'LM4549' device 0 subdevice 0
>>
>>>  msbits       : 16
>>
>> If I remember correctly, this value was 32 in your dmix setup.
>> Could you try command:
>>
>>  	aplay -D"plug:'dmix:FORMAT=S16_LE'" <filename>
>
> Yes, that works fine - is there something wrong with my configuration do you
> think?

It seems that 32-bit samples are not handled correctly in driver. 
What's your hardware? Output from alsa-info.sh script might be helpful for 
identification.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
