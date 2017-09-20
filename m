From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2] ALSA: hda - program ICT bits to support
	HBR audio
Date: Wed, 20 Sep 2017 08:12:36 -0500
Message-ID: <8af5af38-f220-f58a-e7be-4e25dfff452a@linux.intel.com>
References: <20170919222505.28654-1-pierre-louis.bossart@linux.intel.com>
 <s5h60cdelkx.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 290F02668BF
 for <alsa-devel@alsa-project.org>; Wed, 20 Sep 2017 15:12:54 +0200 (CEST)
In-Reply-To: <s5h60cdelkx.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Sriram Periyasamy <sriramx.periyasamy@intel.com>, alsa-devel@alsa-project.org, broonie@kernel.org, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

On 9/20/17 5:00 AM, Takashi Iwai wrote:
> On Wed, 20 Sep 2017 00:25:05 +0200,
> Pierre-Louis Bossart wrote:
>>
>> From: Sriram Periyasamy <sriramx.periyasamy@intel.com>
>>
>> On recent Intel platforms (Haswell, Broadwell, Skylake, ApolloLake,
>> KabyLake, ...), the IEC Coding Type (ICT) bitfield in the Digital
>> Converter Control #3 needs to be set explicitly for HDMI/DisplayPort
>> High Bit Rate (HBR) audio playback to work. This was not required in
>> earlier platforms when HBR was first introduced. The ICT bits are
>> defined in Section 7.3.3.9 of the HDaudio 1.0a specification.
>>
>> Since the ICT bitfield was not specified for HDAudio 1.0 devices
>> (before 2009), we only program it on machines more recent than
>> Haswell.
>>
>> We tested that this fix is not needed on Baytrail-I (MinnowBoard
>> Turbot) and believe by extension it also does not apply to Braswell.
>>
>> Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=98797
>>
>> Signed-off-by: Sriram Periyasamy <sriramx.periyasamy@intel.com>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
>> ---
>> v2: move digi3 verb in Set section, only set ICT for haswell and newer
> 
> Applied now with a slight fix (moving *_SET_* definition to the right
> place).

Thanks Takashi. Not sure what happened since I have a clear memory of 
doing that change and making a note of it...
