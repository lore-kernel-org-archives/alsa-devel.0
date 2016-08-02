From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Improving status timestamp accuracy
Date: Tue, 2 Aug 2016 09:55:07 +0200
Message-ID: <35f9d6de-f11f-7977-7b6f-69d2f3e1e73c@ladisch.de>
References: <5752A005.2050309@gmail.com>
 <CAN8cciZN=Gjq3Za+Qz31EYoCsTuTNp4au_Upxq8ZvvEJqNdw9w@mail.gmail.com>
 <5753FFF0.3050200@gmail.com> <s5hwpm2n2bq.wl-tiwai@suse.de>
 <57554591.20103@gmail.com>
 <51c7887a-db2f-ee88-8290-2f2d21d6435d@linux.intel.com>
 <57566D64.1050400@gmail.com> <577FC0C4.1060508@IEE.org>
 <93b0b35f-5b8d-6ba3-c7db-fb534e66d31c@linux.intel.com>
 <578E4862.4050603@IEE.org>
 <805c3724-f027-a405-5704-3b343aa5404b@linux.intel.com>
 <578F2139.9060001@IEE.org>
 <97295c12-7abb-54a2-f51f-7610c0e5447c@linux.intel.com>
 <57A04BFE.9030704@IEE.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 2ACDE265AD3
 for <alsa-devel@alsa-project.org>; Tue,  2 Aug 2016 09:55:11 +0200 (CEST)
In-Reply-To: <57A04BFE.9030704@IEE.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alan Young <Alan.Young@IEE.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: Raymond Yau <superquad.vortex2@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Alan Young wrote:
> Stepping back for a moment, the delay calculation essentially
> consists of two parts:
>
> 1. How much data is still in the ring buffer.
> 2. How much data has been removed from the ring buffer but not yet
>    played out.
> [...]
> The more that I think about it the more it seems to me that using
> a time-based estimate for position (hw_ptr), outside of an interrupt
> callback, will always be more accurate than that returned by
> substream->ops->pointer().

Please note that "hw_ptr" (or "avail" in the API) specifies the DMA
position, i.e., it is guaranteed that the samples up to this position
have been handled by the DMA controller and can now be accessed by the
program.  An estimate that gets this wrong can lead to data corruption.

Using an estimate for the delay is perfectly fine.


Regards,
Clemens
