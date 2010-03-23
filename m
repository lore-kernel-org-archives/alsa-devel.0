From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: TWL4030: PM fix for output	amplifiers
Date: Tue, 23 Mar 2010 10:02:10 +0000
Message-ID: <20100323100209.GA7100@sirena.org.uk>
References: <1269264967-2003-1-git-send-email-peter.ujfalusi@nokia.com>
	<20100322161928.GA30295@rakim.wolfsonmicro.main>
	<201003230905.39319.peter.ujfalusi@nokia.com>
	<201003230959.14186.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id CBD27103853
	for <alsa-devel@alsa-project.org>; Tue, 23 Mar 2010 11:02:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201003230959.14186.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 23, 2010 at 09:59:13AM +0200, Peter Ujfalusi wrote:

> /*
>  * Gain controls tied to outputs
>  * -6 dB to 6 dB in 6 dB steps (mute instead of -12)
>  */
> static const unsigned int output_tlv[] = {
> 	TLV_DB_RANGE_HEAD(4),
> 	0, 0, TLV_DB_SCALE_ITEM(-1200, 0,  1),
> 	3, 3, TLV_DB_SCALE_ITEM(-600, 0, 0),
> 	2, 2, TLV_DB_SCALE_ITEM(0, 0, 0),
> 	1, 1, TLV_DB_SCALE_ITEM(600, 0, 0),
> };

> I'm not sure about the tlv declaration, but is there a way to actually map the 
> gain/power control in the TWL in a standard way?

I'd expect that to work in that userspace will see the various values
with the expected gains but I'd not expect that applications would
reorder the values so it'll look odd in the UI.  But I've not actually
tried it.
