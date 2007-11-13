From: "Timofei V. Bondarenko" <tim@ipi.ac.ru>
Subject: Re: [PATCH] cmipci - allow capture of raw
	spdif	subframes
Date: Tue, 13 Nov 2007 16:47:38 +0300
Message-ID: <4739AAFA.7020007@ipi.ac.ru>
References: <4731ABBE.8030805@ipi.ac.ru> <s5h1wb2uviy.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ipi.ac.ru (blackpeer.ipi.ac.ru [83.149.227.82])
	by alsa0.perex.cz (Postfix) with ESMTP id BAFBF24503
	for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2007 14:47:39 +0100 (CET)
In-Reply-To: <s5h1wb2uviy.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Wed, 07 Nov 2007 15:12:46 +0300,
> Timofei V. Bondarenko wrote:
>> Hi.
>>
>> Enable capturing of raw 32bit IEC958_SUBFRAME.
>>
>> The 24-bits PCM data can be obtained using iec958 plugin.
>>
>> Known problem: captured stream may begin with either left or right 
>> subframe. Since the iec958 plugin doesn't decode preamble it may swap 
>> the channels sometime.
>>
>> Regards,
>> 	Tim.
> 
> Applied this one, too.
> (Do you happen to have a fix for iec958 plugin, too? :)

Not yet.
I'm in doubt about a clean way to drop one subframe from the raw stream.
Could you give me a hint?

Regards,
	Tim.
