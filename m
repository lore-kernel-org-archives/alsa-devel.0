From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: soc_pcm_trigger
Date: Sat, 4 Jul 2009 10:45:18 +0100
Message-ID: <20090704094517.GA10490@sirena.org.uk>
References: <90a1645d0907012035r61500045pe03f257bedf76821@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id CEFDF1037ED
	for <alsa-devel@alsa-project.org>;
	Sat,  4 Jul 2009 11:45:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <90a1645d0907012035r61500045pe03f257bedf76821@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ccku <ccku1025@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 02, 2009 at 11:35:24AM +0800, ccku wrote:

> why not give machine a chance to run its trigger??
> like machine->ops->trigger.

No great reason, mostly there's just never been any use for one.
