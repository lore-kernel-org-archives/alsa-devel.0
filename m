From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] ALSA: virtuoso: add Xonar Xense support
Date: Wed, 10 Sep 2014 20:15:39 +0200
Message-ID: <5410954B.4060901@ladisch.de>
References: <20140910141813.B328C258D256@mx02.posteo.de>
 <54107077.7030203@ladisch.de>
 <20140910160422.1B47E25A2113@mx02.posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 3F4D62655A9
 for <alsa-devel@alsa-project.org>; Wed, 10 Sep 2014 20:14:52 +0200 (CEST)
In-Reply-To: <20140910160422.1B47E25A2113@mx02.posteo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Harley Griggs <hgriggs@posteo.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Harley Griggs wrote:
> Clemens Ladisch <clemens@ladisch.de> wrote:
>> Harley Griggs wrote:
>>> This patch adds support for the Xonar Xense card.
>>
>> The title is misleading.  This is "partial support" or "stereo-only
>> support".
>
> Apologies. Should I resubmit with a new title or just use this thread?

Resubmit with a new title in this thread.

>>> +	data->broken_i2c = true;
>>
>> It's not.  (There is no other chip at address 1001110.)
>
> I'll remove this. I tried to use the ST as a template as much as
> possible. Is there a reason the ST uses this ?

On the ST, there are two chips with address 1001110.


Regards,
Clemens
