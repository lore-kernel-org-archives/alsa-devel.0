From: Ashecrow <ashecrow42@free.fr>
Subject: Re: [PATCH] ALSA: hda - hdmi: Fallback to ALSA
	allocation when selecting CA
Date: Mon, 9 Sep 2013 20:20:59 +0200
Message-ID: <69179FE2-37F6-4CAA-AA7D-FDC20B45AC58@free.fr>
References: <1378035407-29536-1-git-send-email-anssi.hannula@iki.fi>
 <s5hy57fbcf7.wl%tiwai@suse.de> <90F283E1-F425-4818-9A03-AAED8DB5547B@free.fr>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 663A82650E7
 for <alsa-devel@alsa-project.org>; Mon,  9 Sep 2013 20:21:17 +0200 (CEST)
In-Reply-To: <90F283E1-F425-4818-9A03-AAED8DB5547B@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Anssi Hannula <anssi.hannula@iki.fi>
Cc: Frank Zafka <kafkaesque1978@gmail.com>, alsa-devel@alsa-project.org, wxc200@gmail.com, stable@vger.kernel.org, =?iso-8859-1?Q?Peter_Fr=FChberger?= <fritsch@xbmc.org>
List-Id: alsa-devel@alsa-project.org

Hi guys,
Let me tell you, you rock!!!!
I have compiled kernel sources from Linus master branch in his GIT repo and=
 it works flawlessly, I now have DTS-HD MSTR.

Thanks Anssi for your great work!
Thanks to any one who contributed to it.
I can't believe I've struggled for so many months and only 8 lines of kerne=
l code fix it.

Hail ALSA and hail Linux :), I now have the perfect media center


Le 6 sept. 2013 =E0 10:43, Ashecrow a =E9crit :

> Hi guys,
> Anssi, thank you very much for your work! I'll test the patch asap and I'=
ll keep you posted.
> =

> Takashi, where can I get patched kernel sources, or on which branch do I =
apply the patch to?
> =

> Thanks
> Etienne
> =

> Le 2 sept. 2013 =E0 15:06, Takashi Iwai <tiwai@suse.de> a =E9crit :
> =

>> At Sun,  1 Sep 2013 14:36:47 +0300,
>> Anssi Hannula wrote:
>>> =

>>> hdmi_channel_allocation() tries to find a HDMI channel allocation that
>>> matches the number channels in the playback stream and contains only
>>> speakers that the HDMI sink has reported as available via EDID. If no
>>> such allocation is found, 0 (stereo audio) is used.
>>> =

>>> Using CA 0 causes the audio causes the sink to discard everything except
>>> the first two channels (front left and front right).
>>> =

>>> However, the sink may be capable of receiving more channels than it has
>>> speakers (and then perform downmix or discard the extra channels), in
>>> which case it is preferable to use a CA that contains extra channels
>>> than to use CA 0 which discards all the non-stereo channels.
>>> =

>>> Additionally, it seems that HBR (HD) passthrough output does not work on
>>> Intel HDMI codecs when CA is set to 0 (possibly the codec zeroes
>>> channels not present in CA). This happens with all receivers that report
>>> a 5.1 speaker mask since a HBR stream is carried on 8 channels to the
>>> codec.
>>> =

>>> Add a fallback in the CA selection so that the CA channel count at least
>>> matches the stream channel count, even if the stream contains channels
>>> not present in the sink speaker descriptor.
>>> =

>>> Thanks to GrimGriefer at OpenELEC forums for discovering that changing
>>> the sink speaker mask allowed HBR output.
>>> =

>>> Reported-by: GrimGriefer
>>> Reported-by: Ashecrow
>>> Reported-by: Frank Zafka <kafkaesque1978@gmail.com>
>>> Reported-by: Peter Fr=FChberger <fritsch@xbmc.org>
>>> Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
>>> Cc: <stable@vger.kernel.org>
>>> ---
>>> =

>>> Hopefully this fixes HBR (HD passthrough) for the remaining Intel users
>>> who were still experiencing problems.
>> =

>> Thanks, I applied the patch now.
>> =

>> =

>>> BTW, the hdmi_channel_allocation() logic seems also otherwise somewhat
>>> suspect to me. Shouldn't we always select an allocation matching ALSA
>>> channel mapping, instead of re-assigning channels received from
>>> userspace "randomly" to sink speakers (in case of unusual sink speaker
>>> mask)?
>> =

>> If per_pin->chmap_set is set beforehand,
>> hdmi_manual_channel_allocation() is called instead.  So it should be
>> fine.
>> =

>> =

>> Takashi
>> =

>>> Anyway, I let it be for now at least.
>>> =

>>> =

>>> sound/pci/hda/patch_hdmi.c | 11 +++++++++++
>>> 1 file changed, 11 insertions(+)
>>> =

>>> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
>>> index 030ca86..354fc55 100644
>>> --- a/sound/pci/hda/patch_hdmi.c
>>> +++ b/sound/pci/hda/patch_hdmi.c
>>> @@ -551,6 +551,17 @@ static int hdmi_channel_allocation(struct hdmi_eld=
 *eld, int channels)
>>>      }
>>>  }
>>> =

>>> +    if (!ca) {
>>> +        /* if there was no match, select the regular ALSA channel
>>> +         * allocation with the matching number of channels */
>>> +        for (i =3D 0; i < ARRAY_SIZE(channel_allocations); i++) {
>>> +            if (channels =3D=3D channel_allocations[i].channels) {
>>> +                ca =3D channel_allocations[i].ca_index;
>>> +                break;
>>> +            }
>>> +        }
>>> +    }
>>> +
>>>  snd_print_channel_allocation(eld->info.spk_alloc, buf, sizeof(buf));
>>>  snd_printdd("HDMI: select CA 0x%x for %d-channel allocation: %s\n",
>>>          ca, channels, buf);
>>> -- =

>>> 1.8.1.5
>>> =
