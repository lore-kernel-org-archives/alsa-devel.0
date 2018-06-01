From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [alsa-devel] [PATCH v2 1/3] ASoC: topology: Improve backwards
 compatibility with v4 topology files
Date: Fri, 1 Jun 2018 08:55:31 -0700
Message-ID: <20180601155531.GA1848@roeck-us.net>
References: <1527191363-21021-1-git-send-email-linux@roeck-us.net>
 <20180601102506.GB8677@sirena.org.uk>
 <0015aace-fe32-9707-d3c9-0dea6f5fc48c@roeck-us.net>
 <8452aca6-0ae4-9fe1-c8cd-9f84e34f509f@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8452aca6-0ae4-9fe1-c8cd-9f84e34f509f@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Chintan Patel <chintan.m.patel@intel.com>, Guenter Roeck <groeck@chromium.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 01, 2018 at 10:19:58AM -0500, Pierre-Louis Bossart wrote:
> On 6/1/18 8:17 AM, Guenter Roeck wrote:
> >On 06/01/2018 03:25 AM, Mark Brown wrote:
> >>On Thu, May 24, 2018 at 12:49:21PM -0700, Guenter Roeck wrote:
> >>>From: Guenter Roeck <groeck@chromium.org>
> >>>
> >>>Commit dc31e741db49 ("ASoC: topology: ABI - Add the types for BE
> >>>DAI") introduced sound topology files version 5. Initially, this
> >>>change made the topology code incompatible with v4 topology files.
> >>
> >>No review on these from anyone at Intel?
> >>
> >
> >The only actionable feedback I have seen is that the header file
> >changes should be in uapi, which is done in patches 2 and 3.
> >
> >Other than that, there was a question if this is a Linux issue or
> >a Chromebook issue (it appears that only Chromebooks shipped with
> >v4 configuration files). I took that as rhetorical since upstream
> >kernels (at least v4.4 and v4.5) support topology v4 configuration
> >files, and it should not matter which products shipped using those.
> 
> I wanted to ack this patch but the Intel validation folks asked for a couple
> of days to finish their tests on a variety of Chromebooks (e.g. Lars) and
> double-check which models used the v4 topology. There is an internal thread
> on all this which remains active. I don't think the feedback will be delayed
> beyond early next week.

Skylake-Y:
	caroline, cave, chell
Skylake-U:
	asuka, lars, lili, sentry

ApolloLake (alan, electro, sand, and many more) also seem to use the same
file format (or a variant of it), but I am not sure. I didn't get to testing
it due to other problems with the upstream kernel which I did not have time
to track down yet.

Guenter
