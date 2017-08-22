From: "Keith A. Milner" <maillist@superlative.org>
Subject: Attempting to understand odd snd-usb-audio code and
	behavior
Date: Tue, 22 Aug 2017 21:25:40 +0100
Message-ID: <2006820.TBXnYHJvYE@kamdesktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f177.google.com (mail-wr0-f177.google.com
 [209.85.128.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 81AF4266998
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 22:25:43 +0200 (CEST)
Received: by mail-wr0-f177.google.com with SMTP id f8so94698229wrf.3
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 13:25:43 -0700 (PDT)
Received: from kamdesktop.localnet
 (c.2.b.4.b.5.8.6.f.3.1.e.3.4.c.8.f.a.9.2.a.0.e.b.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:be0a:29af:8c43:e13f:685b:4b2c])
 by smtp.gmail.com with ESMTPSA id d8sm196892wmh.48.2017.08.22.13.25.41
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 22 Aug 2017 13:25:41 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Over the last few weeks I've been trying to dig through the snd-usb-audio code 
to try to get an understanding of it. I've used ftrace and also a local 
version which I have heavily polluted with kprintf(KERN_INFO statements so I 
can track what it's doing in practice.

I've been playing with this with some USB audio interfaces I have some which 
work, and some which don't, and trying to understand the differences and, 
ultimately, what I can do to make the non-functioning ones work.

I've got to the point where I have a fairly good understanding of some parts, 
but I'm struggling to understand why the code is behaving as it does in 
practice.

My observation when plugging the USB device in is that, as expected, it tries 
to build the audio device, and add components to it including attaching 
capture and playback streams. It seems to go through this phase without too 
many surprises, and we get to the standard dmesg output:

usbcore: registered new interface driver snd-usb-audio

After this, it gets confusing.

It seems to open and close the PCMs (e.g, snd_usb_capture_open) several times 
in a row. Each time it sets up the hardware info, checks and sets the format 
and then closes the PCM. I don't see anything obviously different between most 
of these cycles. Here's an example my logging output (hopefully this will make 
sense):

Aug 22 20:04:16 kerneldev kernel: [  923.140789] Called: pcm.c - 
snd_usb_capture_open for pcm substream 0
Aug 22 20:04:16 kerneldev kernel: [  923.140789] Called: pcm.c - 
snd_usb_pcm_open for pcm substream 0
Aug 22 20:04:16 kerneldev kernel: [  923.140789] Setting up hw info
Aug 22 20:04:16 kerneldev kernel: [  923.140789] Checking format:
Aug 22 20:04:16 kerneldev kernel: [  923.140790]  Interface number = 2
Aug 22 20:04:16 kerneldev kernel: [  923.140790]  alt setting = 1
Aug 22 20:04:16 kerneldev kernel: [  923.140790]  alt setting index = 1
Aug 22 20:04:16 kerneldev kernel: [  923.140790]  format type = 1
Aug 22 20:04:16 kerneldev kernel: [  923.140790]  frame size = 0
Aug 22 20:04:16 kerneldev kernel: [  923.140791] Setting pt=125 ptmin=125
Aug 22 20:04:16 kerneldev kernel: [  923.140792] Checking for unusual bit 
rates
Aug 22 20:04:16 kerneldev kernel: [  923.140794] Called: init.c - 
snd_card_file_remove
Aug 22 20:04:16 kerneldev kernel: [  923.140921] Called: pcm.c - 
snd_usb_hw_params for pcm substream 0
Aug 22 20:04:16 kerneldev kernel: [  923.140945] Setting format:
Aug 22 20:04:16 kerneldev kernel: [  923.140945]  Bytes per period = 8816
Aug 22 20:04:16 kerneldev kernel: [  923.140945]  Frames per period = 1102
Aug 22 20:04:16 kerneldev kernel: [  923.140946]  Periods per buffer = 4
Aug 22 20:04:16 kerneldev kernel: [  923.140946]  Channels = 2
Aug 22 20:04:16 kerneldev kernel: [  923.140946]  Rate = 44100
Aug 22 20:04:16 kerneldev kernel: [  923.141279] Called: endpoint.c - 
snd_usb_add_endpoint of type 0 with direction 1
Aug 22 20:04:16 kerneldev kernel: [  923.141292] Called: pcm.c - 
snd_usb_pcm_prepare for pcm substream 0
Aug 22 20:04:16 kerneldev kernel: [  923.141293] Called: pcm.c - 
configure_endpoint
Aug 22 20:04:16 kerneldev kernel: [  923.141294] Called: endpoint.c - 
snd_usb_endpoint_set_params for endpoint 142, type 0
Aug 22 20:04:16 kerneldev kernel: [  923.141294] Setting endpoint params for 
endpoint num 142
Aug 22 20:04:16 kerneldev kernel: [  923.141294]  channels=2
Aug 22 20:04:16 kerneldev kernel: [  923.141294]  period bytes=8816
Aug 22 20:04:16 kerneldev kernel: [  923.141295]  frames per period=1102
Aug 22 20:04:16 kerneldev kernel: [  923.141295]  periods per buffer=4
Aug 22 20:04:16 kerneldev kernel: [  923.141296] Called: endpoint.c - 
data_ep_set_params for endpoint 142, type 0
Aug 22 20:04:16 kerneldev kernel: [  923.141301] Called: pcm.c - 
snd_usb_pcm_prepare for pcm substream 0
Aug 22 20:04:16 kerneldev kernel: [  923.142768] Called: init.c - 
snd_card_file_add
Aug 22 20:04:16 kerneldev kernel: [  923.142772] Called: init.c - 
snd_card_file_remove
Aug 22 20:04:16 kerneldev kernel: [  923.142774] Called: init.c - 
snd_card_file_add
Aug 22 20:04:16 kerneldev kernel: [  923.142830] Called: init.c - 
snd_card_file_remove
Aug 22 20:04:16 kerneldev kernel: [  923.142836] Called: pcm.c - 
snd_usb_hw_free for pcm substream 0
Aug 22 20:04:16 kerneldev kernel: [  923.142837] Called: endpoint.c - 
snd_usb_endpoint_deactivate for endpoint 142, type 0
Aug 22 20:04:16 kerneldev kernel: [  923.142846] Called: pcm.c - 
snd_usb_capture_close for pcm substream 0
Aug 22 20:04:16 kerneldev kernel: [  923.146760] Called: init.c - 
snd_card_file_remove
Aug 22 20:04:16 kerneldev kernel: [  923.146834] Called: init.c - 
snd_card_file_add
Aug 22 20:04:16 kerneldev kernel: [  923.146838] Called: init.c - 
snd_card_file_remove
Aug 22 20:04:16 kerneldev kernel: [  923.146841] Called: init.c - 
snd_card_file_add
Aug 22 20:04:16 kerneldev kernel: [  923.146845] Called: init.c - 
snd_card_file_add
Aug 22 20:04:16 kerneldev kernel: [  923.146848] Called: pcm.c - 
snd_usb_capture_open for pcm substream 0
Aug 22 20:04:16 kerneldev kernel: [  923.146849] Called: pcm.c - 
snd_usb_pcm_open for pcm substream 0
Aug 22 20:04:16 kerneldev kernel: [  923.146849] Setting up hw info

It seems to do this several times, before the behavior changing slightly, as 
it now starts to try to set the endpoint parameters and seems to leave the 
stream open. However, it then tries to open the stream and set the endpoint 
parameters again resulting in errors:

Aug 22 20:22:00 kerneldev kernel: [ 1987.452945] Called: endpoint.c - 
snd_usb_endpoint_set_params for endpoint 142, type 0
Aug 22 20:22:00 kerneldev kernel: [ 1987.452945] Setting endpoint params for 
endpoint num 142
Aug 22 20:22:00 kerneldev kernel: [ 1987.452945]  channels=2
Aug 22 20:22:00 kerneldev kernel: [ 1987.452945]  period bytes=1768
Aug 22 20:22:00 kerneldev kernel: [ 1987.452946]  frames per period=221
Aug 22 20:22:00 kerneldev kernel: [ 1987.452946]  periods per buffer=593
Aug 22 20:22:00 kerneldev kernel: [ 1987.452947] usb 1-1: Unable to change 
format on ep #8e: already in use

Maybe this is driven by hotplug or something, but it seems to be performing a 
lot of pointless activities.

Eventually it seems to try to open the PCM playback or capture stream (with 
some devices it opens playback, with others capture) and then checks the 
pointer:

Aug 22 20:22:00 kerneldev kernel: [ 1987.470194] Called: pcm.c - 
snd_usb_substream_playback_trigger for pcm substream 0
Aug 22 20:22:00 kerneldev kernel: [ 1987.470198] Called: pcm.c - 
snd_usb_pcm_pointer for pcm substream 0
Aug 22 20:22:00 kerneldev kernel: [ 1987.470198]   Pointer is 0
Aug 22 20:22:00 kerneldev kernel: [ 1987.470656] Called: pcm.c - 
snd_usb_pcm_pointer for pcm substream 0
Aug 22 20:22:00 kerneldev kernel: [ 1987.470657]   Pointer is 0
Aug 22 20:22:00 kerneldev kernel: [ 1987.470660] Called: pcm.c - 
snd_usb_pcm_pointer for pcm substream 0
Aug 22 20:22:00 kerneldev kernel: [ 1987.470660]   Pointer is 0
Aug 22 20:22:05 kerneldev kernel: [ 1992.473567] Called: pcm.c - 
snd_usb_pcm_pointer for pcm substream 0
Aug 22 20:22:05 kerneldev kernel: [ 1992.473569]   Pointer is 0


The above is from a non-working device. For a working device the pointer 
increments. Eventually this activity ends:

Aug 22 20:22:05 kerneldev kernel: [ 1992.473575] Called: pcm.c - 
snd_usb_substream_playback_trigger for pcm substream 0
Aug 22 20:22:05 kerneldev kernel: [ 1992.473576] Called: endpoint.c - 
snd_usb_endpoint_stop for endpoint 142, type 0
Aug 22 20:22:05 kerneldev kernel: [ 1992.473578] Called: endpoint.c - 
snd_usb_endpoint_stop for endpoint 13, type 0
Aug 22 20:22:05 kerneldev kernel: [ 1992.473602] Called: pcm.c - 
snd_usb_hw_free for pcm substream 0
Aug 22 20:22:05 kerneldev kernel: [ 1992.503287] Called: endpoint.c - 
snd_usb_endpoint_deactivate for endpoint 142, type 0
Aug 22 20:22:05 kerneldev kernel: [ 1992.503288] Called: endpoint.c - 
snd_usb_endpoint_deactivate for endpoint 13, type 0
Aug 22 20:22:05 kerneldev kernel: [ 1992.503323] Called: pcm.c - 
snd_usb_playback_close for pcm substream 0
Aug 22 20:22:05 kerneldev kernel: [ 1992.503656] Called: init.c - 
snd_card_file_remove

This seems as if it might be some sort of test of the PCMs, to make sure they 
are working. Certainly in non-working devices the pcm_pointer stays at zero 
and in working devices it increments.

It also seems to try harder with some devices than others, even though the 
device descriptors seem very similar.

Can anyone explain any of this to me, particularly why it's exhibiting this 
behaviour.

I've uploaded one of the logs from a non-working device to Pastebin if anyone 
wants to look at a full example: https://pastebin.com/uBZEuQ57

Also, is this the best way to approach this, or are there other 
tools/techniques that can help? I've experimented with ftrace and that was 
useful, but didn't give the level of detail I wanted.

Cheers,

Keith
