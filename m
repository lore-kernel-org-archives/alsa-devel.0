From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 2.6.38] ASoC: Fix bias power down of non-DAPM
	codec
Date: Fri, 10 Dec 2010 17:42:27 +0000
Message-ID: <20101210174227.GH3200@rakim.wolfsonmicro.main>
References: <1291998221-9642-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 51F76245A1
	for <alsa-devel@alsa-project.org>; Fri, 10 Dec 2010 18:42:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1291998221-9642-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 10, 2010 at 06:23:41PM +0200, Jarkko Nikula wrote:
> Currently bias of non-DAPM codec will be powered down (standby/off) whenever
> there is a stream stop. This is wrong in simultaneous playback/capture since
> the bias is put down immediately after stopping the first stream.
> 
> Fix this by using the codec->active count when figuring out the needed bias
> level after stream stop.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> ---
> RFC since does this look a valid fix and how to deal with 2.6.37? I think
> patching the .37 first will result in bisect build errors in mainline when
> later merging upcoming .38 changes. Would it be better to patch .37 after
> it's released?

Better to get a patch in there first, then deal with the merge up to
2.6.38.  Stuff like this really does make me think we should just make
DAPM mandatory.  I should have some time to look at this very soon.
