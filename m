From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 04/19] ALSA: ymu831: add C-DSP operating
 system data
Date: Wed, 16 Jan 2013 13:23:58 +0000
Message-ID: <20130116132358.GC16235@sirena.org.uk>
References: <20130116172530.857b627ef3303fb6fe43f603@linux-mips.org>
 <20130116172948.268222ea51f19a7536040627@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20130116172948.268222ea51f19a7536040627@linux-mips.org>
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

On Wed, Jan 16, 2013 at 05:29:48PM +0900, Yoichi Yuasa wrote:

> +static const unsigned char mc_cdsp_os[] = {
> +	0xe3, 0x33,		/* program size */
> +	0x2c, 0x01,		/* data size */
> +	/* program */
> +	0x2d, 0x61, 0xaa, 0xae, 0x2d, 0x61, 0x2d, 0x61,

This is a firmware blob, it is totally unsuitable for inclusion in the
kernel.  You should load it with request_firmware().
