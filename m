From: John Simpson <john@swajime.com>
Subject: Playback open error: Inappropriate ioctl for device
Date: Sun, 18 Jul 2010 06:13:42 +0000
Message-ID: <AANLkTiksTz_s2bOJCZbQrJFA4XHifG5vA2mT_IGs5rVt@mail.gmail.com>
Reply-To: john@swajime.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 111AF2446F
	for <alsa-devel@alsa-project.org>;
	Sun, 18 Jul 2010 08:13:44 +0200 (CEST)
Received: by iwn39 with SMTP id 39so3654938iwn.38
	for <alsa-devel@alsa-project.org>; Sat, 17 Jul 2010 23:13:43 -0700 (PDT)
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

On 7/13/10, Clemens Ladisch <clemens@ladisch.de> wrote:
> John Simpson wrote:
>  > I've been trying to use the alsa-lib API, but I haven't been able to
>  > get anything to compile.
>  >
>  > ~/alsa/alsa-lib-1.0.22/test$ for f in *.c; do echo; cc $f 2>&1 | head -n2; done
>
> > ...
>  > Did I miss something?
>
>  The makefile.
>
>  If alsa-lib is installed correctly, the only option you need for your
>  own programs is -lasound.
>
>

Ok, now I can compile several of the test programs, but I am still not
able to generate sound.

[1|user@Nokia-N810-43-7|~/alsa-lib-1.0.23/test]cc -lasound control.c -o control
[1|user@Nokia-N810-43-7|~/alsa-lib-1.0.23/test]./control
Soundcard #1:
  card - 0
  id - 'EAC'
  driver - 'EAC'
  name - 'OMAP24xx EAC'
  longname - 'OMAP24xx EAC with codec TLV320AIC33'
  mixername - 'TLV320AIC33'
  components - ''
  PCM next device error: Inappropriate ioctl for device
  RAWMIDI next device error: Inappropriate ioctl for device
[1|user@Nokia-N810-43-7|~/alsa-lib-1.0.23/test]cc -lasound pcm.c -o pcm
[1|user@Nokia-N810-43-7|~/alsa-lib-1.0.23/test]./pcm
Playback device is plughw:0,0
Stream parameters are 44100Hz, S16_LE, 1 channels
Sine wave rate is 440.0000Hz
Using transfer method: write
Playback open error: Inappropriate ioctl for device
[1|user@Nokia-N810-43-7|~/alsa-lib-1.0.23/test]cc -lasound pcm_min.c -o pcm_min
[1|user@Nokia-N810-43-7|~/alsa-lib-1.0.23/test]./pcm_min
Playback open error: Inappropriate ioctl for device

I sure appreciate the help... I'm feeling a bit dense at the oment :-(
