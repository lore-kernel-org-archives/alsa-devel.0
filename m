From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v3 07/14] ASoC: SOF: Add DSP firmware
 logger support
Date: Tue, 22 Jan 2019 14:52:25 -0600
Message-ID: <af89cb49-6550-d6b0-a274-0b803cfadffd@linux.intel.com>
References: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
 <20181211212318.28644-8-pierre-louis.bossart@linux.intel.com>
 <20190109204427.GR10405@sirena.org.uk>
 <85d2a9dc-4800-9db7-3e6a-3671f8eef226@linux.intel.com>
 <20190122185711.GI7579@sirena.org.uk>
 <17fc8892-90aa-a7b3-d9aa-23825b83fca0@linux.intel.com>
 <20190122204122.GN7579@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20190122204122.GN7579@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, andriy.shevchenko@intel.com, tiwai@suse.de, Pan Xiuli <xiuli.pan@linux.intel.com>, Daniel Baluta <daniel.baluta@gmail.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, Alan Cox <alan@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org


>>> Why was sparse complaining - was it spotting something that is an actual
>>> issue here and you've just masked the warning?
>> It was about the use of typeof/sizeof() in min(), not an actual issue in the
>> code
>> sound/soc/sof/trace.c:90:17: warning: expression using sizeof(void)
>> sound/soc/sof/trace.c:90:17: warning: expression using sizeof(void)
> I don't understand that warning - avail and count are both size_t so
> where's it deciding that there's a void involved?

no idea really, I am only a user of sparse, I don't know how it 
generated that warning.

there are equally confusing ones such as

include/linux/slab.h:332:43: warning: dubious: x & !y

include/linux/slab.h:665:13: warning: call with no type!

include/linux/slab.h:665:13: error: undefined identifier 
'__builtin_mul_overflow

The main benefit of sparse is that it is the only tool that found 
endianess and iomem space issues, but it's often buried in heaps of 
false alarms in include files.
