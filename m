From: Christopher Freeman <cfreeman@nvidia.com>
Subject: Re: [PATCH] ASoC: jack: export gpio detect
Date: Tue, 8 Apr 2014 13:40:10 -0700
Message-ID: <CF69AC38.3C92E%cfreeman@nvidia.com>
References: <20140403220715.GG14763@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate14.nvidia.com (hqemgate14.nvidia.com [216.228.121.143])
 by alsa0.perex.cz (Postfix) with ESMTP id 28F3E265649
 for <alsa-devel@alsa-project.org>; Tue,  8 Apr 2014 22:40:10 +0200 (CEST)
In-Reply-To: <20140403220715.GG14763@sirena.org.uk>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org



On 4/3/14 3:07 PM, "Mark Brown" <broonie@kernel.org> wrote:

>* PGP Signed by an unknown key
>
>On Thu, Apr 03, 2014 at 03:03:55PM -0700, cfreeman@nvidia.com wrote:
>> From: Christopher Freeman <cfreeman@nvidia.com>
>> 
>> Export the gpio detect function so machine drivers
>> may call it.  Interrupts for the jack may be disabled
>> during sleep, so this allows a machine driver to have
>> the jack status updated during resume.
>
>It seems better to have explicit callbacks for this doesn't it, ideally
>ones that get triggered by the core without the machine driver having to
>do anything?  This is a common need so having to open code it would be a
>bit depressing.

Mark, do you have a suggestion on how to plumb this up?  The way I see it,
the machine drivers own the context for the gpios and soc-jack acts as a
helper library.  I don't see a way to do this from the core.


>
>* Unknown Key
>* 0x7EA229BD

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
