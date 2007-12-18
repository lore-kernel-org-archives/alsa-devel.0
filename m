From: "Dr. Alexander K. Seewald" <alex@seewald.at>
Subject: Re: Status of Dolby Digital on-the-fly encoding? (via
	a52	plugin)
Date: Tue, 18 Dec 2007 18:02:56 +0100
Message-ID: <20071218170256.GA5652@sdg.at>
References: <20071211132249.GA12802@sdg.at> <s5hlk7t1ulb.wl%tiwai@suse.de>
	<20071217210338.GA30887@sdg.at> <s5hsl20xlce.wl%tiwai@suse.de>
	<20071218145230.GA3861@sdg.at> <s5hejdkxhym.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from seewald.at (seewald.at [213.208.134.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 6447110383C
	for <alsa-devel@alsa-project.org>; Tue, 18 Dec 2007 18:03:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hejdkxhym.wl%tiwai@suse.de>
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

On Tue, Dec 18, 2007 at 02:14:57PM +0100, Takashi Iwai wrote:
> The driver won't work properly for SPDIF I/O on nvidia chipset.  It
> cannot set SPDIF status buts correctly.  AC3 requires non-audio bit,
> and some receivers are sensitive for that.  DTS doesn't seem to
> require it (at least most receivers work).
Do you know of any open-source DTS encoders? Maybe that is simpler than
fixing SPDIF I/O... can this even be fixed, or is it a hardware
restriction? (i.e. buggy hardware)

Best,
  Alex
-- 
Dr. Alexander K. Seewald         +43(664)1106886
              Seewald Solutions                 
------------------------------------------------
         Information wants to be free;
Information also wants to be expensive (S.Brant)
--------------- alex.seewald.at ----------------
