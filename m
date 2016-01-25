From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Locking issue from snd_soc_suspend
Date: Mon, 25 Jan 2016 13:02:10 +0100
Message-ID: <56A60EC2.5070507@metafoo.de>
References: <CAOMZO5B2J+PSuAdTOA8VwuDSOAjcbeA4G5pMWPt3VAeJCpacEA@mail.gmail.com>
 <CAOMZO5BajMzAp8_M4RjjwZeHs11jdp0SCQQK1ChT9eGwVmgdTQ@mail.gmail.com>
 <56941196.7000107@metafoo.de> <569412C1.6090308@metafoo.de>
 <CAOMZO5BDmveYTGi70oLKdKLAYPx__c0mEK3ndf8cQthX2Y6VNg@mail.gmail.com>
 <CAOMZO5Dvd3WrgxBcMSpu8aogKzsx5TOaSpRyLqjKM0WQdBdyWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-013.synserver.de (smtp-out-116.synserver.de
 [212.40.185.116])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C9E52604D6
 for <alsa-devel@alsa-project.org>; Mon, 25 Jan 2016 13:08:53 +0100 (CET)
In-Reply-To: <CAOMZO5Dvd3WrgxBcMSpu8aogKzsx5TOaSpRyLqjKM0WQdBdyWA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>, Martin Fuzzey <mfuzzey@parkeon.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Russell King <linux@arm.linux.org.uk>, Sascha Hauer <kernel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On 01/25/2016 01:57 AM, Fabio Estevam wrote:
> Hi Lars,
> 
> On Mon, Jan 11, 2016 at 7:28 PM, Fabio Estevam <festevam@gmail.com> wrote:
>> Hi Lars,
>>
>> On Mon, Jan 11, 2016 at 6:38 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>>
>>> Please try the attached patch, I think that should fix it.
>>
>> Excellent! This fixes the issue, thanks:
>>
>> Tested-by: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Do you plan to send this fix as a formal patch?

Yes, give me a day or two.
