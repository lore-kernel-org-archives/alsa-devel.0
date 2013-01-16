From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 07/19] ALSA: ymu831: add base driver
Date: Wed, 16 Jan 2013 13:43:41 +0000
Message-ID: <20130116134341.GF16235@sirena.org.uk>
References: <20130116172530.857b627ef3303fb6fe43f603@linux-mips.org>
 <20130116173303.b729a83407513e9a41ef37db@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20130116173303.b729a83407513e9a41ef37db@linux-mips.org>
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

On Wed, Jan 16, 2013 at 05:33:03PM +0900, Yoichi Yuasa wrote:
> 
> Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
> ---
>  sound/soc/codecs/ymu831/Makefile   |    3 +-
>  sound/soc/codecs/ymu831/mcdriver.c | 2934 ++++++++++++++++++++++++++++++++++++
>  sound/soc/codecs/ymu831/mcdriver.h | 1017 +++++++++++++

Same comments as previous patches, really...  this is a very big block
of code with no visible relationship with Linux.  Looking at the code it
seems fairly clear that at least some this stuff ought to be integrated
with the ASoC framework but it doesn't even reference the framework.
