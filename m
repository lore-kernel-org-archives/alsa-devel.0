From: Jon <jon@seniorblanco.com>
Subject: Re: trouble using S/PDIF input on CMI8738-MC6: C-Media
 CMI8738 (model 55)
Date: Wed, 13 Aug 2014 10:11:23 -0700
Message-ID: <53EB9C3B.2070602@seniorblanco.com>
References: <53EA40EB.2060201@seniorblanco.com> <53EB80C3.7020909@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from thetis.seniorblanco.com
 (108-227-52-43.lightspeed.irvnca.sbcglobal.net [108.227.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id D4D09261A2F
 for <alsa-devel@alsa-project.org>; Wed, 13 Aug 2014 19:12:01 +0200 (CEST)
In-Reply-To: <53EB80C3.7020909@ladisch.de>
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

On 08/13/2014 08:14 AM, Clemens Ladisch wrote:
> jon wrote:
>> Simple mixer control 'IEC958 In Record',0
>>    Mono: Playback [off]
>
> Shouldn't this be on?

Yes, it should, and actually it automatically turns itself on 
automatically when the arecord command is started, and then back off 
after the i/o error.  Note that this is one of the toggles that only 
appeared in alsamixer after the source code change of the two "#if 0" 
lines to "#if 1".

>
>> Simple mixer control 'IEC958 In Select',0
>>    Mono: Playback [on]
>
> IIRC this selects between two different inputs.
> Try both settings.

Yes, the documentation I have read suggests it should toggle between the 
internal CDROM when off and the external digital input when on, however 
I have tried both settings and there is no apparent change in behavior. 
  I still get an i/o error and a 44 byte file either way.

>
>
> Regards,
> Clemens
>
