From: Christopher Freeman <cfreeman@nvidia.com>
Subject: Re: [PATCH] ASoC: jack: export gpio detect
Date: Thu, 10 Apr 2014 16:24:58 -0700
Message-ID: <CF6C7514.3DC69%cfreeman@nvidia.com>
References: <CF69AC38.3C92E%cfreeman@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com [216.228.121.64])
 by alsa0.perex.cz (Postfix) with ESMTP id 67DCF265840
 for <alsa-devel@alsa-project.org>; Fri, 11 Apr 2014 01:25:02 +0200 (CEST)
In-Reply-To: <CF69AC38.3C92E%cfreeman@nvidia.com>
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
To: Christopher Freeman <cfreeman@nvidia.com>, Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org



On 4/8/14 1:40 PM, "Christopher Freeman" <cfreeman@nvidia.com> wrote:

>
>
>On 4/3/14 3:07 PM, "Mark Brown" <broonie@kernel.org> wrote:
>
>>* PGP Signed by an unknown key
>>
>>On Thu, Apr 03, 2014 at 03:03:55PM -0700, cfreeman@nvidia.com wrote:
>>> From: Christopher Freeman <cfreeman@nvidia.com>
>>> =

>>> Export the gpio detect function so machine drivers
>>> may call it.  Interrupts for the jack may be disabled
>>> during sleep, so this allows a machine driver to have
>>> the jack status updated during resume.
>>
>>It seems better to have explicit callbacks for this doesn't it, ideally
>>ones that get triggered by the core without the machine driver having to
>>do anything?  This is a common need so having to open code it would be a
>>bit depressing.
>
>Mark, do you have a suggestion on how to plumb this up?  The way I see it,
>the machine drivers own the context for the gpios and soc-jack acts as a
>helper library.  I don't see a way to do this from the core.
>
Any thoughts?  One idea would be to change things such that jacks are
registered with the core and the core is then allowed access to the gpio
detect function=8A  This would make things common, but we're still opening
up a function in the jack code.  I don't see another way.  (using the
existing interface, we could free and add gpios on suspend/resume=8A :-P)
>
>>
>>* Unknown Key
>>* 0x7EA229BD
>
>--------------------------------------------------------------------------
>---------
>This email message is for the sole use of the intended recipient(s) and
>may contain
>confidential information.  Any unauthorized review, use, disclosure or
>distribution
>is prohibited.  If you are not the intended recipient, please contact the
>sender by
>reply email and destroy all copies of the original message.
>--------------------------------------------------------------------------
>---------
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@alsa-project.org
>http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
