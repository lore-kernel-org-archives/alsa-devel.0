From: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
Subject: Re: Misuses of ** ? (was Re: [PATCH 1/1] ASoC: Intel: Atom: add a
 missing star in a memcpy call)
Date: Sun, 28 Aug 2016 20:52:18 +0200
Message-ID: <fcac5d87-9f50-b303-f100-4313d7f21907@m4x.org>
References: <20160828173945.27721-1-nicolas.iooss_linux@m4x.org>
 <1472406636.26978.95.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472406636.26978.95.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>, alsa-devel@alsa-project.org, Julia Lawall <julia.lawall@lip6.fr>, Dan Capenter <error27@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 28/08/16 19:50, Joe Perches wrote:
> On Sun, 2016-08-28 at 19:39 +0200, Nicolas Iooss wrote:
>> In sst_prepare_and_post_msg(), when a response is received in "block",
>> the following code gets executed:
>>
>>     *data = kzalloc(block->size, GFP_KERNEL);
>>     memcpy(data, (void *) block->data, block->size);
> 
> Yuck, thanks.
> 
> Julia, Dan, could cocci or smatch help find any other
> similar misuses here?

In fact I have found this bug with a GCC plugin I have written after I
discovered an issue with a printf format string in brcmfmac driver
(https://lkml.org/lkml/2016/8/23/193 fixes this one). This GCC plugin
uses an approach which has many false positives but it helped me detect
real bugs such as the one you replied to, and
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=ae6c33ba6e37eea3012fe2640b22400ef3f2d0f3
a few days ago.

In case you are curious about what the plugin looks like (it is very
dirty but might be useful for future work I won't have time to do), I
published it on
https://gist.github.com/anonymous/36dd40dcbeeb83964e66b65be7a96136 .
This huge patch contains the plugin code in
scripts/gcc-plugins/deref_checker_plugin.c, many dirty work-arounds to
filter false positive matches, a really-dirty way of handling memcpy
optimisations done by gcc, and fixes to possible bugs (which can be
found by searching "/* BUG? */", I have not yet had time to find out
whether they are real bugs or false positives too).

I hope this will help in the work of eliminating bugs in the kernel :)

-- Nicolas
