From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH] ALSA: hda: Disable 4/6 channels on some
 NVIDIA	GPUs.
Date: Tue, 11 Jan 2011 09:41:40 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF03105680D9@HQMAIL01.nvidia.com>
References: <1294676371-1401-1-git-send-email-ndaga@nvidia.com>
	<4D2C8F59.4040507@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 72F6610386B
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 18:45:18 +0100 (CET)
In-Reply-To: <4D2C8F59.4040507@iki.fi>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Anssi Hannula <anssi.hannula@iki.fi>, Nitin Daga <ndaga@nvidia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Anssi Hannula wrote:
> On 10.01.2011 18:19, Nitin Daga wrote:
> > Added hardware constraint in patch_hdmi.c to disable
> > channels 4/6 which are not supported by some older
> > NVIDIA GPUs.
> 
> And 3/5/7, which do not seem to work either with my 0x0007.

Are 3/5/7 channels supported by any vendor?

> However, 3/5/7 do not work with my 0x000b system either, is this a hw
> limitation as well (that should be added to the driver) or is there a
> bug in the HDA driver for uneven channel counts?

I don't know if NVIDIA HW supports odd numbers of channels; Nitin, can
you please find out? That said, the error you quote below for 5 channels
sounds more like a software issue to me; some kind of buffer alignment
or size constraint can't be satisfied?

> (I looked at the HDA specification and it does seem to allow
> odd-numbered channel counts)

I skimmed quickly, and the only reference I could find was in section
7.6 "Audio Data Packetization" of HDMISpecification1.4a.pdf:

    Layout 1 can be used to carry one audio sample with three to
    eight channels of L-PCM audio.

... which implies support for an odd number of channels.

That said, the tables and other text near that quote indicate that audio
is transferred in subpackets which each contain a pair of channels, and
the sample_present bits each cover a subpacket, i.e. a pair of channels.
Perhaps table 5-13 "Audio Sample Subpacket"'s V.L/V.R (channel validity)
bits are intended to represent which of the two channels in a subpacket
exist?

Looking at CEA-861D, Table 17 "Audio InfoFrame Data Byte 1", CC
(Channel Count) bits, it's quite explicit that odd numbers of channels
are supported.

> Strangely, on both of my systems speaker-test -c5 fails with an error:
> 
> $ speaker-test -Dhdmi -c5
> 
> speaker-test 1.0.23
> 
> Playback device is hdmi
> Stream parameters are 48000Hz, S16_LE, 5 channels
> Using 16 octaves of pink noise
> Rate set to 48000Hz (requested 48000Hz)
> Buffer size range from 128 to 419392
> Period size range from 64 to 209664
> Using max buffer size 419392
> Periods = 4
> Unable to set nperiods 4 for playback: No such file or directory
> Setting of hwparams failed: No such file or directory
> 
> While -c3 and -c7 run fine but no sound is received.
>
> > [Nitin's patch elided]

-- 
nvpublic
