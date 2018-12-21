From: "Schulman, James" <James.Schulman@cirrus.com>
Subject: Re: [PATCH v4 2/2] ASoC: cs35l36: Add device tree
 documentation for CS35L36
Date: Fri, 21 Dec 2018 19:52:31 +0000
Message-ID: <alpine.DEB.2.10.1812211352060.17092@james-tower>
References: <1545334876-12054-1-git-send-email-james.schulman@cirrus.com>
 <1545334876-12054-2-git-send-email-james.schulman@cirrus.com>
 <20181221111255.GC16508@imbe.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id BC3A0267944
 for <alsa-devel@alsa-project.org>; Fri, 21 Dec 2018 20:52:36 +0100 (CET)
In-Reply-To: <20181221111255.GC16508@imbe.wolfsonmicro.main>
Content-Language: en-US
Content-ID: <94B3BF742F418343A16E4E1BF841C1EC@namprd19.prod.outlook.com>
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



On Fri, 21 Dec 2018, Charles Keepax wrote:

> On Thu, Dec 20, 2018 at 01:41:16PM -0600, James Schulman wrote:
>> Add device tree documentation for Cirrus Logic CS35L36
>> speaker amplifier
>>
>> Signed-off-by: James Schulman <james.schulman@cirrus.com>
>> ---
>> +	cirrus,irq-config {
>> +		cirrus,irq-drive-select = <0x01>;
>> +		cirrus,irq-polarity = <0x00>;
>
> The irq-polarity needs dropped from the example, but otherwise:
>
> Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
>
> Thanks,
> Charles
>
>> +		cirrus,irq-gpio-select = <0x01>;
>> +	};
>> +};
>> --
>> 1.9.1
>

Thanks again Charles. I'm sorting out this irq_cfg stuff in the other 
patch and I'll clean up this one accordingly.

Thanks,
James
