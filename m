From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/5] ASoC: Blackfin: fix bug - kernel
	will	crash when record and play in bf527-ezkit
Date: Fri, 6 Mar 2009 12:01:46 +0000
Message-ID: <20090306120145.GF6493@sirena.org.uk>
References: <1236326010-683-1-git-send-email-cooloney@kernel.org>
	<1236326010-683-2-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D6EA724436
	for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2009 13:01:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1236326010-683-2-git-send-email-cooloney@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bryan Wu <cooloney@kernel.org>
Cc: Cliff Cai <cliff.cai@analog.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 06, 2009 at 03:53:26PM +0800, Bryan Wu wrote:
> From: Cliff Cai <cliff.cai@analog.com>
> 
> set constraint only if the value is not 0, change the configuring way for sport

Hrm.  As far as I can tell the actual effect of this patch is to not do
any of the per-format configuration for the sport if the sport has been
configured once already - as far as I can tell nothing ever resets your
'configured' variable and this is the only place that the data format is
taken into account.  Won't this mean that if a second data format is
played the audio will be mishandled since the hardware will not have
been configured for the new audio format?

If it's really not possible to reconfigure the hardware (I'm assuming
that this is what the actual crash is?) I would expect to see code added
which remembers the format that has been configured and then adds a
constraint in the startup() function enforcing that.
