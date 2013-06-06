From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: hda question: 'Headphone Playback Switch' cannot
 unmute the pin's output amplifier?
Date: Thu, 6 Jun 2013 10:34:36 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F801249441@SHSMSX101.ccr.corp.intel.com>
References: <F46914AEC2663F4A9BB62374E5EEF8F801246F8D@SHSMSX101.ccr.corp.intel.com>
 <51AF2230.4070704@canonical.com>
 <F46914AEC2663F4A9BB62374E5EEF8F801248F48@SHSMSX101.ccr.corp.intel.com>
 <s5hppvzsjdh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A630261AB4
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2013 12:34:42 +0200 (CEST)
In-Reply-To: <s5hppvzsjdh.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Wang,
 Xingchao" <xingchao.wang@intel.com>, "Girdwood, Liam
 R" <liam.r.girdwood@intel.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Thursday, June 06, 2013 5:02 PM

> At Thu, 6 Jun 2013 05:39:00 +0000,
> Lin, Mengdong wrote:
> >
> > And could you give me some info about the relationship of "Master playback
> switch", "Headphone Playback Switch" and "Speaker Playback switch"?
> > I observed a close binding between "Master playback switch" and "Headphone
> Playback Switch": if I turn off one, then both will be turned off. It looks strange.
> > But the "Speaker Playback Switch" is independent from "Master playback
> switch": It can be turn on/off without affecting the "Master".
> > Both "Speaker Playback Switch" and "Headphone Playback Switch" are
> implemented by a output pin, why "Master" seems to be tied to "Headphone"?
> 
> Master is master.  If it's turned off, all belongings will be off.
> That is, if Master is muted, both speaker and headphone outputs are muted no
> matter what Speaker or Headphone element is set.

Thanks for clarification, Takashi!

Is this master-slave logic implemented in ALSA driver or lib?
 
> In the driver level, it must be have so.  If not, it's a bug.
> But for verifying the driver behavior, you should check without PulseAudio; PA
> may mute/unmute the active/inactive mixer elements dynamically.

I don't have pulseaudio running. 

Thanks
Mengdong
