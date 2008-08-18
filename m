From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Configure and use dmix with a new ASoC driver
Date: Mon, 18 Aug 2008 10:31:53 +0100
Message-ID: <20080818093150.GA1846@sirena.org.uk>
References: <loom.20080816T061550-625@post.gmane.org>
	<20080816165641.GA24879@sirena.org.uk>
	<loom.20080816T190958-341@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 1630624408
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Aug 2008 11:31:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <loom.20080816T190958-341@post.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Simon Tremblay <bidou@videotron.qc.ca>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 16, 2008 at 07:17:19PM +0000, Simon Tremblay wrote:

> Must I create a .conf file for my tlv320aic23b codec or it's ok if I don't have
> one?

You shouldn't need a specific configuration file for your card but you
will need the standard ALSA configuration files there.
