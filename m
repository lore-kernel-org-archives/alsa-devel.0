From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ARM S3C2410: Trigger stop problems
Date: Sun, 11 May 2008 13:47:53 +0100
Message-ID: <20080511124752.GA14536@sirena.org.uk>
References: <482697D3.1000306@elpa.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E802C2435D
	for <alsa-devel@alsa-project.org>;
	Sun, 11 May 2008 14:47:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <482697D3.1000306@elpa.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "ing. Davide Rizzo" <davide@elpa.it>
Cc: Ben Dooks <ben@simtec.co.uk>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, May 11, 2008 at 08:53:07AM +0200, ing. Davide Rizzo wrote:
> My platform is a S3C2410 with a PCM3006 codec connected through I2S.
> I have a problem on trigger stop: some part of the sound is replayed at 
> the sound end.
> I noticed that the s3c2410-pcm enqueue function at the end of the sound 
> reprograms the dma at initial values, is this wanted ? Why ?
> Who should call the trigger stop function to stop the sound at the exact 
> final sample ?

CCing in Ben Dooks, the s3c24xx maintainer.
