From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [PATCH] ALSA: hda: Disable 4/6 channels on some
 NVIDIA	GPUs.
Date: Wed, 12 Jan 2011 06:11:41 +0200
Message-ID: <4D2D29FD.6040008@iki.fi>
References: <1294676371-1401-1-git-send-email-ndaga@nvidia.com>
	<4D2C8F59.4040507@iki.fi>
	<74CDBE0F657A3D45AFBB94109FB122FF03105680D9@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sypressi.dnainternet.net (sypressi.dnainternet.net
	[83.102.40.135]) by alsa0.perex.cz (Postfix) with ESMTP id 078CA24395
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2011 05:11:46 +0100 (CET)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF03105680D9@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Nitin Daga <ndaga@nvidia.com>
List-Id: alsa-devel@alsa-project.org

On 11.01.2011 19:41, Stephen Warren wrote:
> Anssi Hannula wrote:
>> On 10.01.2011 18:19, Nitin Daga wrote:
>>> Added hardware constraint in patch_hdmi.c to disable
>>> channels 4/6 which are not supported by some older
>>> NVIDIA GPUs.
>>
>> And 3/5/7, which do not seem to work either with my 0x0007.
> 
> Are 3/5/7 channels supported by any vendor?
> 
>> However, 3/5/7 do not work with my 0x000b system either, is this a hw
>> limitation as well (that should be added to the driver) or is there a
>> bug in the HDA driver for uneven channel counts?
> 
> I don't know if NVIDIA HW supports odd numbers of channels; Nitin, can
> you please find out? That said, the error you quote below for 5 channels
> sounds more like a software issue to me; some kind of buffer alignment
> or size constraint can't be satisfied?
> 
>> (I looked at the HDA specification and it does seem to allow
>> odd-numbered channel counts)
> 
> I skimmed quickly, and the only reference I could find was in section
> 7.6 "Audio Data Packetization" of HDMISpecification1.4a.pdf:
> 
>     Layout 1 can be used to carry one audio sample with three to
>     eight channels of L-PCM audio.
> 
> ... which implies support for an odd number of channels.
> 
> That said, the tables and other text near that quote indicate that audio
> is transferred in subpackets which each contain a pair of channels, and
> the sample_present bits each cover a subpacket, i.e. a pair of channels.
> Perhaps table 5-13 "Audio Sample Subpacket"'s V.L/V.R (channel validity)
> bits are intended to represent which of the two channels in a subpacket
> exist?

Well, the channel is certainly not valid if it does not exist :)
But I don't think it is that field.

> Looking at CEA-861D, Table 17 "Audio InfoFrame Data Byte 1", CC
> (Channel Count) bits, it's quite explicit that odd numbers of channels
> are supported.

Actually, I just tested and just transmitting 3-channel data with extra
4th dummy channel while setting the Audio InfoFrame fields to indicate a
3 channel stream makes it work.

So it would seem (to me) like the best approach would be:
1. Add a hw_constraint to prevent odd channel counts (easy)
2. Provide some way for alsa plug (and the user application) to indicate
   the "actual/original" channel count/layout without dummy channels,
   so that the infoframe can be set correctly.
   This is harder, and I guess should probably be implemented so that
   the channel remapping issue on older nvidia hw will be fixed as well.


>> Strangely, on both of my systems speaker-test -c5 fails with an error:
>>
>> $ speaker-test -Dhdmi -c5
>>
>> speaker-test 1.0.23
>>
>> Playback device is hdmi
>> Stream parameters are 48000Hz, S16_LE, 5 channels
>> Using 16 octaves of pink noise
>> Rate set to 48000Hz (requested 48000Hz)
>> Buffer size range from 128 to 419392
>> Period size range from 64 to 209664
>> Using max buffer size 419392
>> Periods = 4
>> Unable to set nperiods 4 for playback: No such file or directory
>> Setting of hwparams failed: No such file or directory
>>
>> While -c3 and -c7 run fine but no sound is received.
>>
>>> [Nitin's patch elided]
> 


-- 
Anssi Hannula
