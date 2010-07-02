From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] - arecord - remove "front" and related
 devices from the output of list-pcm option of arecord
Date: Fri, 2 Jul 2010 07:37:56 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1007020736530.15497@eeebox2.perex-int.cz>
References: <AANLkTinyBpf_qh6DGvj_V4UGY-JZUomNX6N32_WJpOjo@mail.gmail.com>
	<alpine.LNX.2.00.1007010745470.15497@eeebox2.perex-int.cz>
	<AANLkTimGJu_9tdOMhPutnW0MepWCr075y7rzXziNbdia@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 7626F245EA
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Jul 2010 07:37:57 +0200 (CEST)
In-Reply-To: <AANLkTimGJu_9tdOMhPutnW0MepWCr075y7rzXziNbdia@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 2 Jul 2010, Raymond Yau wrote:

> 2010/7/1 Jaroslav Kysela <perex@perex.cz>
>
>> On Thu, 1 Jul 2010, Raymond Yau wrote:
>>
>>  Replace "front" device by "hw" device  and remove "rear", "center_lfe" ,
>>> "side" , "surroundxx" from the output of "arecord -L" since "front" device
>>> cannot be used for capturing and the front device is for playback only  .
>>>
>>
>> NAK. Fix alsa-lib/configuration to return proper "IOID".
>>
>>                                        Jaroslav
>>
>
> I guess  the hint "IOID" has not implemented , the namehint.c did not add
> "Input" or "Output" to the hint_list and snd_device_name_get_hint() is
> unable to retrieve "IOID" from the hint_list

Use device_input and device_output in the hint {} section instead device.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
