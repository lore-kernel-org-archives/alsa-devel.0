From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: hda question: 'Headphone Playback Switch' cannot
 unmute the pin's output amplifier?
Date: Thu, 6 Jun 2013 05:39:00 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F801248F48@SHSMSX101.ccr.corp.intel.com>
References: <F46914AEC2663F4A9BB62374E5EEF8F801246F8D@SHSMSX101.ccr.corp.intel.com>
 <51AF2230.4070704@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 91DFE265515
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2013 07:39:05 +0200 (CEST)
In-Reply-To: <51AF2230.4070704@canonical.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "Wang,
 Xingchao" <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: David Henningsson [mailto:david.henningsson@canonical.com]
> Sent: Wednesday, June 05, 2013 7:34 PM
 
> On 06/05/2013 01:06 PM, Lin, Mengdong wrote:
> > Hi,
> >
> > I'm using a Realtek HD-A codec ALC282. But the headphone output amplifier is
> always muted and I cannot unmute it by amixer.
> >
> > I tried to unmute the pin via control 'Headphone Playback Switch', but
> snd_hda_mixer_amp_switch_put() gets a ZERO value from
> ucontrol->value.integer.value, thus the pin will be muted.
> > Could somebody give me some tips to further check this issue? Many thanks!
> 
> Maybe there's also a "Master playback switch" that needs to be turned on as
> well?

Many thanks, David! This works. I need to turn on "Master playback switch" as well.

And could you give me some info about the relationship of "Master playback switch", "Headphone Playback Switch" and "Speaker Playback switch"?
I observed a close binding between "Master playback switch" and "Headphone Playback Switch": if I turn off one, then both will be turned off. It looks strange.
But the "Speaker Playback Switch" is independent from "Master playback switch": It can be turn on/off without affecting the "Master". 
Both "Speaker Playback Switch" and "Headphone Playback Switch" are implemented by a output pin, why "Master" seems to be tied to "Headphone"?

Is this behavior a designed result, user preference, or codec H/W restriction?

Thanks
Mengdong

> >
> > Here are the headphone pin info:
> > Node 0x21 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
> >    Control: name="Headphone Playback Switch", index=0, device=0
> >      ControlAmp: chs=3, dir=Out, idx=0, ofs=0
> >    Control: name="Headphone Jack", index=0, device=0
> >    Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
> >    Amp-Out vals:  [0x80 0x80]
> >    Pincap 0x0000001c: OUT HP Detect
> >    Pin Default 0x0321401f: [Jack] HP Out at Ext Left
> >      Conn = 1/8, Color = Green
> >      DefAssociation = 0x1, Sequence = 0xf
> >    Pin-ctls: 0xc0: OUT HP
> >    Unsolicited: tag=01, enabled=1
> >    Power states:  D0 D1 D2 D3 EPSS
> >    Power: setting=D0, actual=D0
> >    Connection: 2
> >       0x0c 0x0d*
> >
> > Here is the pin's controls listed by amixer:
> > numid=2,iface=MIXER,name='Headphone Playback Switch'
> >
> > Then I use this command to unmute the pin's amplifier:
> > amixer -c 1 cset numid=2,iface=MIXER,name='Headphone Playback Switch'
> > on
> >
> > My debug message show that snd_hda_mixer_amp_switch_put() gets zero
> value , indicating to 'mute':
> > [  346.263519] snd_hda_mixer_amp_switch_put: nid 0x0021, chs 3,
> > control value [0x00000000, 0x00000000] [  346.263527]
> > snd_hda_codec_amp_update: nid 0x0021 [  346.263532]
> codec_amp_update:
> > nid 0x0021, ch 0, direction 1 (OUT 1), index 0, val 0x00000080 [
> > 346.263536] codec_amp_update: amp val not change [  346.263538]
> > snd_hda_codec_amp_update: nid 0x0021 [  346.263542]
> codec_amp_update:
> > nid 0x0021, ch 1, direction 1 (OUT 1), index 0, val 0x00000080 [
> > 346.263544] codec_amp_update: amp val not change
> >
> > Thanks
> > Mengdong
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >
> 
> 
> 
> --
> David Henningsson, Canonical Ltd.
> https://launchpad.net/~diwic
