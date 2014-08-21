From: Jon <jon@seniorblanco.com>
Subject: Re: trouble using S/PDIF input on CMI8738-MC6: C-Media
 CMI8738 (model 55)
Date: Wed, 20 Aug 2014 17:20:28 -0700
Message-ID: <53F53B4C.20905@seniorblanco.com>
References: <53EA40EB.2060201@seniorblanco.com> <53EB80C3.7020909@ladisch.de>
 <53EB9C3B.2070602@seniorblanco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from thetis.seniorblanco.com
 (108-227-52-43.lightspeed.irvnca.sbcglobal.net [108.227.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 28CD126570A
 for <alsa-devel@alsa-project.org>; Thu, 21 Aug 2014 02:21:03 +0200 (CEST)
In-Reply-To: <53EB9C3B.2070602@seniorblanco.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 08/13/2014 10:11 AM, Jon wrote:
> On 08/13/2014 08:14 AM, Clemens Ladisch wrote:
>> jon wrote:
>>> Simple mixer control 'IEC958 In Record',0
>>>    Mono: Playback [off]
>>
>> Shouldn't this be on?
>
> Yes, it should, and actually it automatically turns itself on
> automatically when the arecord command is started, and then back off
> after the i/o error.  Note that this is one of the toggles that only
> appeared in alsamixer after the source code change of the two "#if 0"
> lines to "#if 1".
>
>>
>>> Simple mixer control 'IEC958 In Select',0
>>>    Mono: Playback [on]
>>
>> IIRC this selects between two different inputs.
>> Try both settings.
>
> Yes, the documentation I have read suggests it should toggle between the
> internal CDROM when off and the external digital input when on, however
> I have tried both settings and there is no apparent change in behavior.
>   I still get an i/o error and a 44 byte file either way.
>
>>
>>
>> Regards,
>> Clemens
>>

Thanks by the way for the reply.  I appreciate it.  I wish I had more 
informed data to provide.  Its probably also worth noting that before 
and after enabling the "IEC958 In Record" switch to be visible in 
alsamixer, I also tried literally dozens of other combinations of on/off 
states for the SPDIF switches, and other things in alsamixer, to no 
avail.  The outcome is always the same i/o error and resulting 44-byte 
file of silence.

Is there perhaps any way to output some better diagnostic issue from the 
driver that might hint at a solution?  As I'm perusing the source code 
right now I see that there are a bunch of "#define"s right near the 
beginning, some commented as "model 037" and "model 039" after which 
there are two adjacent to comments "model 055?" (the model I have, but 
note the question mark) and I'm wondering if this problem could be 
really just as simple as someone having guessed wrong about the correct 
value there having not had this particular model on hand to test with?

Thanks,
Jon
