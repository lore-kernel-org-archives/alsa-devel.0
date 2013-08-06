From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: [PATCH 1/2] ASoC: cs42l52: Reorder Min/Max and
 update to SX_TLV for Beep Volume
Date: Tue, 6 Aug 2013 00:15:56 +0000
Message-ID: <01AC0AE0-25B5-4BD1-B543-1714446145A5@cirrus.com>
References: <alpine.DEB.2.10.1308051508140.5288@heelrod.ad.cirrus.com>
 <20130805202439.GA30764@sirena.org.uk>
 <alpine.DEB.2.10.1308051529100.5288@heelrod.ad.cirrus.com>,
 <52000C66.4090400@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C47D2652B3
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2013 02:16:23 +0200 (CEST)
In-Reply-To: <52000C66.4090400@metafoo.de>
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
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org



On Aug 5, 2013, at 15:34, "Lars-Peter Clausen" <lars@metafoo.de> wrote:

> On 08/05/2013 10:31 PM, Brian Austin wrote:
>> On Mon, 5 Aug 2013, Mark Brown wrote:
>> 
>>> On Mon, Aug 05, 2013 at 03:08:47PM -0500, Brian Austin wrote:
>>>> Beep Volume Min/Max was backwards.
>>>> Change to SOC_SONGLE_SX_TLV for correct volume representation
>>> 
>>> This doesn't apply against v3.11-rc4 - can you check what's going on
>>> there please?  I don't see any obvious issues by eye which is
>>> worrying...
>> huh,  I just did a fresh pull of for-next and applied and it did fine...
>> It is SINGLE instead of SONGLE though :) But that wasn't the patch itself
> 
> Looks like your mail client replaced the tabs in the patch with spaces.
> 
> - Lars
> 
Ok, so I guess FWD from pine won't work.  Good grief. I'll have to fix my git mailer tomorrow.

Sorry for the delay
