From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: plug:dmix slows playback
Date: Fri, 12 Jun 2009 12:32:49 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0906121229350.13028@eeebox2.perex-int.cz>
References: <000001c9eb46$24a60d30$6df22790$@langstaff@pebblebay.com>
	<alpine.LNX.2.00.0906121213520.13028@eeebox2.perex-int.cz>
	<000101c9eb48$8e0a9280$aa1fb780$@langstaff@pebblebay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 14A9424679
	for <alsa-devel@alsa-project.org>;
	Fri, 12 Jun 2009 12:32:50 +0200 (CEST)
In-Reply-To: <000101c9eb48$8e0a9280$aa1fb780$@langstaff@pebblebay.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Steve Langstaff <steve.langstaff@pebblebay.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 12 Jun 2009, Steve Langstaff wrote:

>> From: alsa-devel-bounces@alsa-project.org [mailto:alsa-devel-
>> bounces@alsa-project.org] On Behalf Of Jaroslav Kysela
>
>> On Fri, 12 Jun 2009, Steve Langstaff wrote:
>>
>>> Hi All.
>>>
>>> I've got an installation of ALSA (1.0.19 on an embedded device) where
>> using
>>> plug and dmix as my output device slows down playback - voices and
>> tones are
>>> lower in pitch and the playback takes longer than when not using
>> plug:dmix,
>>> e.g.
>>
>> Does 48000Hz 2 channel source work OK with direct device (without dmix)
>> for your hardware?
>
> Yes, I converted the original sample to 48000 Hz, Stereo, and it sounds OK
> when I don't use dmix.
>
> /mnt # time aplay -v ignition48000s.wav

....

> Slave: Hardware PCM card 0 'LM4549' device 0 subdevice 0

>  msbits       : 16

If I remember correctly, this value was 32 in your dmix setup.
Could you try command:

 	aplay -D"plug:'dmix:FORMAT=S16_LE'" <filename>

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
