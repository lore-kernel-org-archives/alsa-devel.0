From: Tim Cussins <timcussins@eml.cc>
Subject: Re: [PATCH v2 1/1] alsa-lib: Add snd_pcm_start_at.
Date: Tue, 06 Jan 2015 15:13:28 +0000
Message-ID: <54ABFB98.3050506@eml.cc>
References: <1418837267-10896-1-git-send-email-timcussins@eml.cc>
 <CAN8cciZE+rHGuCHWjXbFi43ofR2k5w=P-hBvy4P69+Xeo5PVxA@mail.gmail.com>
 <5492A7F9.8090602@eml.cc> <54ABF459.8000504@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id E35B4261294
 for <alsa-devel@alsa-project.org>; Tue,  6 Jan 2015 16:13:31 +0100 (CET)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.nyi.internal (Postfix) with ESMTP id 6D49020CC2
 for <alsa-devel@alsa-project.org>; Tue,  6 Jan 2015 10:13:31 -0500 (EST)
In-Reply-To: <54ABF459.8000504@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Raymond Yau <superquad.vortex2@gmail.com>
Cc: nstoughton@aether.com, tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 06/01/15 14:42, Pierre-Louis Bossart wrote:
>
>>> Do your implementation need to set specific start threshold to prevent
>>> the driver automatically start when you fill the buffer ?
>>
>>
>>> Do the driver allow to start when there is no data ?
>>>
>>
>> It's the responsibility of the client to set the start threshold to a
>> safe and responsible value.
>>
>> It might suit some applications to allow both threshold start _and_
>> start_at: My implementation doesn't preclude this.
>
> Now I am confused... My understanding was that this feature is similar
> to SSYNC in HDAudio, where everything is ready, buffers filled, DMAs
> armed, FIFOs filled and the start condition only opens the last gate at
> a specific time - possibly with multiple streams starting at the same
> time. If you add a condition on the start_threshold you really don't
> need any hardware-driven start, do you?

What you've described is exactly what I had in mind, so we're still on 
the same page.

I wanted to make it clear that my implementation of start_at doesn't 
*prevent* client code starting on a threshold *and* using start_at, even 
if it seems to us like a strange idea.

Preventing the use of both requires us to show why it's never a useful 
idea, decide on policy (what do happens when client code tries to use 
both), and implement that policy. I'd rather just leave it as 'possible' :)

> Thanks,
> -Pierre
>
>
>
