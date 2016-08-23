From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH v5 1/2] amidi: add delay option
Date: Tue, 23 Aug 2016 12:51:10 +0200
Message-ID: <f24f99c5-1344-6b3d-8062-7cf905819bc6@ladisch.de>
References: <20160815163734.17658-1-eu@felipetonello.com>
 <20160815163734.17658-2-eu@felipetonello.com>
 <5b064978-df48-23fa-26e1-89f9ed1843ff@ladisch.de>
 <1e733023-d7e8-a4ac-3b27-4bdb5a659418@felipetonello.com>
 <6bc1bbb7-37ea-8d23-875b-3472ec131463@ladisch.de>
 <380e9e0d-2d59-d814-062e-ca217fe78c09@felipetonello.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 917FF266A51
 for <alsa-devel@alsa-project.org>; Tue, 23 Aug 2016 12:51:13 +0200 (CEST)
In-Reply-To: <380e9e0d-2d59-d814-062e-ca217fe78c09@felipetonello.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Felipe Ferreri Tonello <eu@felipetonello.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Felipe Ferreri Tonello wrote:
> On 23/08/16 11:37, Clemens Ladisch wrote:
>> Felipe Ferreri Tonello wrote:
>>> On 22/08/16 13:43, Clemens Ladisch wrote:
>>>> Felipe F. Tonello wrote:
>>>>> +				if (data > send_data)
>>>>> +					usleep(delay * 1000);
>>>>
>>>> The MIDI data is sent asynchonously, so this delay is not _between_ me=
ssages.
>>>> You'd have to add 320 =B5s for any byte not yet sent (I guess you have=
 to use
>>>> snd_rawmidi_status_get_avail() to find out how many have been sent).
>>>
>>> Right. Or I can just use snd_rawmidi_drain()?
>>
>> This function not only drains the ALSA buffer, but also waits for the
>> hardware FIFO to empty.  And most drivers do not implement this, in
>> which case the framework just does a fixed wait of 50 ms, which would
>> correspond to a FIFO size of 156 bytes.
>
> Ok, so does that mean that it is not safe to use drain()?

That additional 50 ms delay might be safe, but not what you want.


Regards,
Clemens
