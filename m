From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH]ASoC: Create a common directory for AVR32
	and ARM9 atmel boards.
Date: Thu, 2 Oct 2008 16:07:32 +0100
Message-ID: <20081002150731.GH2848@sirena.org.uk>
References: <48E47D42.8080306@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3050A24362
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Oct 2008 17:07:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48E47D42.8080306@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Cc: alsa-devel@alsa-project.org, Geoffrey Wossum <geoffrey@pager.net>, Frank Mandarino <fmandarino@endrelia.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 02, 2008 at 09:50:26AM +0200, Sedji Gaouaou wrote:

> Create a common directory for AVR32 and ARM9 atmel boards to unify atmel 
> audio DAI.

> Signed-off-by: Sedji Gaouaou <sedji.gaouaou@atmel.com>

Hrm.  It doesn't look like playpaq_wm8510.c will build after this change
- for one thing, at32-pcm.h and at32-ssc.h don't exist any more in the 
new atmel directory but there's no change to the file to reflect that.
If you're unable to test AVR32 yourself then perhaps Geoffrey (CCed)
will be able to help out here?

Also, please note the changes to the playpaq driver which were made in
commit c2d8a0f79a63e3d3ead52fba3a6300f86514758b which was merged into
Takashi's tree the other day.

Can I also suggest splitting this up so that you do the merge of the
existing code in one patch then add your new board drivers in another?
If nothing else it'd bring down the size of the main diff.  :)
