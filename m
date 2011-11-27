From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] [ALSA] usb-audio - Support for Roland GAIA
	SH-01 Synthesizer
Date: Sun, 27 Nov 2011 17:42:29 +0100
Message-ID: <4ED26875.9080108@gmail.com>
References: <1322404484.6913.20.camel@darkside> <4ED25560.40208@gmail.com>
	<1322410227.14597.19.camel@darkside>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id B3358244AB
	for <alsa-devel@alsa-project.org>; Sun, 27 Nov 2011 17:42:37 +0100 (CET)
Received: by bkat8 with SMTP id t8so6358291bka.38
	for <alsa-devel@alsa-project.org>; Sun, 27 Nov 2011 08:42:36 -0800 (PST)
In-Reply-To: <1322410227.14597.19.camel@darkside>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John F Leach <jfleach@jfleach.com>
Cc: tiwai@suse.de, alsa-devel <alsa-devel@alsa-project.org>, clemens <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On 11/27/2011 05:10 PM, John F Leach wrote:
>> Entries in this list should be ordered by the USB vendor/product ID,
>> which is not the case judging from the next block:
>>
>>>  	/* Roland SH-201 */
>>>  	USB_DEVICE(0x0582, 0x00ad),
>>>  	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
>>
>>
>> Otherwise looks good.
>>
>> Thanks for sending patches!
>>
>>
>> Daniel
> 
> Thanks for the feedback Daniel; I submitted a revised patch with the
> correct list order and fixed the wrapped line for the driver_info.

Nice. The only thing worth mentioning here is that your "change log"
shouldn't be placed in the mail subject (which will be the patch
headline eventually). Next time, just put things you don't want to be
part of the actual patch itself underneath the "---" line below the
diffstat.

But I think this time, Takashi can fix it up when commiting? :)


Daniel
