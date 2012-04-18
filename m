From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 3/4] Add Wolfson Microelectronics WM8776
 codec ALSA driver
Date: Wed, 18 Apr 2012 08:52:04 +0200
Message-ID: <4F8E6494.60206@ladisch.de>
References: <1334611118-10301-1-git-send-email-linux@rainbow-software.org>
	<201204172015.14582.linux@rainbow-software.org>
	<s5hy5punpem.wl%tiwai@suse.de>
	<201204172307.58016.linux@rainbow-software.org>
	<s5hr4vloa8g.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 56C3F104554
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Apr 2012 08:48:55 +0200 (CEST)
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 170AE22531
	for <alsa-devel@alsa-project.org>; Wed, 18 Apr 2012 02:48:54 -0400 (EDT)
In-Reply-To: <s5hr4vloa8g.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Ondrej Zary <linux@rainbow-software.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Ondrej Zary wrote:
>> On Tuesday 17 April 2012 21:12:33 you wrote:
>>> Ondrej Zary wrote:
>>>> Xonar (oxygen) has a private version of these drivers too. It could be
>>>> converted to use common code instead.
>>>
>>> Hm, only if the generated controls do match with your case,..
>>> It's case by case, especally if there is only one another candidate.
>>
>> Control names can be changed (and also disabled) by the driver. In fact,
>> psc724 does exactly this as is needs the WM8776 controls to be named
>> as "front" and WM8766 as "rear".
>> I don't see any problem if something needs to be changed for this code to be
>> used by Xonar (or some other driver).
>
> OK, it depends on Clemens, whether the shared code is preferred (and
> maintainable).

I've always planned to move the Xonar driver to the ASoC framework.
(I didn't at first because ASoC didn't support multiple codecs then.)
The only problem is finding time to do this ...

Sharing the code between ice1712 and xonar might be a first step.


Regards,
Clemens
