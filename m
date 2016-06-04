From: Alan Young <consult.awy@gmail.com>
Subject: Re: Improving status timestamp accuracy
Date: Sat, 4 Jun 2016 11:43:56 +0100
Message-ID: <5752B0EC.3030605@gmail.com>
References: <5752A005.2050309@gmail.com>
 <84551786-d910-efa0-3cc7-23a3e8f6ed8f@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 06B462606D6
 for <alsa-devel@alsa-project.org>; Sat,  4 Jun 2016 12:43:58 +0200 (CEST)
Received: by mail-wm0-f51.google.com with SMTP id n184so28220598wmn.1
 for <alsa-devel@alsa-project.org>; Sat, 04 Jun 2016 03:43:58 -0700 (PDT)
In-Reply-To: <84551786-d910-efa0-3cc7-23a3e8f6ed8f@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 04/06/16 11:17, Clemens Ladisch wrote:
> Alan Young wrote:
>> I am looking at ways to get more accurate status timestamp information
>> for various SoC drivers.
> What for?

I want to know, at any given point in wall-clock time, how many samples 
have been output. I want this to an accuracy better than period time. I 
want this when the output buffer is not being kept full, and therefore I 
cannot rely on polls firing only on period boundaries.

>> A call to snd_pcm_status() result in snd_pcm_update_hw_ptr0() being
>> called. This gets the current output position (pos) via
>> substream->ops->pointer(substream) and then makes all the other
>> calculations based on the result. In theory, the result of
>> substream->ops->pointer() could be sample accurate but in practice it
>> is very unlikely to be better than period accurate.
> Accurate timestamps make sense only with accurate pointers.  The purpose
> of these timestamps is to allow better prediction of the position of the
> DMA pointer, but this is pointless when the DMA pointer does large jumps.
>

I think that that was exactly my point. The DMA pointer does large 
jumps. An accurate position is only obtained at the point of an 
interrupt callback. Attempting to rely on more accurate reports from the 
DMA subsystems outside of an interrupt is doomed to failure. Therefore, 
base reports on the data obtained at the last interrupt point.

Alan.
