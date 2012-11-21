From: Tomas Pospisek <tpo2@sourcepole.ch>
Subject: Re: 100.0% power usage of Device Audio codec (HDA) on
	wake
Date: Wed, 21 Nov 2012 15:15:09 +0100
Message-ID: <752ffd5c0c257045c7d8b23d95ea9ffa@sourcepole.ch>
References: <af012f839bb665744d02fa1031764767@sourcepole.ch>
 <s5hmwyhh6vg.wl%tiwai@suse.de>
 <c342c478aca9a752935a88b5b5e0d329@sourcepole.ch>
 <s5h1ufsa4aq.wl%tiwai@suse.de>
 <33f3a5d64a489d40499192a0659dd76c@sourcepole.ch>
 <50AB3A39.1090604@canonical.com> <s5hpq38ptc8.wl%tiwai@suse.de>
 <50AB45B3.6060904@canonical.com> <s5hk3tgps0x.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from brisi.sourcepole.ch (brisi.sourcepole.ch [5.9.57.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 51F25265D0D
 for <Alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 15:15:21 +0100 (CET)
In-Reply-To: <s5hk3tgps0x.wl%tiwai@suse.de>
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
Cc: Alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 20 Nov 2012 10:01:18 +0100, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue, 20 Nov 2012 09:56:19 +0100,
> David Henningsson wrote:
>> 
>> On 11/20/2012 09:32 AM, Takashi Iwai wrote:
>> > At Tue, 20 Nov 2012 09:07:21 +0100,
>> > David Henningsson wrote:
>> >>
>> >> It does put another question - from where does powertop get its
>> >> values,
>> >> and do we have to do anything on our side to make sure / aid them
>> >> being
>> >> correct?
>> >
>> > powertop checks /sys/class/sound/hwC*D*/power_{off|on}_acct files.
>> > They contain the time (in ms) how long the codec is in the power-save
>> > mode.
>> 
>> Thanks. But I have also recently seen a computer where powertop showed
a 
>> Watt number, essentially saying that the codec consumed 1.4 Watts or so

>> (I don't remember the exact number). Have you seen that too?
> 
> When 1.4W is constantly consumed even without PCM, it's a bit too
> high.  But with PCM playback, about 1W usage can be measured normally,
> I guess.

man powertop says:

--calibrate   runs powertop in calibration mode. When running on battery,
              powertop can track power consumption as well as system
              activity. When there are enough measurements,  powertop
              can  start  to  report  power  estimates.  One can get more
              accurate estimates by using this option to enable a
              calibration cycle. This will cycle through various display
              levesl and USB device activities and workloads.

So that's what powertop does I think: it estimates.
*t
