From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [RFC 1/4] ASoC: topology: Add topology UAPI header.
Date: Tue, 21 Apr 2015 18:46:28 +0200
Message-ID: <55367EE4.5030201@metafoo.de>
References: <1429217295.7100.19.camel@loki>
 <20150420213048.GT14892@sirena.org.uk> <1429609673.3793.14.camel@loki>
 <s5hlhhlztnr.wl-tiwai@suse.de> <1429620227.3793.31.camel@loki>
 <20150421150342.GJ22845@sirena.org.uk> <s5hy4llmrnr.wl-tiwai@suse.de>
 <20150421163502.GL22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-126.synserver.de (smtp-out-126.synserver.de
 [212.40.185.126])
 by alsa0.perex.cz (Postfix) with ESMTP id 6721226149D
 for <alsa-devel@alsa-project.org>; Tue, 21 Apr 2015 18:46:25 +0200 (CEST)
In-Reply-To: <20150421163502.GL22845@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, "Koul,
 Vinod" <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 04/21/2015 06:35 PM, Mark Brown wrote:
> On Tue, Apr 21, 2015 at 05:23:36PM +0200, Takashi Iwai wrote:
>> Mark Brown wrote:
>
>>> That's sounding like an awfully small number if we're trying to be
>>> infititely future proof (obviously the default value for that is 640k!).
>>> We'd also need to go through and give *all* the structures padding.  How
>>> about just adding length fields instead with a rule that if the
>>> structure is bigger than you know about just ignore anything at the end?
>
>> In theory, having only "abi" field should be enough, as we can know
>> the size predefined for each ABI version.  But I agree that it'd be
>> friendlier for a parser if the header itself declares its size,
>> e.g. via a header_size field or embedding the size into some check
>> field like ioctl.
>
> The trouble with the ABI version information is that it tells new
> kernels how to handle old tables but old kernels will have no idea what
> to do with new firmwares.

What I did for the SigmaDSP firmware format (which can hopefully be 
superseded by this) is to have a header which a block type and the block 
length for each block for exactly this reason. It allows fully backward and 
forward compatibility between kernel versions and does not require a change 
in the ABI each time a new type of block is added. It also keeps the parser 
simple since it does not have to know the size and also makes support for 
vendor blocks quite easy, since the processing of those can be offloaded to 
some vendor callbacks without the core having to be informed what the 
content or size of those vendor blocks is.

- Lars
