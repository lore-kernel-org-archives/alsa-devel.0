From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 05/19] ALSA: ymu831: add C-DSP driver
Date: Wed, 16 Jan 2013 13:32:32 +0000
Message-ID: <20130116133232.GD16235@sirena.org.uk>
References: <20130116172530.857b627ef3303fb6fe43f603@linux-mips.org>
 <20130116173103.afe73d898a082a6e2abbacb4@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20130116173103.afe73d898a082a6e2abbacb4@linux-mips.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Yoichi Yuasa <yuasa@linux-mips.org>
Cc: alsa-devel@alsa-project.org, patch@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 16, 2013 at 05:31:03PM +0900, Yoichi Yuasa wrote:
> 
> Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
> ---
>  sound/soc/codecs/ymu831/Makefile    |    3 +-
>  sound/soc/codecs/ymu831/mccdspdrv.c | 5119 +++++++++++++++++++++++++++++++++++
>  sound/soc/codecs/ymu831/mccdspdrv.h |   57 +

Again, this is an *extremely* large source file which appears to have no
relationship with standard Linux code.  It needs to be broken down into
smaller commits for review, I strongly expect that it needs to be better
integrated into Linux also.
