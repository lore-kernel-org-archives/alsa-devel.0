From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: S/PDIF on NVidia CK804 not working
Date: Sun, 20 Sep 2009 12:23:16 -0600
Message-ID: <51f3faa70909201123l3b57de6v39e50d560693ecce@mail.gmail.com>
References: <20090920112117.78a17dd2@nighthawk.voidtrance.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f220.google.com (mail-ew0-f220.google.com
	[209.85.219.220])
	by alsa0.perex.cz (Postfix) with ESMTP id 54F351037F3
	for <alsa-devel@alsa-project.org>;
	Sun, 20 Sep 2009 20:23:17 +0200 (CEST)
Received: by ewy20 with SMTP id 20so2582741ewy.45
	for <alsa-devel@alsa-project.org>; Sun, 20 Sep 2009 11:23:16 -0700 (PDT)
In-Reply-To: <20090920112117.78a17dd2@nighthawk.voidtrance.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mitko Haralanov <voidtrance@comcast.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Sep 20, 2009 at 12:21 PM, Mitko Haralanov
<voidtrance@comcast.net> wrote:
> Hi all,
>
> I am new to the list and was hoping that someone here could give me
> some help and advise as I am stuck and none of my research has turned
> anything up.
>
> I am having trouble getting any sound out of the S/PDIF port on my
> built-in sound card. The card is recognized and 'aplay -L' shows the
> iec958 device (as evident by the attached alsa-info.txt file) but when
> I try to play any sound through it (using aplay) I get one of two
> errors:
>
> 1. If I use the iec958 device directly:
> $ aplay -D iec958 /usr/share/sounds/alsa/Front_Center.wav
> Playing WAVE '/usr/share/sounds/alsa/Front_Center.wav' : Signed 16 bit
> Little Endian, Rate 48000 Hz, Mono aplay: set_params:984: Channels
> count non available
>
> 2. If I try to use the plug:iec958:
> $ aplay -D plug:iec958 /usr/share/sounds/alsa/Front_Center.wav
> Playing WAVE '/usr/share/sounds/alsa/Front_Center.wav' : Signed 16 bit
> Little Endian, Rate 48000 Hz, Mono
> (the sound file seems to play but there is no audio coming out of the
> receiver)
>
> Looking through the ALSA website, I see that my sound device is
> supported. Configuring /etc/asound.conf and /etc/modprobe.conf as per
> the ALSA website yields the same results as above.
>
> Can anyone please, help me get my S/PDIF working?
> Thank you very much!

Can you check if there are any mixer controls or switches which have any effect?
