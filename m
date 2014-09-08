From: Jurgen Kramer <gtmkramer@xs4all.nl>
Subject: Re: [PATCH v3] add native DSD support for XMOS based
 DACs
Date: Mon, 08 Sep 2014 19:20:27 +0200
Message-ID: <1410196827.2766.1.camel@xs4all.nl>
References: <1409933686-3032-1-git-send-email-gtmkramer@xs4all.nl>
 <s5hsik2f8wp.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-vbr4.xs4all.nl (smtp-vbr4.xs4all.nl [194.109.24.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 1135E261A8B
 for <alsa-devel@alsa-project.org>; Mon,  8 Sep 2014 19:20:29 +0200 (CEST)
In-Reply-To: <s5hsik2f8wp.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2014-09-08 at 17:07 +0200, Takashi Iwai wrote:
> At Fri,  5 Sep 2014 18:14:46 +0200,
> Jurgen Kramer wrote:
> > 
> > Add quirks for XMOS based DACs for native DSD playback support using the new
> > DSD_U32_LE sample format.
> > 
> > This version adds native DSD support for:
> > - iFi Audio micro iDSD/nano iDSD (they use the same prod. id)
> > - DIYINHK USB to I2S/DSD converter
> > 
> > Changes from v2:
> > - fix and simplify switch statement
> > Changes from v1:
> > - use specific product id and alt setting per XMOS based device
> > 
> > Signed-off-by: Jurgen Kramer <gtmkramer@xs4all.nl>
> 
> Applied with a minor coding style fix.  At the next time, please run
> scripts/checkpatch.pl before the submission.
> 
> Also, don't forget to put maintainers to Cc, and align the subject
> line with the other commits for the target code. 
Thanks, will do for new patches.

Jurgen
