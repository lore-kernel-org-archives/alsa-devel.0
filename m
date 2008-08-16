From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Configure and use dmix with a new ASoC driver
Date: Sat, 16 Aug 2008 17:56:43 +0100
Message-ID: <20080816165641.GA24879@sirena.org.uk>
References: <loom.20080816T061550-625@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id EBDF324370
	for <alsa-devel@alsa-project.org>;
	Sat, 16 Aug 2008 18:56:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <loom.20080816T061550-625@post.gmane.org>
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

On Sat, Aug 16, 2008 at 06:27:02AM +0000, Simon Tremblay wrote:

> # aplay -v -D plug:dmix /media/usb0/tada.wav
> aplay: main:545: audio open error: Operation not permitted

This doesn't ring any specific bells for me but since you are cross
building and can play without dmix I would be looking at installation
issues with your ALSA user space or a missing device file it needs.
stracing aplay may well provide a useful clue as to what's missing.
