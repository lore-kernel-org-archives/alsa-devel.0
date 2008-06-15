From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH 1/2] ad1848: separate header for registers
 definition
Date: Sun, 15 Jun 2008 18:07:02 +0200
Message-ID: <48553E26.1070100@keyaccess.nl>
References: <20080615124121.781d8aff.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 7E0B82433F
	for <alsa-devel@alsa-project.org>;
	Sun, 15 Jun 2008 18:06:40 +0200 (CEST)
In-Reply-To: <20080615124121.781d8aff.krzysztof.h1@poczta.fm>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 15-06-08 12:41, Krzysztof Helt wrote:

> This patch is a start combining ad1848_lib and cs4231_lib
> functionality. My approach is to make the cs4231_lib module
> use the ad1848_lib module. This should allow removing
> most of identical functions from the cs4231_lib and use
> the functions from the ad1848_lib directly.
> 
> If this approach is not a good idea, please drop the patch.
> 
> My current plan is to reuse the ad1848 register constants
> in the cs423x code and remove duplicated cs4231 constants.
> This should make the ad1848_lib and cs4231_lib easier to
> compare for differences.
> 
> The next step is to use the snd_cs4231 structure instead of 
> the snd_ad1848 structure inside the ad1848_lib. This will make
> functions from the ad1848_lib taking the same arguments
> as the functions in the cs4231_lib.
> 
> The last step would be to export needed functions from the
> ad1848_lib and use them directly in the cs4231_lib.
> 
> This should reduce the size of the cs4231_lib while preserving
> smaller the ad1848_lib for driver which uses only ad1848
> functionality.

I believe it would be going a bit overboard to actually make these two 
dependent libs. Unification would seem a good plan probably but as far 
as I'm concerned one lib to drive all these chips should do really.

cs4321_lib isn't all that much bigger. The seperation does make sense at 
the source level, but I'd personally go for a single library module (*) 
built from multiple source files. These chips aren't used by embedded 
these days and even if they were the sizes we are talking about are 
laughable in today's terms.

At a later stage, cs4236_lib could be folded in as well...

(*) perhaps under sound/drivers/wss, or sound/isa/lib/wss (or if you 
don't care for the wss name, something else; the location is more the 
point).

Rene.
