From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH v2 1/1] alsa-lib: Add snd_pcm_start_at.
Date: Fri, 9 Jan 2015 20:03:04 +0800
Message-ID: <CAN8ccibWaAmc8hMG5Eb2bLcKP4i-nWLrAETgFg2c-tGvd8QDwQ@mail.gmail.com>
References: <1418837267-10896-1-git-send-email-timcussins@eml.cc>
 <CAN8cciZE+rHGuCHWjXbFi43ofR2k5w=P-hBvy4P69+Xeo5PVxA@mail.gmail.com>
 <5492A7F9.8090602@eml.cc> <54ABF459.8000504@linux.intel.com>
 <54ABFB98.3050506@eml.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f170.google.com (mail-qc0-f170.google.com
 [209.85.216.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 0AB0F2607E9
 for <alsa-devel@alsa-project.org>; Fri,  9 Jan 2015 13:03:05 +0100 (CET)
Received: by mail-qc0-f170.google.com with SMTP id x3so8137216qcv.1
 for <alsa-devel@alsa-project.org>; Fri, 09 Jan 2015 04:03:04 -0800 (PST)
In-Reply-To: <54ABFB98.3050506@eml.cc>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tim Cussins <timcussins@eml.cc>
Cc: nstoughton@aether.com, tiwai@suse.de, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

>>
>>
>>>> Do your implementation need to set specific start threshold to prevent
>>>> the driver automatically start when you fill the buffer ?
>>>
>>>
>>>
>>>> Do the driver allow to start when there is no data ?
>>>>
>>>
>>> It's the responsibility of the client to set the start threshold to a
>>> safe and responsible value.
>>>
>>> It might suit some applications to allow both threshold start _and_
>>> start_at: My implementation doesn't preclude this.
>>
>>
>> Now I am confused... My understanding was that this feature is similar
>> to SSYNC in HDAudio, where everything is ready, buffers filled, DMAs
>> armed, FIFOs filled and the start condition only opens the last gate at
>> a specific time - possibly with multiple streams starting at the same
>> time. If you add a condition on the start_threshold you really don't
>> need any hardware-driven start, do you?
>
>
> What you've described is exactly what I had in mind, so we're still on
the same page.
>
> I wanted to make it clear that my implementation of start_at doesn't
*prevent* client code starting on a threshold *and* using start_at, even if
it seems to us like a strange idea.

http://www.alsa-project.org/alsa-doc/alsa-lib/pcm.html

Handshake between application and library

Do alsa lib assume all read/write must only call after calling
snd_pcm_sw_params() ?

It seem that proposed start_at() can only be call in SND_PCM_STATE_PREPARED
and should fail when stream is already running

Are there any mean to cancel the scheduled snd_pcm_start_at  ?

Seem there is no check when the application call snd_pcm_start_at()
multiple times

>
> Preventing the use of both requires us to show why it's never a useful
idea, decide on policy (what do happens when client code tries to use
both), and implement that policy. I'd rather just leave it as 'possible'
:at()
