From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: What is the meaning of the mask values in
	the	pcmhw constraints struct ?
Date: Sat, 24 Oct 2009 15:23:57 +0100
Message-ID: <20091024142356.GA23415@sirena.org.uk>
References: <0D107966AF6D79418315B7C5549F4B5101150A39@lemail1.le.imgtec.org>
	<20091020165037.GA15813@sirena.org.uk>
	<0D107966AF6D79418315B7C5549F4B5101150B9F@lemail1.le.imgtec.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 73B972456B
	for <alsa-devel@alsa-project.org>;
	Sat, 24 Oct 2009 16:23:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <0D107966AF6D79418315B7C5549F4B5101150B9F@lemail1.le.imgtec.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Neil Jones <neil.jones@imgtec.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 23, 2009 at 02:39:58PM +0100, Neil Jones wrote:

> Cheers, I wasn't setting the 'SNDRV_PCM_INFO_MMAP' in my
> snd_pcm_hardware description, because I didn't have MMAP support, I have
> now added MMAP support to my driver to resolve this issue, although I
> thought ALSA/aplay supported drivers without MMAP support ?

It should be supportable, yes, although to be honest I've never actually
looked at hardware that can't deal with mmap() so I don't know off hte
top of my head what the required setup is.
