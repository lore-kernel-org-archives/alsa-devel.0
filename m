From: Stefan Ringel <stefan.ringel@arcor.de>
Subject: Re: HD-Audio device unsuppored (Nvidia G2xx-series GPU
 implemented)
Date: Wed, 16 Dec 2009 22:15:50 +0100
Message-ID: <4B294E06.6060001@arcor.de>
References: <4B238733.2070706@arcor.de>	<s5heimxlrjd.wl%tiwai@suse.de>	<4B262682.60400@arcor.de>	<s5h7hsplqlz.wl%tiwai@suse.de>
	<s5h7hspjvpv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47]) by alsa0.perex.cz (Postfix) with ESMTP id 26AEA244BE
	for <alsa-devel@alsa-project.org>; Wed, 16 Dec 2009 22:15:55 +0100 (CET)
In-Reply-To: <s5h7hspjvpv.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Am 14.12.2009 18:45, schrieb Takashi Iwai:
> At Mon, 14 Dec 2009 12:52:40 +0100,
> I wrote:
>   
>> > 
>>     
>>> > > 
>>> > > one codec-id missed (0x10de000d) and codec-name is "G2xx HDMI".
>>>       
>> > 
>> > OK, I'll update.
>>     
> Below is the updated patch.  This also replaces the PCI ID check using
> the generic hd-audio class check.
>
>
> Takashi
>
>   
Hi Takashi,

I have a theory,

4 codec with 2 channels bundling to one pcm device for 8 channels
uncompressed lpcm audio and compressed audio over first codec.

Actual configuration is 4 separate pcm device.
