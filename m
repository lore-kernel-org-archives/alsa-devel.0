From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: asihpi: Control naming
Date: Fri, 1 Oct 2010 00:47:50 +0100
Message-ID: <20100930234750.GB30949@sirena.org.uk>
References: <4CA4078E.6010601@audioscience.com> <s5h62xng4wm.wl%tiwai@suse.de>
	<4CA4F1D8.50800@audioscience.com> <s5haamz9che.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 34D08103824
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Oct 2010 02:48:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5haamz9che.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Eliot Blennerhassett <eblennerhassett@audioscience.com>, Eliot Blennerhassett <linux@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 30, 2010 at 10:56:45PM +0200, Takashi Iwai wrote:

> So, you have matrix volumes.  We had discussions how to implement
> the matrix volumes, and there is actually an infrastructure to
> handle multi-dimension volume arrays.  But, no driver is using the
> feature, IIRC...

If there was something working well it'd be very useful for embedded
stuff where flexible mixers are very common.
