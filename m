From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Alsa-lib 'cancelability'
Date: Mon, 22 Aug 2016 19:37:23 +0200
Message-ID: <5780ba02-e3b2-2cd6-e35e-a16fd77bc951@ladisch.de>
References: <201608221741.21375.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 34F16265E07
 for <alsa-devel@alsa-project.org>; Mon, 22 Aug 2016 19:37:32 +0200 (CEST)
In-Reply-To: <201608221741.21375.gineera@aspect135.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alan Horstmann <gineera@aspect135.co.uk>, alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Alan Horstmann wrote:
> I am wondering if there is a policy on the thread 'cancelability' /
> 'cancellability' of the functions in Alsa-lib?

Yes.  The policy is "don't even think about it".

> The callback runs in it's own thread; when a user requests 'AbortStream'
> a thread cancel is requested.

Alsa-lib is not the only library with this 'policy'.  You cannot cancel
threads over whose code you do not have complete control.


Regards,
Clemens
