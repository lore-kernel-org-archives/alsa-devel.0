From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH] ALSA: compress: Add
 SND_AUDIOCODEC_BESPOKE'
Date: Wed, 21 Oct 2015 13:46:49 -0500
Message-ID: <5627DD99.5000502@linux.intel.com>
References: <1445348358-23306-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <56267E4E.8010609@linux.intel.com> <20151020193711.GF32054@sirena.org.uk>
 <20151021153248.GE27370@localhost> <20151021153614.GD10520@ck-lbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DF3B2606AC
 for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2015 20:46:53 +0200 (CEST)
In-Reply-To: <20151021153614.GD10520@ck-lbox>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

On 10/21/15 10:36 AM, Charles Keepax wrote:
> On Wed, Oct 21, 2015 at 09:02:49PM +0530, Vinod Koul wrote:
>> On Tue, Oct 20, 2015 at 08:37:11PM +0100, Mark Brown wrote:
>>> On Tue, Oct 20, 2015 at 12:47:58PM -0500, Pierre-Louis Bossart wrote:
>>
>>>> If you need to set parameters maybe we should also change the definition of
>>>> snd_enc_generic so that the reserved fields can be used for custom
>>>> parameters, or document that their use is permitted for this sort of ID.
>>>
>>> It does mean the core can't grab them but quite what the core is
>>> supposed to usefully do for something like this is unclear to me so...
>>
>> Well in case of compressed formats, core doesn't do anything, we just act as
>> a transport and shove down data and information.
>>
>> I do like Pierre's idea of giving some meaning to formats and use some
>> reserved fields, but somehow I can't think of a clean solution for this!
>
> Personally, I feel a bit like doing nothing at the moment might
> be the best solution. If BESPOKE is for icky stuff that won't be
> generic trying to pull out generic fields to go in snd_enc_generic
> seems like a challenging exercise, and we can look submissions
> that use it and keep an eye out for anything that might be
> generic enough to go in there, rather than adding a bunch of
> stuff that ends up never getting used.

I was only suggesting to redefine these fields from 'reserved' to 'use 
for whatever parameters are needed for this BESPOKE codec type'. I 
wasn't trying to come-up with generic fields or predict future usages of 
non-standard codecs, that would be a waste of time indeed.
