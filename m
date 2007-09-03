From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: [PATCH] Gallant SC-6000 driver
Date: Mon, 03 Sep 2007 09:29:52 +0200
Message-ID: <1188804592.14058.1208580205@webmail.messagingengine.com>
References: <20070901090318.8b066a50.krzysztof.h1@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 695AC1038D6
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Sep 2007 09:29:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070901090318.8b066a50.krzysztof.h1@wp.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@wp.pl>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Krzysztof Helt wrote:
> This is port of the Gallant SC-6000 driver from the OSS aedsp16 driver.

Several minor nitpicks below.  Otherwise, it looks fine.

> +       tristate "Gallant SC-6000, Audio Excel DSP 16"
> +       help
> +         Say Y here to include support for Gallant SC-6000 card and
> +         compatible soundcards: Audio Excel DSP 16 and Zoltrix AV302.

It may be a good idea to mention the chip name here (CompuMedia ASC-9308
if Google is to be believed).

> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA

The indentation of the last paragraph is inconsistent.  :-)

> +#define COMMAND_88     0x88    /*                                      */

This command is used.  Could you document it at least a little, "unknown
setup magic" or something like that?

> +/*
> + * sc6000_irq_to_softcfg - Decode irq number into cfg code.
> + */
> +static inline unsigned char sc6000_irq_to_softcfg(int irq)
> +{
> +       unsigned char val = 0;
> +
> +       switch (irq) {
> +       ...
> +       default:
> +               break;

I didn't find any code that checks that the user-supplied irq/port/dma
values are corret.  What happens when the driver tries to configure the
board with invalid values?

> +       if (strcmp("SC-6000", answer))
> +               snd_printk(KERN_ERR PFX "Warning: non SC-6000 audio card!\n");

KERN_ERR for a warning?

> +       snd_printk(KERN_DEBUG PFX "Initializing BASE[0x%lx] IRQ[%d] "

For debug output, please use snd_printd() so that the call isn't
compiled in in non-debug builds.

> +       strcpy(card->driver, "Gallant SC-6000");

If the SC-6600 could be supported by this driver and if there is the
same number of PCM devices (so that alsa-lib can use the same
dmix configuration for both), the driver name should be something
generic like "SC-6x00" or something like that.


Regards,
Clemens
