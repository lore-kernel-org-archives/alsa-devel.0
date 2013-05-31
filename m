From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: "Negative" volume settings in a kcontrol
Date: Fri, 31 May 2013 09:01:22 +0200
Message-ID: <51A84AC2.5070702@topic.nl>
References: <51824609.30405@canonical.com> <1367498241.8766.3.camel@localhost>
 <5182746C.1070603@topic.nl> <5187AEA5.1020108@ladisch.de>
 <51A49907.70105@topic.nl> <20130529194211.GB5180@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atl4mhob08.myregisteredsite.com
 (atl4mhob08.myregisteredsite.com [209.17.115.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 3DE2B260865
 for <alsa-devel@alsa-project.org>; Fri, 31 May 2013 09:01:25 +0200 (CEST)
Received: from mail.hostingplatform.com ([10.30.71.211])
 by atl4mhob08.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id
 r4V71NCm008563
 for <alsa-devel@alsa-project.org>; Fri, 31 May 2013 03:01:23 -0400
In-Reply-To: <20130529194211.GB5180@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 05/29/2013 09:42 PM, Mark Brown wrote:
> On Tue, May 28, 2013 at 01:46:15PM +0200, Mike Looijmans wrote:
>> On 05/06/2013 03:22 PM, Clemens Ladisch wrote:
>>> Mike Looijmans wrote:
>
> *ALWAYS* CC maintainers on mails and don't drop people from CCs either...

I hereby promise to improve myself in that respect :)

>>> There are some ASoC helper macros that handle signed register fields, such
>>> as SOC_DOUBLE_S8_TLV and SOC_SINGLE_XR_SX.  If those don't do what you want,
>>> you have to write your own.
>
>> SOC_DOUBLE_S8_TLV seems to be a misnamed hardware-specific macro. It
>> provides no way to specify the location of the left/right bits so
>> the macro name is misleading.
>
> That's trivially fixable...

>> SOC_SINGLE_XR_SX is too new for my kernel. And from what I gather, I
>> cannot use it anyway for my purposes. So the solution turns out to
>
> What makes you gather this?

What I actually needed was a SOC_DOUBLE_... thingy. Otherwise, the macro 
was pretty close, but I'm using a 2.6.37 kernel so just backporting the 
snd_soc_*_xr_sx methods would be more work than simply writing new 
info/set/get methods. I also considered the fact that only one driver is 
using the SOC_SINGLE_XR_SX macro a bit of a code smell, so I feared a 
similar experience as with SOC_DOUBLE_S8_TLV which was also introduced 
just for a single driver.


Mike.
