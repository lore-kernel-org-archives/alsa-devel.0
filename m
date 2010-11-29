From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Is calling snd_pcm_sw_params() mandatory ?
Date: Mon, 29 Nov 2010 12:20:52 +0800
Message-ID: <AANLkTinXD=5sZHdpPOdsrVnhuS629a7VBXwFQvxaU9+c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 4411710380A
	for <alsa-devel@alsa-project.org>; Mon, 29 Nov 2010 05:20:56 +0100 (CET)
Received: by eyg24 with SMTP id 24so1707002eyg.38
	for <alsa-devel@alsa-project.org>; Sun, 28 Nov 2010 20:20:53 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>>Twas brillig, and Raymond Yau at 24/07/10 04:51 did gyre and gimble:
>> 2010/7/15 Colin Guthrie <gmane <at> colin.guthr.ie>
>>
>>
>> Can I remove pulseaudio from mandriva 2000 ?
>>
>> I just want to test *libcanberra*-alsa alone ( i.e. *libcanberra* without
>> pulseaudio )
>>
>> when PA server abort, and *libcanberra*-pulse cannot connect to PA server ,
>>
>> Will *libcanberra* use *libcanberra*-alsa connect to PA using alsa-pulse plugin
>> ?

> Use draksound (or via Mandriva Control Center) to disable pulseaudio and
> the ALSA backend for canberra should be used instead.

> It's based on the alternatives system and the file
> /etc/sound/profiles/alsa/canberra.conf

> Col

It is strange that the alsa back end of libcanberra
(http://git.0pointer.de/?p=libcanberra.git;a=blob;f=src/alsa.c) does
not call snd_pcm_sw_params()

Does alsa-lib has any check whether the application had called
snd_pcm_sw_params() or
it provide default values for those software parameters (e.g.
start_threshold, stop_threshold)
when the application only call snd_pcm_hw_params() and snd_pcm_prepare()
