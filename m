From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: [Intel HDA][ALC3226] Too much white noise from
	microphone
Date: Fri, 06 Feb 2015 16:48:09 +0500
Message-ID: <54D4A9F9.6090709@gmail.com>
References: <8841801.KiuVFG1hDJ@segfault>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f171.google.com (mail-lb0-f171.google.com
 [209.85.217.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 220AA2605BB
 for <alsa-devel@alsa-project.org>; Fri,  6 Feb 2015 12:48:14 +0100 (CET)
Received: by mail-lb0-f171.google.com with SMTP id u14so17380612lbd.2
 for <alsa-devel@alsa-project.org>; Fri, 06 Feb 2015 03:48:12 -0800 (PST)
In-Reply-To: <8841801.KiuVFG1hDJ@segfault>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Starr <shawn.starr@rogers.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

05.02.2015 02:13, Shawn Starr wrote:
> Hello ALSA devs,
>
> I spoke to patrakov on Freenode from the #Alsa IRC channel and they mentioned that
> the noise background I am experiencing is not normal. I tried two different headsets,
> both headsets have two separate jacks, the same result.
>
> I will test any patches/quirks for kernel as needed.
>
> Here is the alsa-info:
>
> http://www.alsa-project.org/db/?f=29d3c45e2d66c58be03a10bd0186067a9d735a11

I am not an expert on Intel HDA cards, but... some microphones are picky 
about the reference voltage supplied by the soundcard. You can change 
this temporarily, for debugging purposes, with hda-analyzer. See general 
instructions at

http://www.alsa-project.org/main/index.php/HDA_Analyzer

Note: it needs the "snd-hwdep" module loaded, and needs to be run as root.

In your case, you need to select Node[0x18] PIN in the left pane, and, 
at the bottom of the right pane, select 50 or 100 instead of 80 in the 
VREF box. See https://imgur.com/F84raSN for a screenshot based on your 
alsa-info.

If this doesn't help, just click around randomly. Maybe you'll find the 
magic checkbox that makes the noise go away and the voice stay :) - if 
that happens, please email the resulting diff file that hda-analyzer 
creates.

-- 
Alexander E. Patrakov
