From: "S. Christian Collins" <s.chriscollins@gmail.com>
Subject: Re: "alsactl store" fails to save Echo Gina3G mixer
Date: Wed, 30 Aug 2017 09:17:49 -0500
Message-ID: <13fd0b91-d0ed-3b8e-4042-1ad996135661@gmail.com>
References: <d8d6d07c-ade6-1ccc-7111-ed367fccf0f9@gmail.com>
 <1fa01cef-7159-b1b2-8ec6-5eab7f2a7e29@sakamocchi.jp>
 <1708292129400.21841@stax.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f67.google.com (mail-it0-f67.google.com
 [209.85.214.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 12113266C5E
 for <alsa-devel@alsa-project.org>; Wed, 30 Aug 2017 16:17:54 +0200 (CEST)
Received: by mail-it0-f67.google.com with SMTP id 77so1126219itj.0
 for <alsa-devel@alsa-project.org>; Wed, 30 Aug 2017 07:17:54 -0700 (PDT)
In-Reply-To: <1708292129400.21841@stax.localdomain>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Hills <mark@xwax.org>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 08/29/2017 03:36 PM, Mark Hills wrote:
> I think you're suffering the same problem I am with my Echo Layla 3G. Does
> 'echomixer' work?

Yes, 'echomixer' works fine for me. I have to launch it on occasion to 
properly set my audio output level (just launching it restores the 
correct level). I didn't have to do this in the past, so I'm guessing 
it's probably related to the problem with 'alsactl store' not working 
anymore for the card.

> I have been intending to make a 'proper' report to the list, or even
> investigate more myself. But priorities did not permit that yet. I also
> wasn't able to find information on what these fields actually mean. As far
> as I could tell, some of these attributes are unique to the echo3g and
> echomixer.

Yeah, I've never seen a mixer quite like this one. Using 'alsamixer' to 
adjust my Echo3G is almost pointless, since it is impossible to tell 
what is what.

-~Chris
