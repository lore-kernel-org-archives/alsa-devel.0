From: "Adrian Stancu" <adrian.stancu.82@gmail.com>
Subject: Re: snd-usb-audio syncronisation problem
Date: Tue, 26 Feb 2008 09:53:38 +0200
Message-ID: <43e8c7320802252353p2798488at87163c75a4511c4f@mail.gmail.com>
References: <43e8c7320802220151p177d2c73y2c9724a4cb4743ef@mail.gmail.com>
	<47BEEF4D.4050507@ladisch.de>
	<43e8c7320802220815y332a82f4kac19999cc15fd276@mail.gmail.com>
	<47BEF8FE.4030408@ladisch.de>
	<43e8c7320802220846g7d7c8b61jb29e8ca3028d2c24@mail.gmail.com>
	<47BEFFFC.8030301@ladisch.de>
	<43e8c7320802220902j3a4ff3a1wdae77ec25f2d3785@mail.gmail.com>
	<47C2B822.7000507@ladisch.de>
	<43e8c7320802251032j7541ac02t1459ef83d95dfd4e@mail.gmail.com>
	<47C3C07B.2040104@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.177])
	by alsa0.perex.cz (Postfix) with ESMTP id 8BD101038B8
	for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2008 08:53:39 +0100 (CET)
Received: by el-out-1112.google.com with SMTP id z25so1634737ele.8
	for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2008 23:53:38 -0800 (PST)
In-Reply-To: <47C3C07B.2040104@ladisch.de>
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

Thanks,

Here is what i get:
deathu@vader:~/Desktop$ sox testtone96.wav -r 192000 testtone192.wav
deathu@vader:~/Desktop$ aplay -D hw:1 testtone192.wav
Playing WAVE 'testtone192.wav' : Signed 16 bit Little Endian, Rate
192000 Hz, Mono
aplay: set_params:918: Sample format non available

If i do this:
deathu@vader:~/Desktop$ aplay -D plughw:1 testtone192.wav
Playing WAVE 'testtone192.wav' : Signed 16 bit Little Endian, Rate
192000 Hz, Mono
I receive totally damaged audio (wrong frequency, lots of artifacts)

Note: I wasn't ever able to use hw:1 or hw:1,0 as output for this
interface, only plughw:1,0

On Tue, Feb 26, 2008 at 9:32 AM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Adrian Stancu wrote:
>  > I don't know if there's any way around this, but I currently don't see
>  > any way of using this interface at >96kHz in Linux.
>
>  sox something.wav -r 192000 something-192.wav
>  aplay -D hw:1 something-192.wav
>
>
>  HTH
>  Clemens
>
