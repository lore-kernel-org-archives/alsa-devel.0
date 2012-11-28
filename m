From: Liam Girdwood <lrg@ti.com>
Subject: Re: SOC that needs L/R data in separate buffers
Date: Wed, 28 Nov 2012 10:13:50 +0000
Message-ID: <50B5E3DE.8000109@ti.com>
References: <CAKON4OzLvNUNsWXoaBMy+BFT-dhv2sAW6ytPXpTWkKEjoS+w0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id B739B26167A
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2012 11:13:58 +0100 (CET)
In-Reply-To: <CAKON4OzLvNUNsWXoaBMy+BFT-dhv2sAW6ytPXpTWkKEjoS+w0w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 28/11/12 04:13, jonsmirl@gmail.com wrote:
> Is there a format in ALSA for hardware that wants the L/R stereo data
> in two different buffers and not inter-leaved? Hardware has two DMA
> channels into separate FIFOs for L/R.
>

asound.h lists all the supported data formats and we have 
SNDRV_PCM_ACCESS_RW_NONINTERLEAVED for non interleaved hardware.

Regards

Liam
