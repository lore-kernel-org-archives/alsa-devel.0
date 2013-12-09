From: Daniel Mack <daniel@zonque.org>
Subject: Re: issues with usb-audio and maudio quattro
Date: Mon, 9 Dec 2013 11:41:59 +0100
Message-ID: <20131209104159.GA3711@tamtam.fritz.box>
References: <63609.101.0.71.24.1386427639.squirrel@boosthardware.com>
 <s5hiouzr94f.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id A79A9260863
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2013 11:42:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hiouzr94f.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Dec 08, 2013 at 10:21:20AM +0100, Takashi Iwai wrote:
> At Sun, 8 Dec 2013 01:47:19 +1100 (EST),
> Patrick Shirkey wrote:
> > 
> > Hi,
> > 
> > It seems that some changes were made to the usb-audio driver over the
> > years that have resulted in partially broken  behaviour with maudio
> > quattro.
> > 
> > We have run some tests on two different devices with different machines
> > and found the following items:
> > 
> > 1: There are no longer three pcm devices - this breaks previously working
> > asoundrc files
> > 2: pcm0 and pcm1 have different behaviours - this results in audio input
> > working for pcm0 but white noise in pcm1 (probably due to endianess le vs
> > be)
> > 3: We can record 4 tracks with arecord. Tracks 1/2 have audio and track
> > 3/4 have white noise
> > 4: We can no longer run 4 playback tracks in JACK2 as it complains about
> > the ports not matching (this might be a seperate issue with JACK2 and
> > route/plug configs for multichannel devices but that would probably affect
> > the delta 10/10, RME Hammerfall or other multichannel devices too.)
> > 
> > jackd: ../common/JackGraphManager.cpp:44: void
> > Jack::JackGraphManager::AssertPort(jack_port_id_t): Assertion `port_index
> > < fPortMax' failed.

I'm not sure what this warning is supposed to tell us.

> > So the main question is who made the decision to drop/consolidate the
> > third pcm and break previously working asoundrc files?
> > 
> > There must be a good reason in which case maybe we can get things working
> > again relatively easily?
> 
> I don't know of such intentional breakage.  Bisection please.

Yes, please. Also, please describe how the audio interface was exposed
before to userspace, and how it is now. The output of 'lsusb -v' would
also help.


Thanks,
Daniel
