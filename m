From: "John Utz" <John.Utz@dmxmusic.com>
Subject: Re: what does struct snd_ac97_build_ops do? suspect i
 need a new one for the via1618 to get Surround to work
Date: Mon, 22 Jan 2007 08:50:31 -0800
Message-ID: <F8FB97052F1BEF409F7842E960E49B5ADF366B@sea-exch-01.na.corp.dmxmusic.com>
References: <F8FB97052F1BEF409F7842E960E49B5ADF3476@sea-exch-01.na.corp.dmxmusic.com>
	<s5hd557f98s.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thankyou for your thoughtful response!

-----Original Message-----
>From: Takashi Iwai [mailto:tiwai@suse.de] 
>>
>> Is 1618 6ch expected to work with ALSA 1.0.13?
>
>... only if the codec chip works without extra adjustment.
>(In other words: most likely it doesn't work as it is.)

Ok, that's what I thought and I have proceeded accordingly.

>> based on looking at ac97_codec.c: static const struct ac97_codec_id
>>snd_ac97_codec_ids
>> ,
>> 
>>  it seems to be stubbed out instead of fully implemented:
>> 
>> { 0x56494182, 0xffffffff, "VIA1618", NULL, NULL },
>> 
>> My suspicion is that I need to create the following items (hx3rd from
>> the vt1616 versions):
>> 
>> static const struct snd_kcontrol_new snd_ac97_controls_vt1618
>> 
>> static int patch_vt1618_specific(struct snd_ac97 * ac97)
>> 
>> static struct snd_ac97_build_ops patch_vt1618_ops
>> 
>> int patch_vt1618(struct snd_ac97 * ac97)
>> 
>> Am I correct in my assumptions? If so, what do these 2 arrays and 2
>> functions actually do?
>
> They set up codec-specific things and create codec-specific controls.

Ok, that's what I thought, so that's what I will create based on the via
docs.

> Honestly, I cannot tell any exact thing unless I get a datasheet of
> this codec chip.  VT1616 and 1617 have totally different configs,
> AFAIK...

That's very understandable, I appreciate hearing your thoughts! As soon
as I have something that is close to working (or I get stuck :-) ) I
will touch base with the list again.

> Takashi



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
