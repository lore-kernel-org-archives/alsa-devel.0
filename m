From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: Record stereo from one input on the soundcard
Date: Fri, 25 Jan 2019 22:32:00 +0100
Message-ID: <e285bd85-2f7b-b7f8-5b1d-83bf50eb42ec@ivitera.com>
References: <87muo6uhww.fsf@fliptop.i-did-not-set--mail-host-address--so-tickle-me>
 <87sgxgxy9l.fsf@fliptop.i-did-not-set--mail-host-address--so-tickle-me>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (cable.insite.cz [84.242.75.189])
 by alsa0.perex.cz (Postfix) with ESMTP id 0422F2666B3
 for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2019 22:32:10 +0100 (CET)
In-Reply-To: <87sgxgxy9l.fsf@fliptop.i-did-not-set--mail-host-address--so-tickle-me>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tomas Nordin <tomasn@posteo.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Tomas,

Dne 25. 01. 19 v 21:44 Tomas Nordin napsal(a):
>>
>> The following command lets me record audio from the card,
>>
>> $ arecord -c 2 -d 60 -f S24_3LE -r 48000 -D hw:1,0 s3.wav
>>
>> The resulting wav file has all hearable audio in the left speaker when
>> listening.

If you really feed stereo signal into your soundcard stereo input jack 
and the card is not somehow configured to merge the input channels, the 
above command does record stereo signal.

Available controls of the card are listed by command

amixer -c 1 contents

Best regards,

Pavel.
