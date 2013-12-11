From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: HD-audio runtime PM
Date: Wed, 11 Dec 2013 05:37:44 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F8014339B3@SHSMSX101.ccr.corp.intel.com>
References: <s5hli0gmyxt.wl%tiwai@suse.de>
 <CA+v+29hKbtTBLh=qNRBVqd-NUfXRVBBokoypDh_0RMRQ_VjYvw@mail.gmail.com>
 <s5hiovfy9ji.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F80141992D@SHSMSX101.ccr.corp.intel.com>
 <s5ha9gry640.wl%tiwai@suse.de>	<s5hzjorwouu.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F80141CF98@SHSMSX101.ccr.corp.intel.com>
 <s5heh626rnh.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F80141D1C7@SHSMSX101.ccr.corp.intel.com>
 <F46914AEC2663F4A9BB62374E5EEF8F80142FA38@SHSMSX101.ccr.corp.intel.com>
 <F46914AEC2663F4A9BB62374E5EEF8F801432212@SHSMSX101.ccr.corp.intel.com>
 <s5hwqjchozq.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F801432305@SHSMSX101.ccr.corp.intel.com>
 <s5htxeghjf1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 130F12615EE
 for <alsa-devel@alsa-project.org>; Wed, 11 Dec 2013 09:08:10 +0100 (CET)
In-Reply-To: <s5htxeghjf1.wl%tiwai@suse.de>
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
Cc: "Alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Wang Xingchao <wangxingchao2011@gmail.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Tuesday, December 10, 2013 10:26 PM

> > > > HW team clarified that HDMI/DP jack insertion cannot wake up the
> > > controller from D3. So this is a HW restriction for Haswell, not a
> > > driver regression.
> > > >
> > > > Now the problem on Haswell/Broadwell is:
> > > > After the controller enters D3, Gfx driver can still detect
> > > > HDMI/DP hot
> > > plug event even if the display power well is disabled.
> > > > Although Gfx driver set Presence Detect and ELD Valid , the audio
> > > controller does not wake up and so audio driver has no idea about
> > > the HDMI/DP hot-plug.
> > > >
> > > > Is it audio driver itself or the user space that need this ELD info?
> > > > Maybe Gfx driver can directly report ELD info to user space.
> > >
> > > If so, the graphics driver can wake up the audio driver as well --
> > > this is yet one more reason to create a direct communication channel
> > > between the graphics and audio drivers :)
> >
> > Need the audio driver provide an API for gfx driver?
> > Maybe this API can call snd_hda_power_up(codec) and then
> > snd_hda_power_down(codec), thus the controller and codec will wake
> up and audio driver can check ELD info.
> 
> Well, we can create a common object containing the ops registered by
> both graphics and audio drivers, then communicate through it, something
> like vga_switcheroo.

Hi Takashi,

I'm sure how to use a common object like vga_switcheroo. Would you please share more info?

I feel a wake up process may be like this:
- Gfx driver detects the hot-plug at first and notify audio driver by the communication channel.
- In the notification callback, the audio driver wakes up the audio controller to D0, but codec can still stay in D3. 
 (Hope we can add a time out for controller here to avoid controller back to D3 at once and lose the capability to check unsol event)
- Then when Gfx driver enables or disables audio, and the audio controller can receive the unsol event in D0.
- Audio driver check ELD in unsol event handler, this will make codec resume to D0.

Regards
Mengdong
