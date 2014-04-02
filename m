From: andoru <andoru.blah@gmail.com>
Subject: Re:
	=?utf-8?q?Invalid_PCM_pointer_with_CMI8738_and_pcm?=
	=?utf-8?q?=2Ec_buffer=09underuns?=
Date: Wed, 2 Apr 2014 02:24:42 +0000 (UTC)
Message-ID: <loom.20140402T041705-427@post.gmane.org>
References: <CAAvHfitJ2B1sr7_6h=ww_SVGgsuy4iNLGc3CjDyiNtwdpJTSUw@mail.gmail.com>
 <533AA4F9.4040508@ladisch.de> <loom.20140401T193432-364@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 58368261A80
 for <alsa-devel@alsa-project.org>; Thu,  3 Apr 2014 15:37:46 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1WVh66-0007tD-9W
 for alsa-devel@alsa-project.org; Thu, 03 Apr 2014 14:50:22 +0200
Received: from cl-86-125-143-50.cablelink.mures.rdsnet.ro ([86.125.143.50])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Thu, 03 Apr 2014 14:50:22 +0200
Received: from andoru.blah by cl-86-125-143-50.cablelink.mures.rdsnet.ro with
 local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Thu, 03 Apr 2014 14:50:22 +0200
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


Raymond Yau wrote:
>
> >
> > Andoru wrote:
> > > The last time you replied you said that it's a hardware error. If it
> > > is that way then how come the card otherwise works flawlessly in
> > > Windows, and this doesn't happen on Debian when watching videos or
> > > with certain programs?
>
> The Linux driver seem sharing two Dma channels with at least two playback
> devices and capture device
> 
> The logic seem allow front and rear playing different audio but no capture
> Multi channel playback but no capture
> 
> open three terminals and try different combination of
> 
> speaker-test -c2 -t wav -D front

This gives me: 
___________________________________________________

speaker-test 1.0.27.2

Playback device is front
Stream parameters are 48000Hz, S16_LE, 2 channels
WAV file(s)
ALSA lib confmisc.c:768:(parse_card) cannot find card '1'
ALSA lib conf.c:4248:(_snd_config_evaluate) function snd_func_card_driver
returned error: No such file or directory
ALSA lib confmisc.c:392:(snd_func_concat) error evaluating strings
ALSA lib conf.c:4248:(_snd_config_evaluate) function snd_func_concat
returned error: No such file or directory
ALSA lib confmisc.c:1251:(snd_func_refer) error evaluating name
ALSA lib conf.c:4248:(_snd_config_evaluate) function snd_func_refer returned
error: No such file or directory
ALSA lib conf.c:4727:(snd_config_expand) Evaluate error: No such file or
directory
ALSA lib pcm.c:2239:(snd_pcm_open_noupdate) Unknown PCM front
Playback open error: -2,No such file or directory
____________________________________________________

> speaker-test -c2 -t wav -D rear

This gives me the same as above. (except the playback device is "rear" not
"front", as expected)

> arecord -f dat -D plughw:0,0

This just prints a bunch of random characters continiously unless I quit.

> speaker-test -c4 -t wav -D surround40

Same as the first issued command.

> speaker-test -c6 -t wav -D surround51

As expected... same as above.
