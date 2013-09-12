From: "Nathanael D. Noblet" <nathanael@gnat.ca>
Subject: Re: Internal Mic Boost channel is unused
Date: Thu, 12 Sep 2013 13:17:43 -0600
Message-ID: <52321357.2060109@gnat.ca>
References: <5231E348.8020204@gnat.ca> <1379011427.4254.3.camel@david-saucy>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from titanium.nobletdesign.com (titanium.nobletdesign.com
 [64.34.172.148])
 by alsa0.perex.cz (Postfix) with ESMTP id 393A7265500
 for <alsa-devel@alsa-project.org>; Thu, 12 Sep 2013 21:17:45 +0200 (CEST)
Received: from titanium.nobletdesign.com (localhost.localdomain [127.0.0.1])
 by titanium.nobletdesign.com (Postfix) with ESMTP id 4C57CF7803C
 for <alsa-devel@alsa-project.org>; Thu, 12 Sep 2013 14:17:44 -0500 (CDT)
Received: from iridium.noblet.ca (S0106c0c1c0f4a322.cg.shawcable.net
 [68.146.127.169])
 by titanium.nobletdesign.com (Postfix) with ESMTP id 05EE6F7803B
 for <alsa-devel@alsa-project.org>; Thu, 12 Sep 2013 14:17:43 -0500 (CDT)
In-Reply-To: <1379011427.4254.3.camel@david-saucy>
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

On 09/12/2013 12:43 PM, David Henningsson wrote:
> So I saw that you had two selector nodes (0x17 and 0x18), so I figured
> one could be "Internal Mic Boost" (for internal mic) and the other one
> "Mic Boost" (for external mic).
>
> However, according to the BIOS, you actually have *two* external mic
> jacks. Is this correct? It could possibly be that one of them is part of
> a headset jack. This might be related to what's confusing the driver, so
> perhaps if we just removed the fake mic input that would make things
> work.

I do have two external mini jacks. One has a mic image, one has a 
headphone image...  Whether both can be used as mic inputs that I'm not 
sure about.

-- 
Nathanael d. Noblet
t 403.875.4613
