From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Compressed Audio Playback/Capture through ALSA
 framework
Date: Wed, 16 Mar 2011 08:23:39 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1103160811480.4805@eeebox2.perex-int.cz>
References: <4D7FB076.30300@codeaurora.org> <4D7FCEA3.4070003@audioscience.com>
	<4D7FF63B.40805@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 40D6A1038DE
	for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2011 08:23:40 +0100 (CET)
In-Reply-To: <4D7FF63B.40805@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>
Cc: Eliot Blennerhassett <linux@audioscience.com>, alsa-devel <alsa-devel@alsa-project.org>, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, 15 Mar 2011, Patrick Lai wrote:

> On 3/15/2011 1:40 PM, Eliot Blennerhassett wrote:
>> On 16/03/11 07:31, Patrick Lai wrote:
>>> Hi,
>>>
>>> Is there a precedent for playback/capture compressed audio stream
>>> through ALSA playback/capture interface if underlying hardware supports
>>> decoder + sink&  encoder + source capabilities?
>>
>> No.  (Apart from AC3 passthrough to spdif output)
>
> I presume you are referring to IEC958 format. Are there ASoC drivers
> that support IEC958 format already? Why is AC3 passthrough acceptable
> but not other compressed audio format?

I agree. AC3, DTS and also MPEG2 formats should work. The PCM parameters 
for VBR streams are fixed (at least I don't know about any format which 
changes the rate/bits/channels inside the stream). So we can use IEC958 (
IEC 61937) and for other formats we can create similar extensions.

The only part which we can improve in the ALSA layer may be more better 
synchronization handling in case of xruns. Because these compressed 
streams are transferred in blocks, the whole block might be dropped.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
