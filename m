From: Jack Mitchell <ml@embed.me.uk>
Subject: tlv320aic3x regcache issue
Date: Wed, 26 Feb 2014 19:13:01 +0000
Message-ID: <530E3CBD.90908@embed.me.uk>
Reply-To: ml@embed.me.uk
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from owm.eumx.net (eumx.net [91.82.101.43])
 by alsa0.perex.cz (Postfix) with ESMTP id AAF57261785
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 20:13:05 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I have come across an issue where the regcache mechanism used in the
tlv320aic3x driver is causing problems. When switching from 44.1khz to
48khz some of the registers are not written due to the default register
cache holding the same value as being written. However, the codec
requires these registers to be written in order to trigger the change,
this has been proven by changing the register default to something
different, therefore forcing a write at the correct time and it triggers
the change as expected.

What would be the best way to force these registers to be written? Is
there some sort of force write flag, or a way to turn off the cache just
during this portion of the configuration?

Any direction in the proper way of doing this would be much appreciated.

Cheers,
Jack

-- 
   Jack Mitchell (jack@embed.me.uk)
   Embedded Systems Engineer
   Cambridgeshire, UK
   http://www.embed.me.uk
-- 
