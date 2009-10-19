From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: au1x: psc-ac97:
	reorganize	timeouts
Date: Mon, 19 Oct 2009 16:14:01 +0100
Message-ID: <20091019151401.GC29796@sirena.org.uk>
References: <1255961459-11483-1-git-send-email-manuel.lauss@gmail.com>
	<1255961459-11483-2-git-send-email-manuel.lauss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id ADBF7243CF
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Oct 2009 17:14:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1255961459-11483-2-git-send-email-manuel.lauss@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manuel Lauss <manuel.lauss@googlemail.com>
Cc: Manuel Lauss <manuel.lauss@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 19, 2009 at 04:10:59PM +0200, Manuel Lauss wrote:
> Codec read/write functions: wait 21us between the pokings of hardware.
> Add timeouts to unbounded loops waiting for bits to change.

> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>

Applied both, thanks.
