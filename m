From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: adau1701: Add 44.1 KHz to supported
	sample rates
Date: Wed, 11 Nov 2015 12:49:30 +0100
Message-ID: <56432B4A.5090606@metafoo.de>
References: <1444907766-9892-1-git-send-email-pascal.huerst@gmail.com>
 <56260521.6080805@metafoo.de> <56432940.4040306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-188.synserver.de (smtp-out-225.synserver.de
 [212.40.185.225])
 by alsa0.perex.cz (Postfix) with ESMTP id 8CCB6260415
 for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2015 12:49:35 +0100 (CET)
In-Reply-To: <56432940.4040306@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pascal Huerst <pascal.huerst@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 11/11/2015 12:40 PM, Pascal Huerst wrote:
> On 20.10.2015 11:10, Lars-Peter Clausen wrote:
>> On 10/15/2015 01:16 PM, pascal.huerst@gmail.com wrote:
>>> From: Pascal Huerst <pascal.huerst@gmail.com>
>>>
>>> According to the datasheet, this device does also support 44.1 KHz
>>> as sample rate. This adds the necessary changes to support this.
>>>
>>> See Datasheet: Rev. B / page 39 / SR[1:0]
>>>
>>> Signed-off-by: Pascal Huerst <pascal.huerst@gmail.com>
>>
>> Hm, right. The sample rates that part can run at depend on the external
>> clock rate. It can run at ext_clk / 256, ext_clk / 128 or ext_clk / 64.
>> Maybe we should just implement it like that.
>>
>> Do you have support for switching the external clock at runtime on your
>> platform?
> 
> Yes, I can switch th eclock at runtime.

How do you do it? From the board driver?

- Lars
