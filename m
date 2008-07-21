From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: RFC: reworking ASOC for large registers
Date: Mon, 21 Jul 2008 13:54:49 +0100
Message-ID: <20080721125444.GH7083@sirena.org.uk>
References: <9e4733910807201847q6d914e58l567a96904679ada8@mail.gmail.com>
	<20080721094828.GC7083@sirena.org.uk>
	<9e4733910807210551m7b4ac64qa111557d104c2993@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 714151037E3
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Jul 2008 14:54:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910807210551m7b4ac64qa111557d104c2993@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 21, 2008 at 08:51:23AM -0400, Jon Smirl wrote:

> I just noticed, the hw read/write routines are already an array of bytes.
> 
> typedef int (*hw_write_t)(void *,const char* ,int);
> typedef int (*hw_read_t)(void *,char* ,int);

Yes, these are defined mostly for ease of use with the I2C API.
