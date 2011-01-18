From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: [PATCH - [hdspm] 1/3] Add headers for RayDAT and
	AIO support.
Date: Tue, 18 Jan 2011 16:00:39 +0100
Message-ID: <20110118150039.GU21889@ltw.loris.tv>
References: <1295359939-14673-1-git-send-email-adi@drcomp.erfurt.thur.de>
	<1295359939-14673-2-git-send-email-adi@drcomp.erfurt.thur.de>
	<s5hmxmygtre.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [85.14.220.160])
	by alsa0.perex.cz (Postfix) with ESMTP id EC9ED245D8
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 16:00:50 +0100 (CET)
Received: from localhost (ltw.loris.tv [127.0.0.1])
	by ltw.loris.tv (Postfix) with ESMTP id 891BD1AC62E
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 16:00:44 +0100 (CET)
Received: from ltw.loris.tv ([127.0.0.1])
	by localhost (ltw.loris.tv [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id bweuKoZV+3HN for <alsa-devel@alsa-project.org>;
	Tue, 18 Jan 2011 16:00:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hmxmygtre.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 18, 2011 at 03:40:21PM +0100, Takashi Iwai wrote:

> Adrian Knoth wrote:
> > 
> > +struct hdspm_peak_rms {
> > +		uint32_t input_peaks[64];
> > +		uint32_t playback_peaks[64];
> > +		uint32_t output_peaks[64];
> Strange indentation level?

Indeed. Fixed.

> > +struct hdspm_status {
> > +	hdspm_io_type card_type;
> > +	hdspm_syncsource autosync_source;
> > +
> > +	unsigned long long card_clock;
> Use more explicit int type with bit width.

Done.

> > +static char *texts_sync_status[] = {
> > +	"no lock",
> > +	"lock",
> > +	"sync"
> > +};
> 
> Put these to *.c.

Looks like this array is actually unused. Let's see which of them can be
dropped or moved to *.c.

I'll have to cross-check with hdspmixer, some parts are referenced
there.


Cheers

-- 
mail: adi@thur.de  	http://adi.thur.de	PGP/GPG: key via keyserver
