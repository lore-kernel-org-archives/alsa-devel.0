From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 1/4] alsa: make hw_params negotiation
 infrastructure 'bclk_ratio aware'
Date: Fri, 8 Mar 2019 15:54:13 -0600
Message-ID: <1391fc64-c92f-1fbb-2ae5-954391c4352b@linux.intel.com>
References: <20190304165955.21696-1-TheSven73@gmail.com>
 <20190305044232.GA15636@workstation>
 <CAGngYiWDO6YTTMGOFwpzQCOkxEr+AOz3ScDt748w_0UuUk+JLw@mail.gmail.com>
 <20190308041056.GA1172@workstation>
 <20190308125916.2cgiqclp6jmlfbim@shell.armlinux.org.uk>
 <20190308172235.GA31189@sirena.org.uk>
 <25dec9c5-af5c-bc54-89dd-2abdeffa9f82@perex.cz>
 <CAGngYiVaFswVrVYfUpo4YfkH+nxwaW+8q8q3C6_wfggS7YCYjw@mail.gmail.com>
 <865cd0e3-8390-024d-6c84-c416bfe3cb45@linux.intel.com>
 <20190308211313.GD7960@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 88A2AF806F7
 for <alsa-devel@alsa-project.org>; Fri,  8 Mar 2019 22:54:17 +0100 (CET)
In-Reply-To: <20190308211313.GD7960@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>
Cc: Sven Van Asbroeck <thesven73@gmail.com>, alsa-devel@alsa-project.org, Russell King - ARM Linux admin <linux@armlinux.org.uk>
List-Id: alsa-devel@alsa-project.org


On 3/8/19 3:13 PM, Mark Brown wrote:
> On Fri, Mar 08, 2019 at 02:49:48PM -0600, Pierre-Louis Bossart wrote:
>
>> I am not sure I fully understand the ask but wanted to point out that for
>> ASoC topology-based solutions the bclk rate is typically passed as a
>> parameter from userspace (w/ a request_firmware and topology parsing) and
> You mean for x86 systems :)  Well, big DSP really.  It's not really
> topology related.

I was referring to asoc.h and the following structure. For once it's not =

an Intel-specific hack, though the topology does need a lot of love to =

be hardened and extended.

struct snd_soc_tplg_hw_config {
 =A0=A0=A0 __le32 size;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* in bytes of thi=
s structure */
 =A0=A0=A0 __le32 id;=A0=A0=A0 =A0=A0=A0 /* unique ID - - used to match */
 =A0=A0=A0 __le32 fmt;=A0=A0=A0 =A0=A0=A0 /* SND_SOC_DAI_FORMAT_ format val=
ue */
 =A0=A0=A0 __u8 clock_gated;=A0=A0=A0 /* SND_SOC_TPLG_DAI_CLK_GATE_ value */
 =A0=A0=A0 __u8 invert_bclk;=A0=A0=A0 /* 1 for inverted BCLK, 0 for normal =
*/
 =A0=A0=A0 __u8 invert_fsync;=A0=A0=A0 /* 1 for inverted frame clock, 0 for=
 normal */
 =A0=A0=A0 __u8 bclk_master;=A0=A0=A0 /* SND_SOC_TPLG_BCLK_ value */
 =A0=A0=A0 __u8 fsync_master;=A0=A0=A0 /* SND_SOC_TPLG_FSYNC_ value */
 =A0=A0=A0 __u8 mclk_direction;=A0=A0=A0 /* SND_SOC_TPLG_MCLK_ value */
 =A0=A0=A0 __le16 reserved;=A0=A0=A0 /* for 32bit alignment */
 =A0=A0=A0 __le32 mclk_rate;=A0=A0=A0 /* MCLK or SYSCLK freqency in Hz */
 =A0=A0=A0 __le32 bclk_rate;=A0=A0=A0 /* BCLK frequency in Hz */
 =A0=A0=A0 __le32 fsync_rate;=A0=A0=A0 /* frame clock in Hz */
 =A0=A0=A0 __le32 tdm_slots;=A0=A0=A0 /* number of TDM slots in use */
 =A0=A0=A0 __le32 tdm_slot_width;=A0=A0=A0 /* width in bits for each slot */
 =A0=A0=A0 __le32 tx_slots;=A0=A0=A0 /* bit mask for active Tx slots */
 =A0=A0=A0 __le32 rx_slots;=A0=A0=A0 /* bit mask for active Rx slots */
 =A0=A0=A0 __le32 tx_channels;=A0=A0=A0 /* number of Tx channels */
 =A0=A0=A0 __le32 tx_chanmap[SND_SOC_TPLG_MAX_CHAN]; /* array of slot numbe=
r */
 =A0=A0=A0 __le32 rx_channels;=A0=A0=A0 /* number of Rx channels */
 =A0=A0=A0 __le32 rx_chanmap[SND_SOC_TPLG_MAX_CHAN]; /* array of slot numbe=
r */
} __attribute__((packed));


>
>> might be forwarded over IPC to a DSP. On some Intel platforms which can't
>> support 32x fs that is typically how we represent a bclk ratio multiple =
of
>> 25. the kernel has no idea of the relationship between the representatio=
n of
>> the stream in memory and the final bit clock, only the DSP which programs
>> the hardware registers knows about the latter.
>> It's really quite typical that the DAI is programmed for a fixed
>> configuration and the DSP takes care of the conversions. The kernel only
>> deals with stream triggers and power management without know all the
>> internal details of the audio graph.
> I think this is more the issue with not having transitioned fully to
> components which we've talked about before I think - it's related but
> not quite the same thing.  In the big DSP case there's really two audio
> links that aren't really connected but we're currently trying to treat
> them as one since the code was designed for much smaller DSPs.

Yes, this notion of hw_params negotiation made me think about the =

constraints propagation that Lars talked about ~2 years ago, it's not as =

simple as a helper library I am afraid.

This discussion on bclk ratio makes a lot of sense. Some codecs have =

undocumented restrictions, e.g PCM512x or some Maxim amps, and it's not =

uncommon to come up with a configuration mismatch that take time to =

debug. If at least we could have an error thrown it'd be a good thing.
