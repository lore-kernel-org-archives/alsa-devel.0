From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Improving status timestamp accuracy
Date: Sat, 4 Jun 2016 12:17:23 +0200
Message-ID: <84551786-d910-efa0-3cc7-23a3e8f6ed8f@ladisch.de>
References: <5752A005.2050309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 9A9352606D6
 for <alsa-devel@alsa-project.org>; Sat,  4 Jun 2016 12:17:27 +0200 (CEST)
In-Reply-To: <5752A005.2050309@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alan Young <consult.awy@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Alan Young wrote:
> I am looking at ways to get more accurate status timestamp information
> for various SoC drivers.

What for?

> A call to snd_pcm_status() result in snd_pcm_update_hw_ptr0() being
> called. This gets the current output position (pos) via
> substream->ops->pointer(substream) and then makes all the other
> calculations based on the result. In theory, the result of
> substream->ops->pointer() could be sample accurate but in practice it
> is very unlikely to be better than period accurate.

Accurate timestamps make sense only with accurate pointers.  The purpose
of these timestamps is to allow better prediction of the position of the
DMA pointer, but this is pointless when the DMA pointer does large jumps.


Regards,
Clemens
