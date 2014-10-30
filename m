From: dE <de.techno@gmail.com>
Subject: Re: Selecting correct input device port.
Date: Thu, 30 Oct 2014 10:07:48 +0530
Message-ID: <5451C09C.80606@gmail.com>
References: <544F1B26.2070502@gmail.com> <s5h38a7e39x.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
 [209.85.220.45])
 by alsa0.perex.cz (Postfix) with ESMTP id EA3192605DB
 for <Alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 05:38:15 +0100 (CET)
Received: by mail-pa0-f45.google.com with SMTP id lf10so4649485pab.4
 for <Alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 21:38:14 -0700 (PDT)
Received: from [192.168.1.2] ([117.208.69.53])
 by mx.google.com with ESMTPSA id dx10sm5773929pab.38.2014.10.29.21.38.11
 for <Alsa-devel@alsa-project.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Wed, 29 Oct 2014 21:38:13 -0700 (PDT)
In-Reply-To: <s5h38a7e39x.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/29/14 13:06, Takashi Iwai wrote:
> At Tue, 28 Oct 2014 09:57:18 +0530,
> dE wrote:
>>
>> As I learn't in this mailng list, a device can typically handle only one
>> stream at a time unless it supports hardware mixing which's exposed via
>> subdevices in ALSA
>>
>> What does subdevice mean for input device?
>
> When a device can do multiplexing, the driver can give multiple
> substreams (= subdevices).
>
>> Do they mark physical ports
>> for input? If not how do I record from a specific input port?
>
> You can pass the subdevice number explicity.  It's -1 as default,
> which means to select the next free one.
>
>> Is it
>> automatically selected by the card?
>>
>> And what's 'input source' in ALSA mixer?
>
> It's usually a MUX to select the input source, e.g. line in or mic.
>
>
> Takashi
>

Input source for single subdevice right? I've 3 sub device, does it have 
to do anything with the fact that I've 3 input source in alsamixer? Do 
the 3 input source mark 3 different subdevices?

By muxing you mean muxing via software the multiple individual (and 
simultaneous) audio input streams as supported by the cards?
