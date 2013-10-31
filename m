From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: Realtek HD-A codec ALC262: How to unmute mixer
 node 0x24 Amp-In for Mic Pin 0x18
Date: Thu, 31 Oct 2013 08:14:30 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F8013DDEFB@SHSMSX101.ccr.corp.intel.com>
References: <F46914AEC2663F4A9BB62374E5EEF8F8013DDC28@SHSMSX101.ccr.corp.intel.com>
 <s5hvc0dj34w.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F8013DDEBC@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 109CF2655DA
 for <alsa-devel@alsa-project.org>; Thu, 31 Oct 2013 09:14:34 +0100 (CET)
In-Reply-To: <F46914AEC2663F4A9BB62374E5EEF8F8013DDEBC@SHSMSX101.ccr.corp.intel.com>
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
To: Kailang <kailang@realtek.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Kailang,

I followed your suggestion to select Rear Mic (Mic Pin 0x18) to the Input Source (node 0x07) in alsamixer. Then the mixer node 0x24 unmute 0x18, and recording works.

Many thanks!
Mengdong

> -----Original Message-----
> From: alsa-devel-bounces@alsa-project.org
> [mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of Lin, Mengdong
> Sent: Thursday, October 31, 2013 4:09 PM
> To: Takashi Iwai
> Cc: Pshou; alsa-devel@alsa-project.org; Kailang
> Subject: Re: [alsa-devel] Realtek HD-A codec ALC262: How to unmute mixer
> node 0x24 Amp-In for Mic Pin 0x18
> 
> > -----Original Message-----
> > From: Takashi Iwai [mailto:tiwai@suse.de]
> > Sent: Thursday, October 31, 2013 3:45 PM
> > To: Lin, Mengdong
> > Cc: alsa-devel@alsa-project.org; Kailang; Pshou
> > Subject: Re: [alsa-devel] Realtek HD-A codec ALC262: How to unmute
> > mixer node 0x24 Amp-In for Mic Pin 0x18
> >
> > At Thu, 31 Oct 2013 06:17:29 +0000,
> > Lin, Mengdong wrote:
> > >
> > > Hi,
> > >
> > > We found when recording on ALC262, the audio mixer node 0x24 mutes
> > > the
> > input from Mic Pin node 0x18, so we get silent data.
> > > Would someone please give me some advice to solve this?
> > >
> > > Node 0x24 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
> > >   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
> > >   Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x00 0x00] [0x80 0x80]
> > > [0x80 0x80]
> > [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
> > >   Connection: 9
> > >      0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x0b
> > >
> > > I cannot find user-space amixer controls to unmute node 0x18.
> > >
> > > The recording data flows from Mic Pin 0x18 -> Mixer 0x24 -> audio input
> 0x07.
> > The Amp-In value on pin 0x18 (Rear Mic Boost) and input 0x07 (Capture
> > Volume) are okay.
> >
> > Too little hardware information.  Please give alsa-info.sh output at
> > least.  In the output above, 0x1a is chosen as the active input path,
> > so the driver looks working as expected somehow.
> 
> Yes. The driver is okay. I need to select the input pin for the mixer, as Kailang
> suggested.
> 
> Thanks
> Mengdong
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
