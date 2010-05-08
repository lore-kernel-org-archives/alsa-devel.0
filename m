From: Daniel Mack <daniel@caiaq.de>
Subject: Re: usbaudio: Support for USB audio v2.0 devices
Date: Sat, 8 May 2010 03:38:15 +0200
Message-ID: <20100508013815.GD30801@buzzloop.caiaq.de>
References: <20100427140735.GD30804@buzzloop.caiaq.de>
	<4BD702F0.6080108@gmail.com>
	<20100427154346.GH30801@buzzloop.caiaq.de>
	<4BD71E73.5020106@gmail.com>
	<20100427173329.GI30801@buzzloop.caiaq.de>
	<4BDDAEB2.2010303@gmail.com>
	<20100503205558.GM30801@buzzloop.caiaq.de>
	<4BE4135C.80009@gmail.com>
	<20100507201202.GC30801@buzzloop.caiaq.de>
	<4BE48701.2030700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D5C81038C1
	for <alsa-devel@alsa-project.org>;
	Sat,  8 May 2010 03:38:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4BE48701.2030700@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: The Source <thesourcehim@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, May 08, 2010 at 01:32:49AM +0400, The Source wrote:
> Can you create a patch against 1.0.23 alsa-driver package? It would
> be much easier (and faster) to test, thank you.

Is it really? The patch I sent should apply cleanly to a checkout of
Linus' master + Takashi's sound-2.6.git, just like the tree you used for
bisecting. This is also usually a much better way to keep up-to-date,
and patches against ALSA releases are rather uncommon.

Daniel
