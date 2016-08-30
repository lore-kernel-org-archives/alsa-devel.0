From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: Re: No sound for several minutes after reboot
Date: Tue, 30 Aug 2016 11:20:50 +0200
Message-ID: <20160830092050.GA313@x4>
References: <20160829085653.GA306@x4> <20160829090548.GA314@x4>
 <s5hk2f0szne.wl-tiwai@suse.de> <20160829092047.GB314@x4>
 <s5hh9a3udhn.wl-tiwai@suse.de> <20160829120659.GA305@x4>
 <20160829140233.GA857@x4> <s5hbn0a3cow.wl-tiwai@suse.de>
 <20160830083201.GA5031@x4> <s5h7fay39y8.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.ud10.udmedia.de (ud10.udmedia.de [194.117.254.50])
 by alsa0.perex.cz (Postfix) with ESMTP id EE8AB266B01
 for <alsa-devel@alsa-project.org>; Tue, 30 Aug 2016 11:20:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h7fay39y8.wl-tiwai@suse.de>
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

On 2016.08.30 at 11:03 +0200, Takashi Iwai wrote:
> On Tue, 30 Aug 2016 10:32:01 +0200,
> Markus Trippelsdorf wrote:
> > 
> > On 2016.08.30 at 10:04 +0200, Takashi Iwai wrote:
> > > On Mon, 29 Aug 2016 16:02:33 +0200,
> > > Markus Trippelsdorf wrote:
> > > > 
> > > > On 2016.08.29 at 14:06 +0200, Markus Trippelsdorf wrote:
> > > > > On 2016.08.29 at 11:32 +0200, Takashi Iwai wrote:
> > > > > > On Mon, 29 Aug 2016 11:20:47 +0200,
> > > > > > Markus Trippelsdorf wrote:
> > > > >  output:ALSA def-222   [003] ....   422.035002: hda_send_cmd: [0000:00:14.2:0] val=0x01570d01
> > > > >  output:ALSA def-222   [003] ....   422.035061: hda_get_response: [0000:00:14.2:0] val=0x00000000
> > > > 
> > > > Actually it right here that sound starts again:
> > > > 
> > > > markus@x4 hda-emu % ./a.out 0x01570d01
> > > > raw value = 0x01570d01
> > > > cid = 0, nid = 0x15, verb = 0x70d, parm = 0x01
> > > > raw value: verb = 0x70d, parm = 0x1
> > > > verbname = set_digi_cvt_1
> > > 
> > > So, the program itself sets the value.  Which sound backend are you
> > > using?  PulseAudio, whatever?
> > 
> > No backend at all. I use mpd directly on type hw:
> > 
> > pcm.!default {
> >   type hw
> >   card 0
> >   device 3
> > }
> 
> Hmm, it's assigned to device 3?
> This was supposed to be assigned to HDMI/DP.
> 
> In anyway, for device 3, you can use
> 
>   pcm.!default "hdmi:0"
> 
> Then the IEC958 status parameter is set via alsa-lib properly.

Many thanks. This works fine.

-- 
Markus
