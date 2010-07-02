From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: linux vs c99 fixed width types
Date: Fri, 2 Jul 2010 11:28:51 +0100
Message-ID: <20100702102850.GA30655@sirena.org.uk>
References: <4C2D3D36.3020009@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id EFFA610383E
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Jul 2010 12:28:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4C2D3D36.3020009@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eliot Blennerhassett <linux@audioscience.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 02, 2010 at 01:13:26PM +1200, Eliot Blennerhassett wrote:

> Currently HW32 is translated into u32 before I submit patches to you.
> Should I do the same for the C99 types, or let them pass through unaltered?

Linux standard is to use u32 and friends rather than the C99 types.
