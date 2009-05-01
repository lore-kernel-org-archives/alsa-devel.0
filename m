From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: dmix and mmap
Date: Fri, 1 May 2009 12:32:41 +0100
Message-ID: <20090501113240.GF6975@sirena.org.uk>
References: <bb6204720904300810ma174b6cn825f8565c0b694c0@mail.gmail.com>
	<20090430151301.GA27605@sirena.org.uk>
	<bb6204720904301229q3b0b93eao28563ec7bdef73cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 11CF0243BE
	for <alsa-devel@alsa-project.org>;
	Fri,  1 May 2009 13:32:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <bb6204720904301229q3b0b93eao28563ec7bdef73cb@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Gabriel Johnson <johnsoga@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 30, 2009 at 02:29:41PM -0500, Gabriel Johnson wrote:

> is working.  Now using the ioctl to get mmap address of the dma space
> isn't working, I get a kernel machine check error:

...

> Should the default mmap ioctl functions work on powerpc?

I know that there were some problems with PowerPC memory access,
unfortunately I don't know any specifics or if these issues are fixed in
current kernels.  Searching for postings by Takashi Iwai on the PowerPC
kernel lists might turn something up.
