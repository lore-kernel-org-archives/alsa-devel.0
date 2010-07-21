From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: mmotm 2010-07-19 - more pm_qos woes - audio
	this	time
Date: Wed, 21 Jul 2010 13:59:39 +0100
Message-ID: <20100721125939.GB10930@sirena.org.uk>
References: <201007200007.o6K07Xbg028863@imap1.linux-foundation.org>
	<62037.1279716892@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C266103939
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Jul 2010 14:59:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <62037.1279716892@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Valdis.Kletnieks@vt.edu
Cc: Takashi Iwai <tiwai@suse.de>, akpm@linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 21, 2010 at 08:54:52AM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Mon, 19 Jul 2010 16:38:09 PDT, akpm@linux-foundation.org said:
> > The mm-of-the-moment snapshot 2010-07-19-16-37 has been uploaded to
> > 
> >    http://userweb.kernel.org/~akpm/mmotm/

> I've accumulated about 1,000 of these overnight. Seems to be consistently landing in
> pairs based on the timestamps.

This looks like a problem I already reported to James, there's a fix
from him in -next already (folded into the original patch).  It was a
generic problem in the PM QoS stuff when CONFIG_DEBUG_PI_LIST was
selected.  See linux-pm for the discussion.
