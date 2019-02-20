From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [Sound-open-firmware] [PATCH v4 01/14] ASoC: SOF:
 Add Sound Open Firmware driver core
Date: Wed, 20 Feb 2019 15:32:54 -0600
Message-ID: <d92700ef-4975-fd8b-c93b-b699f65781b1@linux.intel.com>
References: <20190213220734.10471-1-pierre-louis.bossart@linux.intel.com>
 <20190213220734.10471-2-pierre-louis.bossart@linux.intel.com>
 <s5h1s4abu2n.wl-tiwai@suse.de>
 <ecb982bf-5f45-4551-592c-8375d06415e0@linux.intel.com>
 <20190219153836.GD6319@sirena.org.uk>
 <19843650-4f58-4aa9-7bf3-c1ce4c72d1c9@linux.intel.com>
 <20190220162645.GB9878@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20190220162645.GB9878@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>
Cc: Daniel Baluta <daniel.baluta@gmail.com>, andriy.shevchenko@intel.com, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, sound-open-firmware@alsa-project.org, Alan Cox <alan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


On 2/20/19 10:26 AM, Mark Brown wrote:
> On Wed, Feb 20, 2019 at 08:35:16AM -0600, Pierre-Louis Bossart wrote:
>
>> I see your point and agree the current direction isn't scalable, but I am
>> not sure about the definition of 'first class device'.
>> Did you mean 'component' at the same level as the 'platforms' and 'codec=
s',
>> with all the DSP stuff nicely packaged and maintained in a self-contained
>> way?
>> Or a subcomponent that might be part of those platforms and codecs?
> As far as I can see for the Intel systems it's looking like a first
> class component - there will be some systems where the DSP is embedded
> in something (like the big CODECs) but even there it's easier as it's
> contained within the device rather than affecting multiple devices which
> is the big issue here.

Sorry Mark, I am struggling with the 'first class' idea.

Allow me to go back to the practical issue we faced here, and =

maybe/hopefully this will help us converge on a consensus.

The only reason for extending the struct snd_soc_pcm_runtime was to =

enable the use of a 'context' in PCM operations, see e.g in patch 5/14 =

the repeated pattern to get an 'SOF PCM' context:

struct snd_sof_pcm *spcm =3D rtd->private;

Managing a context for PCM ops is typically done in other drivers by =

using the substream->private_data aka snd_pcm_substream_chip(substream).

In ASoC/DPCM, unfortunately this substream->private_data field was =

reclaimed to store a pointer to a 'struct snd_soc_pcm_runtime', see e.g. =

in soc-pcm.c:

pcm->private_data =3D rtd;

 =A0=A0=A0=A0=A0=A0=A0 if (playback)
pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream->private_data =3D rtd;
 =A0=A0=A0 =A0=A0=A0 if (capture)
pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream->private_data =3D rtd;

So ironically in ASoC we don't have a means to use a private_data field =

for the substreams since it's used for a 'standard' mechanism.

The extension suggested in this patch 1/14 was really trying to come =

back to a practical means to store a context in a substream, and make =

the PCM operations manageable. I totally agree that extending the PCM =

runtime might not recommended or safe, but at this point I don't have =

any slack in the existing data structures to add a context in a substream.

Does this help clarify the problem statement?
