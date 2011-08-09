From: Steve Calfee <stevecalfee@gmail.com>
Subject: Re: Template Based Coefficients Setting for Filters
Date: Tue, 09 Aug 2011 10:19:27 -0700
Message-ID: <4E416C1F.6030301@gmail.com>
References: <1312893236.8316.51.camel@matrix>
	<20110809151630.GB3429@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f171.google.com (mail-iy0-f171.google.com
	[209.85.210.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 7C47524635
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Aug 2011 19:19:36 +0200 (CEST)
Received: by iyf13 with SMTP id 13so219357iyf.2
	for <alsa-devel@alsa-project.org>; Tue, 09 Aug 2011 10:19:30 -0700 (PDT)
In-Reply-To: <20110809151630.GB3429@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 08/09/11 08:16, Mark Brown wrote:
> On Tue, Aug 09, 2011 at 06:03:56PM +0530, Ashish Chavan wrote:
> 
>>    I am working on updating ASoC codec driver for Dialog's DA7210 codec
>> (sound/soc/codec/da7210.c). This update would be a major functionality
>> update in nature. Currently, I am implementing support for GP (general
>> purpose) filters of this codec and need some opinions/comments.
> 
> Use _BYTES controls for this.  There are no existing users in ASoC,
> though there should be shortly and there are generic ALSA examples.

Hi Mark,

Could you expand on this. Neither google or lxr found anything about
_BYTES controls. Where is it defined in the source?

Regards, Steve
