From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Audio codec with multiple I2C devices
Date: Sun, 06 Apr 2014 11:15:11 +0200
Message-ID: <53411B1F.5070004@metafoo.de>
References: <mailman.300.1396595329.806.alsa-devel@alsa-project.org>
 <C71C517D-B88B-48C3-9156-AB9DD40AE4C0@whospot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-115.synserver.de (smtp-out-048.synserver.de
 [212.40.185.48])
 by alsa0.perex.cz (Postfix) with ESMTP id A3F6826513A
 for <alsa-devel@alsa-project.org>; Sun,  6 Apr 2014 11:15:07 +0200 (CEST)
In-Reply-To: <C71C517D-B88B-48C3-9156-AB9DD40AE4C0@whospot.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Gilles <gilles@whospot.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 04/05/2014 12:02 AM, Gilles wrote:
> Folks,
>
> I'm writing an ALSA SoC codec which uses a 3 distinct I2C devices (a DAC, a CAG for volume and a input selector) all 3 at different I2C addresses.

If those are 3 distinct devices you'd typically implement them as 3 
different drivers and model the interconnections between them at the 
board/machine driver level.

- Lars
