From: Dimitris Papavasiliou <dpapavas@gmail.com>
Subject: Re: Need help fixing pop/click artifacts in an ASOC
 driver
Date: Mon, 17 Dec 2018 14:58:03 +0200
Message-ID: <7dbf7969-c0ea-fe13-2044-17f36e458e21@gmail.com>
References: <c0546298-960e-df17-273f-fa0734050aac@gmail.com>
 <20181114230255.GG2089@sirena.org.uk>
 <b48bc9d6-767a-24df-692e-fe675afed22e@gmail.com>
 <20181115003313.GH2089@sirena.org.uk>
 <56e02571-fd5b-0add-c6c7-98e4f746448c@gmail.com>
 <20181115190403.GI2089@sirena.org.uk>
 <00b68fe8-403d-b129-1166-f414e5bd21ab@gmail.com>
 <724efe46-d604-0de1-caa2-efcfd7c91510@gmail.com>
 <20181213174229.GU10669@sirena.org.uk>
 <fff018b4-c2e5-d3f3-0589-b837e62e9c5e@gmail.com>
 <20181217123703.GF13868@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by alsa0.perex.cz (Postfix) with ESMTP id E958026789E
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2018 13:58:06 +0100 (CET)
Received: by mail-wr1-f45.google.com with SMTP id t6so11987867wrr.12
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2018 04:58:06 -0800 (PST)
In-Reply-To: <20181217123703.GF13868@sirena.org.uk>
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

On 12/17/18 2:37 PM, Mark Brown wrote:
> On Mon, Dec 17, 2018 at 02:17:45PM +0200, Dimitris Papavasiliou wrote:
> 
>> Even worse, it would let the pop through at full volume, as it
>> doesn't depend on the gain.  Still, there doesn't seem to be a
>> safe way to avoid the pop altogether, as far as I can see, since
>> the only way I have found to avoid it, is to suspend the chip
>> during the switch, and I can't synchronize access to the relevant
>> register by the machine and CODEC drivers.
> 
>> If you have any other ideas/pointers on approaches I could
>> investigate, please let me know.
> 
> If you're doing this during DAPM there shouldn't be anything else
> running on the card at the time.

In general the clocks need to be switched during the hw_params
callback (when the new callback specifies a new sample rate,
which needs the other clock) and, as far as I can see, this can
happen at more or less any time, i.e. in all power states and
regardless of whether the device is opened or closed.

I can't therefore depend on DAPM functionality to suspend the
chip when needed, as far as I can see at least and apart from
asking the DAPM to force-suspend the chip, as I've already
suggested.
