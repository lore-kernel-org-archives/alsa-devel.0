From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 4/4] ALSA: dice: force to add two pcm
 devices for listed models
Date: Sun, 6 Mar 2016 23:55:21 +0100
Message-ID: <20160306235521.7aabff60@kant>
References: <1457179087-27604-1-git-send-email-o-takashi@sakamocchi.jp>
 <1457179087-27604-5-git-send-email-o-takashi@sakamocchi.jp>
 <20160305160733.6306be3f@kant> <56DC2514.2010101@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
 by alsa0.perex.cz (Postfix) with ESMTP id 609AD260592
 for <alsa-devel@alsa-project.org>; Sun,  6 Mar 2016 23:55:23 +0100 (CET)
In-Reply-To: <56DC2514.2010101@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Mar 06 Takashi Sakamoto wrote:
> On Mar 6 2016 00:07, Stefan Richter wrote:
> > On Mar 05 Takashi Sakamoto wrote:  
> >> +static bool force_two_pcm_support(struct fw_unit *unit)
> >> +{
> >> +	const char *const models[] = {
> >> +		/* TC Electronic models. */
> >> +		"StudioKonnekt48",
> >> +		/* Focusrite models. */
> >> +		"SAFFIRE PRO 40",
> >> +		"LIQUID SAFFIRE 56",
> >> +		"SAFFIRE PRO 40 1",
> >> +	};
> >> +	char model[32];
> >> +	unsigned int i;
> >> +	int err;
> >> +
> >> +	err = fw_csr_string(unit->directory, CSR_MODEL, model, sizeof(model));
> >> +	if (err < 0)
> >> +		return false;
> >> +
> >> +	for (i = 0; i < ARRAY_SIZE(models); i++) {
> >> +		if (strcmp(models[i], model) == 0)
> >> +			break;
> >> +	}
> >> +
> >> +	return i < ARRAY_SIZE(models);
> >> +}  
> > 
> > The model name of my old Saffire PRO 40 is "SAFFIRE_PRO_40", and
> > according to e.g. Alban Bernard on ffado-user, the newer model is
> > "SAFFIRE_PRO_40_1".  Saffire 56's name is "LIQUID_SAFFIRE_56"
> > according to https://forum.ubuntuusers.de/topic/focusrite-liquid/.  
> 
> OK. Thanks for your correction. I'll include them in next patchset.
> 
> Well, can this patchset enable snd-dice to drive your Saffire Pro 40
> with several isochronous streams?  (of cource, the strings should be fixed.)

I did a first few tests on 4.5.0-rc6 now.  Hardware is Saffire Pro 40 and
a XIO2213B OHCI card.  I first cherry-picked the following patches from 
tiwai/sound.git:
ALSA: dice: limit to current sampling transfer frequency
ALSA: dice: limit stream to current sampling transfer frequency.
ALSA: dice: add MIDI ports according to current number of MIDI substreams
ALSA: dice: get the number of MBLA data channel at opening PCM substream
ALSA: dice: purge generating channel cache
ALSA: dice: ensure phase lock before starting streaming
ALSA: dice: change notification mask to detect lock status change
ALSA: dice: old firmware optimization for Dice notification
ALSA: dice: drop duplex streams synchronization to transfer own time stamps

I then applied the current 4 patches, with underscores inserted into the
model names in patch 4/4.

$ arecord -l
[...]
card 2: Pro4000dd28 [Pro40-00dd28], device 0: DICE [Pro40-00dd28]
  Subdevices: 2/2
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
$ aplay -l
[...]
card 2: Pro4000dd28 [Pro40-00dd28], device 0: DICE [Pro40-00dd28]
  Subdevices: 2/2
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1

I tested capture and playback at 44100 and 48000 Hz at both subdevices,
i.e. on plughw:2,0,0 and plughw:2,0,1 and it seems to work.  I only really
checked subdevice 0 with I/O other than silence because I am not currently
prepared to ADAT.  (As you remember there are only ADAT channels on the
second stream.  Given some time I can probably arrange for another ADAT
capable device to transmit and receive via ADAT.)

Then I also tried 88200 and 96000 Hz.  This gives 16+16 channels at
subdevice #0 like it should, and capture works, but playback is mute.

I have not yet checked whether the muted playback at 88200/96000 is a
consequence of these 4 new patches, or has been introduced earlier, or has
always been the case with snd-dice.  (I haven't done many systematic tests
with the Pro 40 and snd-dice yet.  If I unload snd-dice and use FFADO,
playback at 88200/96000 works.)

Furthermore I did a few quick tests with the entire patchset and Saffire
PRO 24 (which uses only 1+1 transmitter+receiver, and consequently is
shown only as 1+1 subdevice).  I tried 48000 and 96000 Hz, and capture
and playback works at both sampling rates.  IOW the PRO 40's muting
problem is not afflicting the PRO 24.

Next thing for me to do will be to remove patches and figure out whether
a previous driver revision gives me unmuted playback at 96000 Hz on the
PRO 40. 
-- 
Stefan Richter
-======----- --== --==-
http://arcgraph.de/sr/
