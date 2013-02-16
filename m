From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: HDA regression on Fujitsu S7020 laptop (ALC260
 codec)
Date: Sat, 16 Feb 2013 21:55:05 +1030
Message-ID: <20130216112505.GE4164@marvin.atrad.com.au>
References: <20130104042423.GD15726@marvin.atrad.com.au>
 <CAN8cciYhydz6e6oz2QU4NeQgWsJU+4BQrhW6CK1tYd_+4E6pBw@mail.gmail.com>
 <20130105031254.GD11016@marvin.atrad.com.au>
 <CAN8ccib6xbxAjpNXzxQQGVSo9vuNNPU7NdB7FPFWaNCXLpn+Gw@mail.gmail.com>
 <20130105071605.GA11323@marvin.atrad.com.au>
 <s5hvcb7ohly.wl%tiwai@suse.de>
 <20130113043936.GA8822@marvin.atrad.com.au>
 <s5h8v7xjw4f.wl%tiwai@suse.de>
 <20130210114707.GA26574@marvin.atrad.com.au>
 <s5hzjzbql3a.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
 by alsa0.perex.cz (Postfix) with ESMTP id DAA6F260783
 for <alsa-devel@alsa-project.org>; Sat, 16 Feb 2013 12:25:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hzjzbql3a.wl%tiwai@suse.de>
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
Cc: Raymond Yau <superquad.vortex2@gmail.com>, alsa-devel@alsa-project.org, jwoithe@just42.net, peter.golden@btinternet.com
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 11, 2013 at 10:02:49AM +0100, Takashi Iwai wrote:
> > I'm now back from linux.conf.au and would like to pick up this issue.  Given
> > that several weeks have elapsed since we last touched base, what would now
> > be the best tree to test to determine where we are at and what the next
> > steps should be to restoring the previous functionality for the Fujitsu
> > S7020 laptop?
> 
> Try sound.git tree for-next branch.  It already contains all stuff for
> 3.9 kernel.

I've been able to test this (snapshot as of two days ago, reports version
number 3.8.0-rc5+ via uname).  As expected there have been some
improvements.

Things which work:

 * "Headphone Jack Mode" allows switching between "Headphone" and "Line
   out".  Both of these mode settings appear to work.

 * There are separate "Headphone" and "Speaker" volume controls.

 * The "Headphone" volume control influences the headphone jack volume.

 * An "Auto-Mute Mode" control appears in alsamixer (it was missing on
   earlier versions).

 * Alsamixer recognises the presence of two ADCs, giving "Capture" and
   "Capture 1" controls, with corresponding "Input Source" controls.

Things which don't work or are missing:

 * "Headphone Jack Mode" lacks options to enable various "mic" or "line in"
   modes (all of which are possible on this system)

 * The "Input source" controls don't offer the "headphone jack" as a
   possible source.

 * The built-in speaker is completely silent under all situations I have
   come up with.  The setting of "Auto-Mute Mode" has no effect, neither
   does a manual unmute of the "Speaker" volume control.  While I don't
   personally care much about this I suspect others might.

 * As eluded to above, the "Auto-Mute Mode" control appears to do nothing.

 * There's no "Mic Jack Mode" control to control the mode of the "mic" jack.
   This jack supports line-in mode as well as the various "mic" modes which
   give varying bias voltages.

Is there further information I could provide or other tests I could do to
help address the "don't work or are missing" items?

Regards
  jonathan
