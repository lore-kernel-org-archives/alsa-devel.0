From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: IMX31 Audio Driver issue
Date: Mon, 29 Jun 2009 16:51:20 +0100
Message-ID: <20090629155119.GG11855@sirena.org.uk>
References: <7df11cd50906250152u500a6a06ud7093d996c3e2b67@mail.gmail.com>
	<20090629154706.GH29236@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 1913F24837
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Jun 2009 17:51:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090629154706.GH29236@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Harish Kumar <harishkumarb7@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 29, 2009 at 05:47:06PM +0200, Daniel Mack wrote:

> Is anyone working on some clean and sane patches for this hardware?

Freescale have some patches in the Ubuntu Jaunty kernel (2.6.28 based)
which didn't look screamingly awful, at least not for the audio side.  I
got them building but didn't get round to kicking the SDMA code yet.
Last I heard from the Ubuntu guys they were supposed to be trying to
upstream but I've not seen any sign of that yet.
