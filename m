From: Daniel Mack <zonque@gmail.com>
Subject: Re: USB MIDI Regression? - - Was: Small Regression in
 midi for M-Audio Fast Track Ultra.
Date: Sat, 23 Apr 2011 11:09:53 +0200
Message-ID: <BANLkTimsW7Qj_RFMEOjQp7t1gpvz_8_=Rg@mail.gmail.com>
References: <BANLkTim0nHo5h8FBebrt_e77igtj4tGOgQ@mail.gmail.com>
	<4DABF85F.1040408@showlabor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id B19BA1037F9
	for <alsa-devel@alsa-project.org>;
	Sat, 23 Apr 2011 11:09:56 +0200 (CEST)
Received: by vws20 with SMTP id 20so1055711vws.38
	for <alsa-devel@alsa-project.org>; Sat, 23 Apr 2011 02:09:55 -0700 (PDT)
In-Reply-To: <4DABF85F.1040408@showlabor.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Felix Homann <linuxaudio@showlabor.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Felix,

On Mon, Apr 18, 2011 at 10:37 AM, Felix Homann <linuxaudio@showlabor.de> wrote:
> Am 16.04.2011 04:29, schrieb Grant Diffey:
>> In 2.6.33/34 when support originally was put in alsa mainline the MIDI ports
>> were functional today they're not for me and I get the following in the
>> kernel log when using this card. (Audio all works acceptably.)
>
> I can confirm Grant's issue.
>
> They are not related to any code specific to the M-Audio Fast Track
> Ultra (FTU) series:
>
> Even after removing the FTU patches from current ALSA (git) the MIDI
> ports of the device will not be recognized.
>
> Switching back to my oldest installed kernel (2.6.32) the FTU will be
> recognized as a MIDI interface (but as expected the PCM ports will not
> be recognized.)

Hmm, between these version, there was my huge refactoring of the
usb-audio code, so this could indeed be related. However, most of my
patches were for the audio part, and not for MIDI.

> Just to make sure, that I'm not missing anything:
>
> * I've used 'amidi - l' to look for MIDI ports
> * Due to the deprecation of OSS in the kernel my Alsa configure line now
> includes '--with-oss=no --with-pcm-oss-plugins=no' which shouldn't have
> an effect but I mention it anyway

I would rather start off with two source trees of the kernel (one for
2.6.32 and one for any newer version that doesn't work anymore) and
then put lots of printk() lines to trace the functions. If you build
the driver as modules in both cases, you can easily add more debug
output on the fly without rebooting (some sort of "sudo rmmod ...;
make SUBDIRS=sound/usb; sudo insmod ..." is what I usually do).

I would like to help more, but it's difficult without access to the
hardware. Please let me know if you find out anything.

Daniel
