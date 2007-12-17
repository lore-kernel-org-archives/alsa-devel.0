From: "Dr. Alexander K. Seewald" <alex@seewald.at>
Subject: Re: Status of Dolby Digital on-the-fly encoding? (via
	a52	plugin)
Date: Mon, 17 Dec 2007 22:03:38 +0100
Message-ID: <20071217210338.GA30887@sdg.at>
References: <20071211132249.GA12802@sdg.at> <s5hlk7t1ulb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from seewald.at (seewald.at [213.208.134.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 360AD1038BC
	for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2007 22:04:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hlk7t1ulb.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 17, 2007 at 11:30:56AM +0100, Takashi Iwai wrote:
> Check first whether "ac3dec -C foo.ac3" work to send AC3 data (not on
> the fly encoding).  Try a52 plugin after confirming this works.
Does not work with -C, but works with --card=0 - only as a PCM audio
signal, sadly, which already works (no digital dolby, only left and right
speakers are active). I checked -C --card=0 and all the other
settings of ac3dec as well - no success.

> (And, I know there are still some bugs with a52 plugin but no time to
>  play with it right now...)
Problem seems to lie deeper...

Best,
  Alex
-- 
Dr. Alexander K. Seewald         +43(664)1106886
              Seewald Solutions                 
------------------------------------------------
         Information wants to be free;
Information also wants to be expensive (S.Brant)
--------------- alex.seewald.at ----------------
