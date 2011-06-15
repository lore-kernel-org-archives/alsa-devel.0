From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [Device-drivers-devel] [PATCH 1/8] ASoC: AD1836:
 drop unnecessary spi register check
Date: Wed, 15 Jun 2011 16:56:51 +0200
Message-ID: <4DF8C833.3030407@metafoo.de>
References: <1308087268-11464-1-git-send-email-vapier@gentoo.org>
	<4DF7D8CA.10909@metafoo.de>
	<BANLkTimPmpCnZSuk9ZtmjLRcg_0gDmH17g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id BAA1D103800
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Jun 2011 16:58:19 +0200 (CEST)
In-Reply-To: <BANLkTimPmpCnZSuk9ZtmjLRcg_0gDmH17g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, device-drivers-devel@blackfin.uclinux.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 06/15/2011 04:40 PM, Mike Frysinger wrote:
> On Tue, Jun 14, 2011 at 17:55, Lars-Peter Clausen wrote:
>> On 06/14/2011 11:34 PM, Mike Frysinger wrote:
>>> The only thing the init func does is register a spi driver, so if that
>>> fails, we return the value back up to the caller who will display an
>>> error message for us.  So drop the redundant checking/message.
>>>
>>> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
>>> ---
>>>  sound/soc/codecs/ad1836.c |   10 +---------
>>>  1 files changed, 1 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/sound/soc/codecs/ad1836.c b/sound/soc/codecs/ad1836.c
>>> index 754c496..d368539 100644
>>> --- a/sound/soc/codecs/ad1836.c
>>> +++ b/sound/soc/codecs/ad1836.c
>>> [...]
>>
>> most of these patches won't apply, since I already submitted support for the
>> other AD183X chips last week. Please check Mark's for-next branch.
> 
> i didnt see those patches on the device-drivers-devel mailing list.
> did you cc them there ?
> -mike

Yes. See
http://blackfin.uclinux.org/gf/project/device-drivers/mailman/?_forum_action=ForumMessageBrowse&thread_id=45510&action=ListThreads&mailman_id=73

- Lars
