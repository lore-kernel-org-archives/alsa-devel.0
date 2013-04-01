From: Torstein Hegge <hegge@resisty.net>
Subject: Re: [PATCH 06/10] ALSA: usb-audio: UAC2: do clock
 validity check earlier
Date: Mon, 1 Apr 2013 10:16:51 +0200
Message-ID: <20130401081651.GH18838@pvv.ntnu.no>
References: <1364745152-1762-1-git-send-email-eldad@fogrefinery.com>
 <1364745152-1762-7-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from microbel.pvv.ntnu.no (microbel.pvv.ntnu.no [129.241.210.179])
 by alsa0.perex.cz (Postfix) with ESMTP id BE65226170F
 for <alsa-devel@alsa-project.org>; Mon,  1 Apr 2013 10:17:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1364745152-1762-7-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eldad Zack <eldad@fogrefinery.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Sun, Mar 31, 2013 at 17:52:28 +0200, Eldad Zack wrote:
> Move the check that parse_audio_format_rates_v2() do after
> receiving the clock source entity ID directly into the find
> function and add a validation flag to the function.
> 
> This patch does not introduce any logic flow change.

What would be lost by letting __uac_clock_find_source() always check
that the clock source is valid? It would avoid having to pass the
validate parameter, at the cost of having parse_audio_format_rates_v2()
validate clock source.

Torstein
