From: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
Subject: Re: [PATCH 00/10] ALSA: asihpi: updates
Date: Sun, 23 Nov 2014 21:50:49 +1300
Message-ID: <54719FE9.1070002@blennerhassett.gen.nz>
References: <1416453777-7155-1-git-send-email-eliot@blennerhassett.gen.nz>
 <s5htx1qapdq.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from omr2.mail.isx.net.nz (omr2.mail.isx.net.nz [111.65.230.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 90A1726059E
 for <alsa-devel@alsa-project.org>; Sun, 23 Nov 2014 09:50:52 +0100 (CET)
In-Reply-To: <s5htx1qapdq.wl-tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Delio Brignoli <dbrignoli@audioscience.com>
List-Id: alsa-devel@alsa-project.org

On 23/11/14 10:37, Takashi Iwai wrote:
> Good that you are still working on this stuff.

Thanks. I'm no longer a full-time employee of AudioScience,  but doing
some occasional contract work.

> I applied all patches now, as these seem to have been tested.
> But one thing we should avoid is the new use of tasklet.  Can it be
> rewritten with workqueue or interrupted thread?  If either of them
> seems working, please submit an additional patch.

I will take a look.

In any case I need to submit a further patch updating HPI version, and a
corresponding update to ALSA firmware to support new hardware.

regards

Eliot
