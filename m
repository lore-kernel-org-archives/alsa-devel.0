From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: wrong decibel data?
Date: Fri, 28 May 2010 10:04:16 +0800
Message-ID: <AANLkTinL8ta5UbFJzQeTS_4xuYHRPy9CDF51ZjNfp4tz@mail.gmail.com>
References: <q2s98391a7b1004021121sde36d074m8a70acc142f95d93@mail.gmail.com>
	<q2t98391a7b1004021325jbc9e7ddal26063e490fe69254@mail.gmail.com>
	<hp744t$5b5$1@dough.gmane.org>
	<r2y4f3252891004160648xa8590219i359286b5a9dece4f@mail.gmail.com>
	<hqbv5m$cmf$1@dough.gmane.org>
	<g2t4f3252891004201932k53dae8a1me8f7e968f8a28b5b@mail.gmail.com>
	<hqmbmm$hsj$1@dough.gmane.org>
	<i2r4f3252891004211816ldfedff21nfe61537043c9b22f@mail.gmail.com>
	<htls4d$phr$1@dough.gmane.org> <4BFE7840.4070004@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) by alsa0.perex.cz (Postfix) with ESMTP id 021F92444A
	for <alsa-devel@alsa-project.org>;
	Fri, 28 May 2010 04:04:17 +0200 (CEST)
Received: by pvc22 with SMTP id 22so339254pvc.38
	for <alsa-devel@alsa-project.org>; Thu, 27 May 2010 19:04:16 -0700 (PDT)
In-Reply-To: <4BFE7840.4070004@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/5/27 Clemens Ladisch <clemens@ladisch.de>

> Colin Guthrie wrote:
> > state.Intel {
> >       control.1 {
> >               comment.access 'read write'
> >               comment.type INTEGER
> >               comment.count 2
> >               comment.range '0 - 31'
> >               comment.dbmin -4650
> >               comment.dbmax 0
> >               iface MIXER
> >               name 'Master Playback Volume'
> >               value.0 30
> >               value.1 30
> >       }
>
> This is the hardware volume control.
>
> >       control.11 {
> >               comment.access 'read write user'
> >               comment.type INTEGER
> >               comment.count 2
> >               comment.range '0 - 255'
> >               comment.tlv '0000000100000008ffffec1400000014'
> >               comment.dbmin -5100
> >               comment.dbmax 0
> >               iface MIXER
> >               name 'PCM Playback Volume'
> >               value.0 253
> >               value.1 253
> >       }
>
> This is the emulated software volume control that is created by the
> softvol plugin.  This control gets recreated by "alsactl restore" even
> when the plugin is not running.
>
> Might it be possible that PA is trying to use this, but that it doesn't
> have any effect because PA is using PCM device hw:0?  (Try unloading
> snd-hda-intel and then deleting that entry from /etc/asound.state.)
>
>
> Regards,
> Clemens
>

if I make a customised device "test" with softvol plugin with name "P
Playback Volume" in .asounrd

aplay -D test.wav

alsamixer -c0 show the "P" control and volume change as expected

Then change the name from "P Playback Volume" to "Q Playack Volume" and play
audio through device "test" again

alsamixer -c0 show both "P" and "Q" controls

"P" control can go up/down with no effect of course

but "Q" stayed at 100%

Is this a bug ?
