From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v4 2/2] ASoC: Intel: Use DMI name for sound
 card long name in Broadwell machine driver
Date: Wed, 18 Jan 2017 11:23:38 -0600
Message-ID: <7038c7bd-af14-c22f-5f52-136d4f31b9d0@linux.intel.com>
References: <cover.1484381178.git.mengdong.lin@linux.intel.com>
 <7d5a432b03df6298e85b2af1f520e48821ada648.1484381178.git.mengdong.lin@linux.intel.com>
 <20170117175636.laoybapp7jqtpzno@sirena.org.uk>
 <20170118164459.GF3573@localhost> <s5ho9z4s45v.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 92FB62676E9
 for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2017 18:23:54 +0100 (CET)
In-Reply-To: <s5ho9z4s45v.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Vinod Koul <vinod.koul@intel.com>
Cc: mengdong.lin@linux.intel.com, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

On 1/18/17 10:50 AM, Takashi Iwai wrote:
> On Wed, 18 Jan 2017 17:44:59 +0100,
> Vinod Koul wrote:
>> On Tue, Jan 17, 2017 at 05:56:36PM +0000, Mark Brown wrote:
>>> On Sat, Jan 14, 2017 at 04:13:09PM +0800, mengdong.lin@linux.intel.com wrote:
>>>> From: Mengdong Lin <mengdong.lin@linux.intel.com>
>>>>
>>>> Intel Broadwell machine driver will call API snd_soc_set_dmi_name() to
>>>> use DMI info to make the sound card long name.
>>> I guess we'll see further patches for other machine drivers?
>> Yes that's the idea. At least we will convert the Skylake and Broxton ones,
>> after the current submitted patches and DP-MST ones are merged.
> I had an impression that rather BYT and CHT machines require urgently
> this extension because there are quite lots of devices with the same
> component but different configurations...

My first priority is to close on the set of known quirks and contribute 
them once the reworked MCLK patches are merged. We can add the DMI name 
at the same time for BYT/CHT.
Note that adding the name in the machine driver is only the first part 
required to be able to manage quirks. it'll take a bit of time to 
convert the existing UCM files, make use of the include mechanism and 
contribute them to a repository with a faster update rate than alsa-lib.
