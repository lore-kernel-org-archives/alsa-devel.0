From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Internal Mic Boost channel is unused
Date: Thu, 12 Sep 2013 14:43:47 -0400
Message-ID: <1379011427.4254.3.camel@david-saucy>
References: <5231E348.8020204@gnat.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id DB8E82654D6
 for <alsa-devel@alsa-project.org>; Thu, 12 Sep 2013 20:43:49 +0200 (CEST)
In-Reply-To: <5231E348.8020204@gnat.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Nathanael D. Noblet" <nathanael@gnat.ca>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On tor, 2013-09-12 at 09:52 -0600, Nathanael D. Noblet wrote:
> Hello,
> 
>     I have an issue I'd like to help completely solve. Unfortunately I 
> only have a tenuous grasp of what is actually going on so some of this 
> could be wrong/include errors.
> 
>    Here's what I know.
> 
>   1) I have the following hardware (alsa-info attached).
>   2) The internal microphone requires that the mic boost channel be 
> something other than 0 to function properly.
>   3) Changing what pulseaudio expects things to be labelled causes the 
> problem to go away. (via the attached patch to 
> /usr/share/pulseaudio/paths/analog-input-mic.conf).
> 
>    From the discussion with David Henningsson (diwic on IRC). It seems 
> that pulse doesn't expect a Mic Boost channel to be used with internal 
> microphones. As such to fix this particular hardware, the driver would 
> need to make the internal mic boost be labelled "Internal Mic Boost" as 
> opposed to Mic Boost, which is then is used for both external and 
> internal mics.
> 
>    I'd love to be able to help any way I can to get these fixed once and 
> for all. Let me know if you need more information or what not.
> 

So I saw that you had two selector nodes (0x17 and 0x18), so I figured
one could be "Internal Mic Boost" (for internal mic) and the other one
"Mic Boost" (for external mic).

However, according to the BIOS, you actually have *two* external mic
jacks. Is this correct? It could possibly be that one of them is part of
a headset jack. This might be related to what's confusing the driver, so
perhaps if we just removed the fake mic input that would make things
work.

// David
