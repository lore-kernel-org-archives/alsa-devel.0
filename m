From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: need help understanding overrun/underrun
Date: Tue, 24 Aug 2010 14:12:26 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1008241409570.10278@eeebox2.perex-int.cz>
References: <98769532B4BB14429434178695419EAE0523526CDA@bgsmsx501.gar.corp.intel.com>
	<alpine.LNX.2.00.1008201146200.10278@eeebox2.perex-int.cz>
	<98769532B4BB14429434178695419EAE0523634AC6@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 8CCA5246AF
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Aug 2010 14:12:26 +0200 (CEST)
In-Reply-To: <98769532B4BB14429434178695419EAE0523634AC6@bgsmsx501.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Harsha, Priya" <priya.harsha@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 24 Aug 2010, Harsha, Priya wrote:

>
>> -----Original Message-----
>> From: Jaroslav Kysela [mailto:perex@perex.cz]
>> Sent: Friday, August 20, 2010 3:20 PM
>> To: Harsha, Priya
>> Cc: alsa-devel@alsa-project.org
>> Subject: Re: [alsa-devel] need help understanding overrun/underrun
>>
>> On Fri, 20 Aug 2010, Harsha, Priya wrote:
>>
>>> Hi
>>>
>>> I had modified the arecord application to call snd_pcm_writei() with the
>>> output of snd_pcm_readi(). Basically a loopback.
>>>
>>> When we execute, I see the calls return EPIPE (lot of overruns and a few
>>> underruns). Can anyone help me understand why there are underrun/overrun
>>> being printed? Is it because of the serial call of reads and writes? Is
>>> there any issue with the driver I am using? Can you suggest some ways to
>>> overcome these messages?
>>
>> You must queue playback with more samples at the beginning (to
>> setup the output latency) otherwise you get the output underrun
>> immediatelly. See alsa-lib/test/latency.c for an example.
> If I do that, initially I don't see underrun. But I see a lot of overrun.
> I am doing readi() followed by writei() in a loop of small buffer sizes,
> Is that an expected behavior to see such overrun?

Overrun means that the application did not empty the capture ring bufqfer 
in time. Try to run your program as root with realtime scheduler settings 
(see the latency.c how to do it) or increase the capture buffer size.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
