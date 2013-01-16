From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 06/19] ALSA: ymu831: add device interface
 driver
Date: Wed, 16 Jan 2013 13:36:36 +0000
Message-ID: <20130116133636.GE16235@sirena.org.uk>
References: <20130116172530.857b627ef3303fb6fe43f603@linux-mips.org>
 <20130116173204.978b7cba3c9b1a99038ac0b7@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20130116173204.978b7cba3c9b1a99038ac0b7@linux-mips.org>
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

On Wed, Jan 16, 2013 at 05:32:04PM +0900, Yoichi Yuasa wrote:

> +static struct mcdrv_bus_ops *mc_bus_ops;
> +
> +void mc_bus_register(struct mcdrv_bus_ops *ops)
> +{
> +	mc_bus_ops = ops;
> +}
> +

Again this just doesn't look like a serious effort has been made to
integrate whatever thise code does into Linux.  Without some description
of what this is trying to abstract it's hard to comment about what
you're doing here.

The use of a static variable is also a big warning sign here.
