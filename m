From: Ken Prox <knprox@mi.rr.com>
Subject: Re: [PATCH - hda intel conextant 1/1] Fixed microphone
 mixer for HP Compaq Presario F700 Added conextant patch for	Hewlett-Packard
 Company Device Subsystem id - 103c:30ea
Date: Mon, 25 Jan 2010 19:19:31 -0500
Message-ID: <4B5E3513.6050907@mi.rr.com>
References: <1262565656-2737-1-git-send-email-knprox@mi.rr.com>	<alpine.LNX.2.00.1001080908040.4210@eeebox2.perex-int.cz>	<s5hvdf766a1.wl%tiwai@suse.de>
	<s5h4ombbxok.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.124]) by alsa0.perex.cz (Postfix) with ESMTP id 6E421243EE
	for <alsa-devel@alsa-project.org>; Tue, 26 Jan 2010 01:19:36 +0100 (CET)
In-Reply-To: <s5h4ombbxok.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>, Ken Prox <kprox@users.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On 01/24/2010 05:32 AM, Takashi Iwai wrote:
> At Tue, 12 Jan 2010 10:07:02 +0100,
> I wrote:
>    
>> At Fri, 8 Jan 2010 09:09:54 +0100 (CET),
>> Jaroslav Kysela wrote:
>>      
>>> On Sun, 3 Jan 2010, knprox@mi.rr.com wrote:
>>>
>>>        
>>>> From: Ken Prox<kprox@users.sourceforge.net>
>>>>
>>>>
>>>> Signed-off-by: Ken Prox<kprox@users.sourceforge.net>
>>>>          
>>> I've applied your patch to my "devel" git tree with space/tab
>>> replacements. Please, use same coding style matching other ALSA code and
>>> run "scripts/checkpatch.pl" on your patch before posting. Thanks.
>>>        
>> I pulled your branches now to sound git tree.
>>      
> And, now I'm checking the code and your change again while I'm working
> on fixing / clean-up of cxt5051 code.  I don't understand why your patch
> works.  Does it really work as is?
>
> For example, the pin 0x17 has no multiple connections.  So, changing
> the amp for the input #1 doesn't make sense at all.  If it supports only
> the pin 0x1d, then the init verbs have to be different.
>
> Doesn't another model, e.g. model=hp-dv6736, work as is?
>    

> thanks,
>
> Takashi
>    

Hello Takashi,

Yes, using model=hp-dv6736 works for device 103c:30ea, but the mixer 
control does not control the microphone.  However, with the patch I 
supplied, the microphone mixer control does work.

Yes, the patch for the 103c:30ea does work as is.  If there is a change 
to the init verbs that you would like me to try, I would be more than 
happy to help.

-- 
"So often do the spirits of great events stride on before the events. And in today already walks tomorrow." - Coleridge

Ken

pgp     hkp://wwwkeys.eu.pgp.net
Skype   callto://ken.prox
