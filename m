From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 05/15] ALSA: dice: Add support for
	MIDI	capture/playback
Date: Mon, 08 Dec 2014 09:50:10 +0900
Message-ID: <5484F5C2.9080801@sakamocchi.jp>
References: <1417958348-30333-1-git-send-email-o-takashi@sakamocchi.jp>
 <1417958348-30333-6-git-send-email-o-takashi@sakamocchi.jp>
 <5484CA3D.5070004@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id EFFB72605D3
 for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2014 01:50:15 +0100 (CET)
In-Reply-To: <5484CA3D.5070004@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Dec 8 2014 06:44, Clemens Ladisch wrote:
> Takashi Sakamoto wrote:
>> This commit adds a support for MIDI capture/playback
>>
>> +++ b/sound/firewire/dice/dice-midi.c
>> +static int capture_open(struct snd_rawmidi_substream *substream)
>> +{
>> ...
>> +}
>> +
>> +static int playback_open(struct snd_rawmidi_substream *substream)
>> +{
>> ...
>> +}
> 
> These two functions are identical.
> 
>> +static int capture_close(struct snd_rawmidi_substream *substream)
>> +{
>> ...
>> +}
>> +
>> +static int playback_close(struct snd_rawmidi_substream *substream)
>> +{
>> ...
>> +}
> 
> These two too.

Indeed. We can use the same functions for each of MIDI open/close callback.

>> +static void set_midi_substream_names(struct snd_dice *dice,
>> +				     struct snd_rawmidi_str *str)
>> +{
>> +	list_for_each_entry(subs, &str->substreams, list) {
>> +		snprintf(subs->name, sizeof(subs->name),
>> +			 "%s MIDI %d", dice->card->shortname, subs->number + 1);
> 
> This is not really important, but the number is useless when the
> device has only one MIDI port.

Fireworks/BeBoB/Dice/OXFW drivers have the same codes to name MIDI
ports. So I want to change them in the same time, later.

This below code is for your idea.

static void set_midi_substream_names(const char *shortname,
                                     struct snd_rawmidi_str *str)
{
    struct snd_rawmidi_substream *subs;

    list_for_each_entry(subs, &str->substreams, list) {
        if (str->substream_count == 1) {
                snprintf(subs->name, sizeof(subs->name),
                     "%s MIDI", shortname);
                break;
        }

        snprintf(subs->name, sizeof(subs->name),
                     "%s MIDI %d", shortname, subs->number + 1);
    }
}

Hmm. I can see the 'shortname' again...

If I apply "vendor model" template for the shortname, the length of MIDI
ports are too long for MIDI port name. For example,

$ cat /proc/asound/card0/midi0
Echo Digital Audio AudioFire4 MIDI
...

$ amidi -lDir Device    Name
IO  hw:0,0,0  Echo Digital Audio AudioFire4 M(trimmed)

Currently I apply "vendor model" template for OXFW driver only, but I
should reconsider about this...


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp
