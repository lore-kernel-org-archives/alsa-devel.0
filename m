From: Sakthi Subramanian <sakthi.subramaniang@gmail.com>
Subject: need input on USB Audio class device.
Date: Mon, 31 Jan 2011 15:51:34 +0530
Message-ID: <AANLkTi=yA+Ma0zo6HAceOdK1u8gv1hcVcT1dsOapv=Tp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id F2FDD2443D
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2011 11:21:34 +0100 (CET)
Received: by wyi11 with SMTP id 11so5284408wyi.38
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2011 02:21:34 -0800 (PST)
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

Hi All,
i am trying to develop a ALSA record application for USB - Audio device.
This USB Audio device has stereo recording and 4 inputs (4 mics).
I am trying to capture PCM audio from the 4 mics using the simple record
application.

Need inputs on the below questions, thanks in advance for the inputs.

1. I have used the ALSA API to set the number of channels as 8.
snd_pcm_hw_params_set_channels (capture_handle, hw_params, 8);

I have started capturing the data with the above change,
and opened the same using Audacity, it says 16 bit PCM Mono channel Little
Endian.
in my opinion, that must show as 8 channel.

Am i calling the right API with parameters? or Please let me know how to get
the multi channel PCM capture data from ALSA?

This is the output of arecord -l:

# arecord -l
**** List of CAPTURE Hardware Devices ****
card 0: Device [USB PnP Audio Device], device 0: USB Audio [USB Audio]
  Subdevices: 0/1
  Subdevice #0: subdevice #0

Once again thanks a lot for ur inputs..

Regards
Sakthi  SG
