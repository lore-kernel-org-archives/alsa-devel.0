From: Hans-Kristian Arntzen <maister@archlinux.us>
Subject: Re: redirecting audio to another desktop machine
Date: Mon, 21 Jun 2010 12:51:12 +0200
Message-ID: <4C1F4420.3060904@archlinux.us>
References: <mailman.1.1277114401.21597.alsa-devel@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 1B7F424570
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Jun 2010 12:51:19 +0200 (CEST)
Received: by wyb40 with SMTP id 40so2175305wyb.38
	for <alsa-devel@alsa-project.org>; Mon, 21 Jun 2010 03:51:17 -0700 (PDT)
In-Reply-To: <mailman.1.1277114401.21597.alsa-devel@alsa-project.org>
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

On 06/21/2010 12:00 PM, alsa-devel-request@alsa-project.org wrote:
> Date: Mon, 21 Jun 2010 14:57:00 +0530
> From: Viral Mehta<Viral.Mehta@lntinfotech.com>
> Subject: [alsa-devel] redirecting audio to another desktop machine
> To: "alsa-devel@alsa-project.org"<alsa-devel@alsa-project.org>
> Message-ID:
> 	<70376CA23424B34D86F1C7DE6B9973430254343B3E@VSHINMSMBX01.vshodc.lntinfotech.com>
> 	
> Content-Type: text/plain; charset="us-ascii"
>
> Hi list,
>
> I have an embedded device running linux kernel and a minimal filesystem.
>
> I want to access this device remotely which means I should be able to connect to the device just like we do Remote Desktop over ethernet.
> I am able to do this. I am able to send key-event and framebuffer data whenever my desktop machine connects to the device.
>
> But, I am not able to send audio data on remote side.
> I am really not sure which device file (/dev/snd/ ???) I should read and capture the data and should send across....
> Or can I read the playback device ? I think NO.
> Do I need to create some kind of virtual sound device ?
>
> Any pointers/suggestions are appreciated.
>
> Thanks,
> Viral
>
>
>    
If you want to reroute an ALSA application over the network, you can use 
output plugins. Afaik, both PulseAudio and RSound provides plugins for 
this. You generally want to set up a virtual device in .asoundrc or 
similar.

-- Hans-Kristian Arntzen
