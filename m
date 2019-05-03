From: frederik@ofb.net
Subject: ALSA -> pulseaudio channel mapping,
	what is it (and why?)
Date: Fri, 3 May 2019 11:05:21 -0700
Message-ID: <20190503180521.gtfv64hel5427dx7@localhost>
Reply-To: frederik@ofb.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from egnor-li.ofb.net (egnor-li.ofb.net [IPv6:2600:3c01:e000:283::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C3DC2F8075A
 for <alsa-devel@alsa-project.org>; Fri,  3 May 2019 20:05:25 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: pulseaudio-discuss@lists.freedesktop.org, georg@chini.tk
List-Id: alsa-devel@alsa-project.org

Dear ALSA developers,

I ran into a problem which seems to be caused by some lines in
"alsa-plugins-1.1.8/pulse/pcm_pulse.c".

The problem is that if I create a 6-channel PulseAudio device, and
then I configure an ALSA device in ~/.asoundrc to output to the
PulseAudio device, the channels of the ALSA device are mixed together
in various ways and don't correspond 1-1 with the channels of the
PulseAudio device.

I find this to be counter-intuitive. If I wanted channels to be mixed
and remapped in various ways, I would use the PulseAudio module
module-remap-sink on the PulseAudio side, since AFAICT ALSA does not
support named channels. I would not expect remixing to happen in the
ALSA->Pulse bridge, since the relevant PCM plugin contains no channel
map parameter.

I don't even know what channel map I should give the PulseAudio device
in order to prevent remixing from occurring. The file pcm_pulse.c
contains the lines:

        for (c = pcm->ss.channels; c > 0; c--)
                if (pa_channel_map_init_auto(&map, c, PA_CHANNEL_MAP_ALSA))
                        break;

This refers to a macro in /usr/include/pulse/channelmap.h:

    /** \cond fulldocs */
        PA_CHANNEL_MAP_ALSA,
        /**< The default mapping used by ALSA. This mapping is probably
         * not too useful since ALSA's default channel mapping depends on
         * the device string used. */
    /** \endcond */

The comment says that the ALSA mapping is "not too useful" - so why
are we using it? Also, how do I find out what it is, if it "depends on
the device string used"?

My preference would simply be to have a 1-1 channel map in pcm_pulse,
so that a PulseAudio device with 6 channels will turn into an ALSA
device with THE SAME 6 CHANNELS. No mixing. Mixing is confusing in
this context, and seems undocumented outside of the code.

I tried using aux0 thru aux5 as the PulseAudio channel map, to prevent
geometry-based remixing. However, this results in silence - apparently
none of the 6 ALSA channels end up going anywhere. That was also
unexpected. Since I am playing 6-channel audio to a 6-channel device,
which emulates another 6-channel device, I would have thought that the
channel mapping wouldn't be complicated. Instead, it appears that the
PulseAudio sink needs to have channels with specific names in order to
receive data from ALSA.

Can we fix this, or improve the user experience?

Thanks,

Frederick
