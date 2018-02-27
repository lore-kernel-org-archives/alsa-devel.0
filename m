From: Kirill Marinushkin <k.marinushkin@gmail.com>
Subject: Re: Applied "ASoC: topology: Fix logical inversion in
 set_link_hw_format()" to the asoc tree
Date: Tue, 27 Feb 2018 05:38:52 +0100
Message-ID: <6ff745dd-00a0-fbe6-5af8-23887d95f47b@gmail.com>
References: <E1eqGmV-0005Rk-Jt@debutante>
 <20180226183407.22335-1-k.marinushkin@gmail.com>
 <20180226194755.GC6681@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180226194755.GC6681@sirena.org.uk>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Pan Xiuli <xiuli.pan@linux.intel.com>, alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 02/26/18 20:47, Mark Brown wrote:
> On Mon, Feb 26, 2018 at 07:34:07PM +0100, Kirill Marinushkin wrote:
>
>> 2. The suggested commit breaks the existing ASoC.
>> The existing functionality already works with several existing ASoC by
>> Intel. The suggested commit will break it for the following reason:
>> The ALSA topology mechanism loads the binary topology file into ASoC. The
>> suggested commit modifies the parser, but the binaries are already created for
>> the existing functionality. As a result, all existing binaries will be parsed
>> incorrectly.
> Are there actual binaries using the existing code or is that just
> theoretical?  My impression was that this was fixing things for existing
> binaries which were shipped for non-mainline kernels, is that not the
> case?

There is an actual conf, which can be converted into an actual binary:
`alsa-lib/src/conf/topology/broadwell/broadwell.conf`

Theoretically, there can be an unknown number of the binaries, not available publicly.

Broadwell exists for a long time, and there is no way to be sure that all the theoretically
existing binaries are modified together with this kernel patch.
