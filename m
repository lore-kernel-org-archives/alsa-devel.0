From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] add support to reorder CPU and Codec
	DAI	suspend/resume
Date: Wed, 11 Nov 2009 14:20:51 +0000
Message-ID: <20091111142050.GB32595@sirena.org.uk>
References: <1257923457-31470-1-git-send-email-21cnbao@gmail.com>
	<20091111112431.GA18005@opensource.wolfsonmicro.com>
	<3c17e3570911110448v7f7da90bs8ecad60c4afda5bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0EB7910381D
	for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2009 15:20:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <3c17e3570911110448v7f7da90bs8ecad60c4afda5bc@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 11, 2009 at 08:48:19PM +0800, Barry Song wrote:

> Here I have a problem about blackfin TDM. After a deep sleep(all
> suspend to memory and most parts power-down), If codec resumes at
> first, clock ans sync are provided by it at onece. Then while CPU TDM
> interface resumes, it will fail to go back to right status for work.

What trouble does this give the TDM stuff?  It sounds very fragile if
things get confused like this (presumably as a result of having the
clocks running).
