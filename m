From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH 2/2] ASoC: simple-card: Add support for
 samplerate and samplewidth constraints
Date: Tue, 3 Mar 2015 12:09:14 +0200
Message-ID: <54F5884A.1090702@ti.com>
References: <cover.1425303942.git.jsarha@ti.com>
 <9d01aa0d0bf48d8b41d5086a7e6c9ec08c2b9c48.1425303942.git.jsarha@ti.com>
 <54F4C0F2.8000201@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E7212606CB
 for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2015 11:09:21 +0100 (CET)
In-Reply-To: <54F4C0F2.8000201@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Cc: moinejf@free.fr, kuninori.morimoto.gx@renesas.com, Li.Xiubo@freescale.com, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, broonie@kernel.org, bcousson@baylibre.com
List-Id: alsa-devel@alsa-project.org

On 03/02/2015 09:58 PM, Lars-Peter Clausen wrote:
> On 03/02/2015 03:14 PM, Jyri Sarha wrote:
>> Add DT properties to dailink for setting samplerate and samplewidth
>> constraints. The DT binding document has been updated.
>
> Can you include a description why this is needed and how and when it is
> supposed to be used?

Would this addition do:
------------------------------------------------------------
These constraints help to disable the sample-format and sample-rate
combinations that do not properly work on a specific HW.
------------------------------------------------------------

The reason why we need these is coming from limitations in McASP clock 
generation. With a simple divider one can only produce certain 
bit-clocks. With those bit-clocks we can only play/capture some 
sample-rate and sample-width combinations accurately.

The McASP driver could try to set the constraints automatically. 
However, since the constraint code can not select sample-width and 
sample-rate combinations there is a compromise to be made between them. 
Making such compromises automatically does not usually work that well.

In our case these properties could of course be added to McASP driver, 
but then again I would expect that there is a wider need for this kind 
of functionality. And it may not always be clear if either end of the 
link alone is responsible for less than perfect operation.

Best regards,
Jyri
