From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 4/4] ALSA: dice: force to add two pcm
 devices for listed models
Date: Mon, 7 Mar 2016 11:57:21 +0900
Message-ID: <56DCEE11.7030204@sakamocchi.jp>
References: <1457179087-27604-1-git-send-email-o-takashi@sakamocchi.jp>
 <1457179087-27604-5-git-send-email-o-takashi@sakamocchi.jp>
 <20160305160733.6306be3f@kant> <56DC2514.2010101@sakamocchi.jp>
 <20160306235521.7aabff60@kant> <20160307012442.6935bc04@kant>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id A2CAD2605C3
 for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2016 03:57:24 +0100 (CET)
In-Reply-To: <20160307012442.6935bc04@kant>
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

Hi Stefan,

On Mar 7 2016 7:55, Stefan Richter wrote:
 > $ arecord -l
 > [...]
 > card 2: Pro4000dd28 [Pro40-00dd28], device 0: DICE [Pro40-00dd28]
 >   Subdevices: 2/2
 >   Subdevice #0: subdevice #0
 >   Subdevice #1: subdevice #1
 > $ aplay -l
 > [...]
 > card 2: Pro4000dd28 [Pro40-00dd28], device 0: DICE [Pro40-00dd28]
 >   Subdevices: 2/2
 >   Subdevice #0: subdevice #0
 >   Subdevice #1: subdevice #1
 >
 > I tested capture and playback at 44100 and 48000 Hz at both
 > subdevices, i.e. on plughw:2,0,0 and plughw:2,0,1 and it seems to
 > work.  I only really checked subdevice 0 with I/O other than silence
 > because I am not currently prepared to ADAT.  (As you remember there
 > are only ADAT channels on the second stream.  Given some time I can
 > probably arrange for another ADAT capable device to transmit and
 > receive via ADAT.)
 >
 > Then I also tried 88200 and 96000 Hz.  This gives 16+16 channels at
 > subdevice #0 like it should, and capture works, but playback is mute.
 >
 > I have not yet checked whether the muted playback at 88200/96000 is a
 > consequence of these 4 new patches, or has been introduced earlier,
 > or has always been the case with snd-dice.  (I haven't done many
 > systematic tests with the Pro 40 and snd-dice yet.  If I unload
 > snd-dice and use FFADO, playback at 88200/96000 works.)
 >
 > Furthermore I did a few quick tests with the entire patchset and
 > Saffire PRO 24 (which uses only 1+1 transmitter+receiver, and
 > consequently is shown only as 1+1 subdevice).  I tried 48000 and
 > 96000 Hz, and capture and playback works at both sampling rates.  IOW
 > the PRO 40's muting problem is not afflicting the PRO 24.

On Mar 7 2016 09:24, Stefan Richter wrote:
> On Mar 06 Stefan Richter wrote:
> [...]
>> Then I also tried 88200 and 96000 Hz.  This gives 16+16 channels at
>> subdevice #0 like it should, and capture works, but playback is mute.
> [...]
>> Next thing for me to do will be to remove patches and figure out whether
>> a previous driver revision gives me unmuted playback at 96000 Hz on the
>> PRO 40.
>
> Plain v4.5-rc6 gave me unmuted playback at 88200/96000 Hz once, but it was
> distorted by some sort of high clinking.  Other times plain v4.5-rc6 had
> muted playback at 88200/96000 Hz too.
>
> I tested with mplayer+jack+alsa, audacious+jack+alsa, and
> audacious+alsa.

Thanks for your report. Totally:
  * The patched snd-dice still works fine with Saffire Pro 24.
  * The pached snd-dice successfully manages several isochronous streams
    without code bugs (i.e. kernel NULL pointer dereference or
    continuous locking).
  * The pached snd-dice still has mute issue for Saffire Pro 40.

Anyway, the result cannot block applying this patchset for 4.6. I'll 
post it in this night for merging.


Well, about the mute issue, I have no idea to fix it at all. At least, 
for my test units, the patched snd-dice works fine without such issues. 
Therefore, it's nearly model-dependent issue and I have no way to do for 
it. FYI, I tested with:
  * OHCI 1394 host controllers
   * VIA VT6315
   * TI XIO2213
  * Dice II units
   * TC Electronic ImpactTwin
   * TC Electronic Konnekt24D
   * TC Electronic Konnekt8
* Dice Jr. units
   * TC Electronic DesktopKonnect6
* Dice Mini units
   * Focusrite Saffire Pro 26


Regards

Takashi Sakamoto
