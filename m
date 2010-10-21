From: Fredrik Lingvall <fl@ifi.uio.no>
Subject: RME MADIface 192 kHz problem
Date: Thu, 21 Oct 2010 15:03:29 +0200
Message-ID: <4CC03A21.2050406@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id A1CC71037EE
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Oct 2010 15:03:58 +0200 (CEST)
Received: by ewy22 with SMTP id 22so20423ewy.38
	for <alsa-devel@alsa-project.org>; Thu, 21 Oct 2010 06:03:58 -0700 (PDT)
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

 Hi all,

I have a problem running the RME MADIface card at 192 kHz. At that
speed the number of channels for the card is reduced to 16. I can set
the sampling rate to 192 kHz using:

# amixer -c 1 cset numid=2 9
numid=2,iface=MIXER,name='Sample Clock Source'
  ; type=ENUMERATED,access=rw------,values=1,items=10
  ; Item #0 'AutoSync'
  ; Item #1 'Internal 32.0 kHz'
  ; Item #2 'Internal 44.1 kHz'
  ; Item #3 'Internal 48.0 kHz'
  ; Item #4 'Internal 64.0 kHz'
  ; Item #5 'Internal 88.2 kHz'
  ; Item #6 'Internal 96.0 kHz'
  ; Item #7 'Internal 128.0 kHz'
  ; Item #8 'Internal 176.4 kHz'
  ; Item #9 'Internal 192.0 kHz'
  : values=9

but when I try to read data at 192 kHz I always get a :

Invalid argument

from

the snd_pcm_hw_params_set_channels(...)

and

snd_pcm_hw_params(...)

functions when I try to set the number of channels. The

snd_pcm_hw_params_get_channels_max(...)
snd_pcm_hw_params_get_channels_min(...)

functions also seems to return the wrong number of max and min number
of channels.

And, jackd will not start using 192 kHz. See the thread here:
http://www.rme-audio.de/forum/viewtopic.php?id=9169

What is needed to get this card running at 192 kHz?

Regards,

/Fredrik


-- 
Fredrik Lingvall, PhD                                                              
E-mail: fl@ifi.uio.no, fredrik.lingvall@gmail.com
Web:    http://folk.uio.no/fl/
