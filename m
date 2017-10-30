From: Sergej Sawazki <ce3a@gmx.de>
Subject: Re: [PATCH 2/3] ASoC: wm8741: Set OSR mode in
 hw_params()
Date: Mon, 30 Oct 2017 09:34:38 +0100
Message-ID: <b8e70602-5bb8-3b67-e2dd-21217342728c@gmx.de>
References: <1504553653-8144-1-git-send-email-sergej@taudac.com>
 <1504553653-8144-3-git-send-email-sergej@taudac.com>
 <20170905161221.qopgxgaw4zhfzfvs@localhost.localdomain>
 <575ad555-0cab-66de-95b7-4dc1b379ca9c@taudac.com>
 <20170906082037.tgseyekunu2cf4qx@localhost.localdomain>
 <61568e45-844d-34eb-a9df-518d18843b01@taudac.com>
 <20170919094756.kxq7h6k3knykzylu@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by alsa0.perex.cz (Postfix) with ESMTP id C1E49266CED
 for <alsa-devel@alsa-project.org>; Mon, 30 Oct 2017 09:34:46 +0100 (CET)
In-Reply-To: <20170919094756.kxq7h6k3knykzylu@localhost.localdomain>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>, Sergej Sawazki <sergej@taudac.com>
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, 19 Sep 2017 10:47:56 +0100, Charles Keepax wrote:
> On Mon, Sep 18, 2017 at 09:30:36PM +0200, Sergej Sawazki wrote:
>> Am 06.09.2017 um 10:20 schrieb Charles Keepax:
...
>>
>> I think we should split "adding the OSR mode configuration" and
>> "refactoring the code to use update_bits()" in at least two commits.
>>
>> For consistency, I would keep the write() in this patch, and provide
>> the update_bits() refactoring later. What do you think?
>>
> 
> Two commits seems sensible although its only a very small
> refactoring so feels like we might as well get it done whilst
> changing the code. I am happy to do the initial refactoring
> patch, if that helps but I don't presently have hardware to test
> this CODEC.
> 

Thanks Charles,

I have the hardware and could make the tests if you provide initial
refactoring patch.

Regards
Sergej
