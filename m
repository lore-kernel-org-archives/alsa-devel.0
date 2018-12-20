From: "Schulman, James" <James.Schulman@cirrus.com>
Subject: Re: [PATCH v3 2/2] ASoC: cs35l36: Add device tree
 documentation for CS35L36
Date: Thu, 20 Dec 2018 19:39:14 +0000
Message-ID: <alpine.DEB.2.10.1812201337420.11893@james-tower>
References: <1545072932-18474-1-git-send-email-james.schulman@cirrus.com>
 <1545072932-18474-2-git-send-email-james.schulman@cirrus.com>
 <20181218093022.GT16508@imbe.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 7885B2678D4
 for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2018 20:39:19 +0100 (CET)
In-Reply-To: <20181218093022.GT16508@imbe.wolfsonmicro.main>
Content-Language: en-US
Content-ID: <8F1392CA98B8E34484B0BF8D4AE2E322@namprd19.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "Austin,
 Brian" <Brian.Austin@cirrus.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "Handrigan,
 Paul" <Paul.Handrigan@cirrus.com>, "Schulman,
 James" <James.Schulman@cirrus.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>
List-Id: alsa-devel@alsa-project.org



On Tue, 18 Dec 2018, Charles Keepax wrote:

> On Mon, Dec 17, 2018 at 12:55:32PM -0600, James Schulman wrote:
>> +  - cirrus,irq-polarity : Selects the polarity of the selected interrupt output
>> +  when in push-pull mode. Note - when the selected interrupt output is in
>> +  open-drain mode, INT_POL_SEL must be set to 0.
>> +
>> +  0 = Active-low (Default)
>> +  1 = Active-high
>> +
>
> Only outstanding comment from me is this guy I think. Is there a
> reason you prefer not to specify it through the interrupt flags?
>
> Thanks,
> Charles
>

Hey Charles, no particularly good reason :) I'll modify the driver and 
send out a v4.

Thanks,
James
