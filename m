From: "siickwkc@gmail.com" <siickwkc@gmail.com>
Subject: Fwd: Re: About your snd-firewire-improve
Date: Fri, 04 Jul 2014 12:58:18 +0200
Message-ID: <53B688CA.9020105@gmail.com>
References: <53AEE210.3000201@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f50.google.com (mail-wg0-f50.google.com [74.125.82.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 53F5426587F
 for <alsa-devel@alsa-project.org>; Fri,  4 Jul 2014 12:58:23 +0200 (CEST)
Received: by mail-wg0-f50.google.com with SMTP id x13so463631wgg.21
 for <alsa-devel@alsa-project.org>; Fri, 04 Jul 2014 03:58:23 -0700 (PDT)
Received: from [192.168.0.46] (gai69-4-82-228-194-100.fbx.proxad.net.
 [82.228.194.100])
 by mx.google.com with ESMTPSA id i4sm77928647wib.21.2014.07.04.03.58.20
 for <alsa-devel@alsa-project.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Fri, 04 Jul 2014 03:58:21 -0700 (PDT)
In-Reply-To: <53AEE210.3000201@sakamocchi.jp>
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




-------- Message original --------
Sujet: 	Re: About your snd-firewire-improve
Date : 	Sun, 29 Jun 2014 00:41:04 +0900
De : 	Takashi Sakamoto <o-takashi@sakamocchi.jp>
Pour : 	siickwkc@gmail.com <siickwkc@gmail.com>



Hi Siick,

(Jun 28 2014 20:18), siickwkc@gmail.com wrote:
> Firstly, sorry for my english, i'm a french so i will make some mistakes.

Don't worry. I'm also not good at english because I'm Japanese.

> I'm a ubuntu long time user and i have a M-audio firewire audiophile for
> MAO. Right now, i can just use it on Windows. That's why your project
> have my interest.

M-Audio Firewire Audiophile is one of my test devices. It means I own it
and use it to debug my drivers. As long as I know, my driver (snd-bebob)
can drive it.

> I've installed like you explain it on you readme file here >
> https://github.com/takaswie/snd-firewire-improve

You can also use DKMS package from David Henningsson's PPA. He's a
developer for ALSA/Pulseaudio and familiar with my developing. This
package is for trusty.
https://launchpad.net/~diwic/+archive/snd-firewire-improve

> And now when i switch on my firewire souncard, it's different, it seems
> to "work" because i don't have flashing light as usual.
> I switch on, lights flash, and then it turns blue without flashing, like
> on windows.

It's correct behaviour. In detail, please see these patches:
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-April/075885.html
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-April/075888.html

> But now i try to make it works with audacious and it doesn't.
> I try to configure audacious with ALSA out but in parameters all
> firewire device listed seems don't work....

About "snd_mixer_find_selem failed" message, this behaviour is correct
because my drivers don't have ALSA Control Interface. This means users
cannot control internal mixer via ALSA applications such like alsamixer.

For this purpose, please use ffado-dbus-server/ffado-mixer. But Ubuntu
package for FFADO is a bit old. I upload the package with latest source
in my PPA for trusty.
https://launchpad.net/~mocchi/+archive/instruments

Or you should use upstream source.
http://subversion.ffado.org/wiki/InstallingFfadoFromSource

If you're successful to install, you can see GUI such like in this page:
http://subversion.ffado.org/wiki/MaudioBebob

About "snd_pcm_hw_params_set_channels failed", this behaviour is correct
to your device because AudioPhile can just playback 6ch PCM, while you
try to playback 2ch PCM. There is a mismatch of channels.

Instead of using "hw:2,0" PCM device, use "plughw:2,0" PCM device. This
PCM device can arrange channels and solve the mismatch.

> I'm not familiar with all audio stuff on Linux, maybe i've done
> something wrong?
> I attached you screenshot maybe it can help....
> Thanks for your reading and your future answer.

No, you did correct things. Thanks for your report.

If possible, would you please post your questions to alsa-devel? I
believe our conversation may help to the other users.
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp
