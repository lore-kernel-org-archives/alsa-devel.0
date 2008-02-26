From: "Adrian Stancu" <adrian.stancu.82@gmail.com>
Subject: Re: snd-usb-audio syncronisation problem
Date: Tue, 26 Feb 2008 14:53:45 +0200
Message-ID: <43e8c7320802260453m45c55ba5gb1756e288bf90808@mail.gmail.com>
References: <43e8c7320802220151p177d2c73y2c9724a4cb4743ef@mail.gmail.com>
	<47C2B822.7000507@ladisch.de>
	<43e8c7320802251032j7541ac02t1459ef83d95dfd4e@mail.gmail.com>
	<47C3C07B.2040104@ladisch.de>
	<43e8c7320802252353p2798488at87163c75a4511c4f@mail.gmail.com>
	<47C3CA77.5070104@ladisch.de>
	<43e8c7320802260038x17c2c350wade07dcd4f32cb3e@mail.gmail.com>
	<47C3D29B.9070708@ladisch.de>
	<43e8c7320802260120u241d2c83r97d7e00d4896992c@mail.gmail.com>
	<47C3F9BF.3080600@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gv-out-0910.google.com (gv-out-0910.google.com [216.239.58.186])
	by alsa0.perex.cz (Postfix) with ESMTP id 313F324630
	for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2008 13:53:48 +0100 (CET)
Received: by gv-out-0910.google.com with SMTP id c6so1406858gvd.24
	for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2008 04:53:47 -0800 (PST)
In-Reply-To: <47C3F9BF.3080600@ladisch.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I see, you say that the device knows what sample rate it is supposed
to use, and that this rate should be automatically used. However, in
practice, I guess this does not happen for some reason. For the
recording part, the things stay exactly like for playback, i.e. the
recorded sound is correct as long as the device is (manually, through
another OS) set to the sampling rate at which the recording is made.

Let me give a few examples:
1) I power on the device, and it automatically picks 48k. If i try
playing back something at any other rate (44.1k, 96k etc), the sound
is very distorted.
2) I logically connect the device to the virtual machine, set the
sampling rate to 96k through the creative supplied drivers, disconnect
(WITHOUT powering it off), reload the snd-usb-audio module in Linux.
Now, I can achieve correct playback only at 96k. Anything else is
distorted.
Of course, I can resample anything on-the-fly (through additional
device in ~/.asoundrc) to match the sampling rate of the device and
get normal sound.

As an additional note, recording at 192k seems *completely* broken. I
mean, If I record at 96k while the device was just powered on (i.e.
set to 48k), there is still a connection between the original and the
recorded sounds. However, at 192k, it looks just like pure noise, at
maximum amplitude.
Details:
http://img147.imageshack.us/my.php?image=recat96kdeviceat48kkt3.jpg
-- recorded at 96kHz
http://img81.imageshack.us/my.php?image=recat192kdeviceat48kii7.jpg
-- recorded at 192kHz
In both cases, the sound fed to the input was a simple 41.2Hz tone.


On Tue, Feb 26, 2008 at 1:36 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Adrian Stancu wrote:
>  > I wanted to mention that (from what I noticed until now), it is not
>  > possible to get correct playback on this device unless the sampling
>  > frequency it is set to (it defaults to 48k when powered on) matches
>  > the sampling frequency of the audio stream you send to it. So how is
>  > this supposed to work, if the device is set to 48k and my stream has
>  > 192k (and I cannot set the device to 192k)?
>
>  The alternate setting of the interface is supposed to set the sampling
>  frequency, and this is exactly what the driver does.
>
>  The returned frequency value is correct, so it seems the device knows
>  that it is supposed to run at 192 kHz.
>
>  Does recording work with all sample rates?
>
>
>  Regards,
>  Clemens
>
