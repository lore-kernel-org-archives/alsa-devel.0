From: Reiner <reiner1210@googlemail.com>
Subject: Re: snd_pcm_open device names
Date: Thu, 06 Mar 2008 19:34:16 +0100
Message-ID: <47D03928.3040902@googlemail.com>
References: <47CF2DE2.3010506@googlemail.com>
	<200803061313.51242.linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.187])
	by alsa0.perex.cz (Postfix) with ESMTP id 8905D24472
	for <alsa-devel@alsa-project.org>; Thu,  6 Mar 2008 19:34:23 +0100 (CET)
Received: by nf-out-0910.google.com with SMTP id b21so1723685nfd.32
	for <alsa-devel@alsa-project.org>; Thu, 06 Mar 2008 10:34:22 -0800 (PST)
In-Reply-To: <200803061313.51242.linux@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks! But if I try "asym" open fails, where can I see what "default" 
is? There is no ~/.asoundrc and in /etc there is only asound.state.
By the way I'am looking for a function to adjust the volume of the 
stream, any idea

Thanks
Reiner


Eliot Blennerhassett schrieb:
> On Thursday 06 March 2008 12:33:54 Reiner wrote:
>> with
>> snd_pcm_open (handle, "default", SND_PCM_STREAM_PLAYBACK, 0)
>> I can open a device twice
>> with
>> snd_pcm_open (handle, "plughw:0,0", SND_PCM_STREAM_PLAYBACK, 0)
>> the 2. call fails with error -16.
>>
>> The docu says:
>> The default device is equal to plug plugin with hw plugin as slave.
> 
> Probably the doc is in error. The default device these days is usually asym 
> (dmix+dsnoop) which allows the multiple opens.
> 
> --
> Eliot
> www.audioscience.com
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
