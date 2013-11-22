From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: firewire-lib: an issue to generate packet with 'no
 data' in blocking mode
Date: Fri, 22 Nov 2013 14:58:32 +0100
Message-ID: <528F6308.6090902@ladisch.de>
References: <528EF2DE.9060700@sakamocchi.jp> <528F4462.3000909@ladisch.de>
 <528F61F3.5050706@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id AAE6C261AC1
 for <alsa-devel@alsa-project.org>; Fri, 22 Nov 2013 14:58:36 +0100 (CET)
In-Reply-To: <528F61F3.5050706@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
>> I guess I just didn't notice that empty packets don't need to change
>> their FDF field.  This is a bug.
>
> I also paied no attension to empty packets. Then BeBoB chipset teach me.
>
>> Empty packets should be fine for all devices.  (NO-DATA packets would
>> waste DMA bandwidth.)
>
> I completely agree with you. Would you review an attached patch?

Acked-by: Clemens Ladisch <clemens@ladisch.de>
