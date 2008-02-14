From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Re: Maya44 revised patch
Date: Thu, 14 Feb 2008 13:29:00 +0100
Message-ID: <47B4340C.1030106@insite.cz>
References: <47B37EE7.5000905@lightshed.de> <s5hpruzycbo.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.insite.cz (cable.insite.cz [84.242.84.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 23A4F2456B
	for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2008 13:29:11 +0100 (CET)
In-Reply-To: <s5hpruzycbo.wl%tiwai@suse.de>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Rainer Zimmermann <mail@lightshed.de>
List-Id: alsa-devel@alsa-project.org

Hi,

The constraint comes from the codec, the chip itself can handle 192kHz, 
e.g. the 192kHz SPDIF input works fine. Actually more of the ice1724 
cards have this limit. If this issue is solved in a general way, it 
could be implemented to other cards with 192kHz DACs/96kHz ADCs too.

Pavel

Takashi Iwai wrote:
> At Thu, 14 Feb 2008 00:36:07 +0100,
> Rainer Zimmermann wrote:
>>
>> This is the revised version of the ESI Maya44 patch.
>> changes are mainly coding style, some cleanups and using a patch file for 
>> ice1724.c .
>>
>> The added code now (mostly) passes checkpatch.pl, except for some "#if 0"'s 
>> which I'd leave in for the development phase.
>>
>> Also, I changed the rate setting logic, which (for now) allows all rates up to 
>> 192kHz even for capturing. As capturing actually only supports 96 kHz, while 
>> capturing & playback rates are linked, this is not really ok. I'd appreciate 
>> suggestions about how this could be handled properly, while still supporting 
>> playback up to 192 kHz...
> 
> Does the 96kHz constraint come from ice172x chip or the codec chip?
> (I have to recheck the datasheet...)
> 
> Anyway, we can limit this in a scenario like below:
> - disallow the rate over 96kHz if the capture stream is being opened
> - if the rate is set above 96kHz, the capture stream cannot be opened,
>   returns -EBUSY or so.
> 
> BTW, is it supposed to be still highly experimental?  If the driver
> works more or less stably with your device (and on the recent kernel),
> it'd be also good to put this to the upstream, i.e. in alsa-kernel
> tree instead of alsa-driver tree.
> 
> 
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
-----------------

inSITE, s.r.o.

Rubesova 29, 326 00 Plzen
Tel., fax: +420 - 37 - 74 493 58
GSM: +420 - 603 - 163 973
Email: pavel.hofman@insite.cz

www.educity.cz, www.insite.cz
www.meetings.cz, www.hrzive.cz
www.comben.cz, www.hr-online.cz
-------------------------------
Navstivte www.educity.cz, server
s nejvetsi nabidkou profesniho
vzdelavani na ceskem internetu.
