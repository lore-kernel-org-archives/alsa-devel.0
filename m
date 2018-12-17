From: Dimitris Papavasiliou <dpapavas@gmail.com>
Subject: Re: Need help fixing pop/click artifacts in an ASOC
 driver
Date: Mon, 17 Dec 2018 14:17:45 +0200
Message-ID: <fff018b4-c2e5-d3f3-0589-b837e62e9c5e@gmail.com>
References: <11a5bb5b-f8ad-d9cc-29df-8efeccb6228d@gmail.com>
 <20181114220640.GB2089@sirena.org.uk>
 <c0546298-960e-df17-273f-fa0734050aac@gmail.com>
 <20181114230255.GG2089@sirena.org.uk>
 <b48bc9d6-767a-24df-692e-fe675afed22e@gmail.com>
 <20181115003313.GH2089@sirena.org.uk>
 <56e02571-fd5b-0add-c6c7-98e4f746448c@gmail.com>
 <20181115190403.GI2089@sirena.org.uk>
 <00b68fe8-403d-b129-1166-f414e5bd21ab@gmail.com>
 <724efe46-d604-0de1-caa2-efcfd7c91510@gmail.com>
 <20181213174229.GU10669@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by alsa0.perex.cz (Postfix) with ESMTP id C8B2826789E
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2018 13:17:48 +0100 (CET)
Received: by mail-wm1-f66.google.com with SMTP id y139so12060435wmc.5
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2018 04:17:48 -0800 (PST)
In-Reply-To: <20181213174229.GU10669@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On 12/13/18 7:42 PM, Mark Brown wrote:
> On Sat, Nov 24, 2018 at 10:17:49PM +0200, Dimitris Papavasiliou wrote:
> 
>> discussion here.  I still feel that fixing the machine driver, so
>> that it doesn't generate the pop at all would be desirable, as
>> I'm not sure whether the digital_mute callback is guaranteed to
>> have muted the device when the clock source takes place.
> 
> Making the machine driver more robust is definitely better, it's more
> robust in case the mute is for example just a very low gain which might
> still let the pop through at a lower level.

Even worse, it would let the pop through at full volume, as it
doesn't depend on the gain.  Still, there doesn't seem to be a
safe way to avoid the pop altogether, as far as I can see, since
the only way I have found to avoid it, is to suspend the chip
during the switch, and I can't synchronize access to the relevant
register by the machine and CODEC drivers.

If you have any other ideas/pointers on approaches I could
investigate, please let me know.
