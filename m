From: Daniel Mack <daniel@zonque.org>
Subject: Re: AKAI EIE PRO
Date: Sat, 06 Sep 2014 13:48:35 +0200
Message-ID: <540AF493.6030206@zonque.org>
References: <cc4cd338872114df86b1c5a93d47cfa1@ztealmax.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 42F72265007
 for <Alsa-devel@alsa-project.org>; Sat,  6 Sep 2014 13:48:37 +0200 (CEST)
In-Reply-To: <cc4cd338872114df86b1c5a93d47cfa1@ztealmax.se>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Martin Svensson <martin.svensson@ztealmax.se>, Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 09/06/2014 09:44 AM, Martin Svensson wrote:
> Dont know if its ok to ask a question here so please let me know if its 
> not ok then i wont ask again ;)
>
> i just bought an external usb AKAI EIE PRO sound card, is there any 
> future plans to implement it in Alsa?

Please send the output of 'lsusb -v' with this device connected. In best
case, we only have to add a quirk table entry.


Daniel
