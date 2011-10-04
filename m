From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Event flood on USB disconnect
Date: Tue, 4 Oct 2011 10:30:23 +0800
Message-ID: <CAN8cciZi1JYKRU8tWF4gmG_O9vSf88zBrhXyrC1iRNNC3eT12Q@mail.gmail.com>
References: <1317459007.6559.18.camel@snowflake>
	<1317459237.6559.20.camel@snowflake>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 779F724423
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Oct 2011 04:30:25 +0200 (CEST)
Received: by bkbzu17 with SMTP id zu17so64715bkb.38
	for <alsa-devel@alsa-project.org>; Mon, 03 Oct 2011 19:30:24 -0700 (PDT)
In-Reply-To: <1317459237.6559.20.camel@snowflake>
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

2011/10/1 Arun Raghavan <arun.raghavan@collabora.co.uk>:
> On Sat, 2011-10-01 at 14:19 +0530, Arun Raghavan wrote:
>> Hi folks,
>> We're seeing a problem when disconnecting USB headsets in PulseAudio.
>> Steps to reproduce are basically: start PulseAudio, plug in USB device,
>> wait for it to suspend (pcm is closed but mixer is not), disconnect.
>> Fairly often, this results in PA getting killed because the polling
>> thread is realtime and exceeds its rlimit. The problem is not limited to
>
> Missed one detail -- I've only seen this happen on the alsa-source
> thread, not on alsa-sink, but I've only tested with one device which has
> playback as well as capture.
>
> -- Arun
>

Cannot reproduced this issue on ubuntu 11.04 Live CD with Logictech WebCam mic

PA server still keep running and Gnome Sound Preference automatically
change the selected "input device" from USB microphone to on-board
sound card when usb webcam is unplugged

Actully Gnome Sound Preference is lying about "no application is using
the sound card"  since it open the "monitor" at 25Hz (peak-detect" for
displaying the vumeter of the microphone
