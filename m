From: Vincent Vinel <v.vinel@gmail.com>
Subject: Re: [PATCH 1/1] dmix: Add support for S24_3BE format.
Date: Sun, 16 Feb 2014 20:51:27 +0100
Message-ID: <530116BF.20803@gmail.com>
References: <1392483271-20453-1-git-send-email-v.vinel@gmail.com>
 <1392483271-20453-2-git-send-email-v.vinel@gmail.com>
 <5300BCA0.2070601@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f46.google.com (mail-wg0-f46.google.com [74.125.82.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 631A42607BB
 for <alsa-devel@alsa-project.org>; Sun, 16 Feb 2014 20:51:29 +0100 (CET)
Received: by mail-wg0-f46.google.com with SMTP id x13so1662091wgg.13
 for <alsa-devel@alsa-project.org>; Sun, 16 Feb 2014 11:51:29 -0800 (PST)
In-Reply-To: <5300BCA0.2070601@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 02/16/14 14:26, Clemens Ladisch wrote:
> Vincent Vinel wrote:
>> Add swapped versions of generic_mix_areas_24() and
>> generic_remix_areas_24().
> What for?
>

To use dmix with soundcards only supporting S24_3BE format, i.e. those 
using snd-usb-caiaq driver.

-- 
Narthorn
