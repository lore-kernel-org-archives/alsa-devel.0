From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: snd_pcm_ops
Date: Fri, 14 Nov 2008 10:07:11 +0000
Message-ID: <20081114100709.GA21573@sirena.org.uk>
References: <520f0cf10811140108v305639f3x11fdfcbd10c44dac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 59025243B2
	for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2008 11:07:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <520f0cf10811140108v305639f3x11fdfcbd10c44dac@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Kacur <jkacur@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 14, 2008 at 10:08:01AM +0100, John Kacur wrote:

> How is this supposed to work if somewhere down the line
> substream->ops->copy is called?

copy() is an optional operation - if it is not provided then the ALSA core
provides$ a default implementation (see snd_pcm_lib_write_transfer() for
example).
