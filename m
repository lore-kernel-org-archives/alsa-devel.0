From: Michael Wagener <mike.wagener@web.de>
Subject: via82xx on MSI K8T Neo2 FIR (simple patch included)
Date: Mon, 25 Oct 2004 21:58:31 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <417D5AE7.2000601@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

via82xx works on MSI K8T Neo2 FIR with dxs_support=1:

Patch against alsa-1.6a is as follows:

> --- via82xx.c-old       2004-08-02 16:24:38.000000000 +0200
> +++ via82xx.c   2004-10-25 21:41:52.418241056 +0200
> @@ -2101,6 +2101,7 @@
>                 { .vendor = 0x1462, .device = 0x3800, .action = VIA_DXS_ENABLE }, /* MSI KT266 */
>                 { .vendor = 0x1462, .device = 0x7120, .action = VIA_DXS_ENABLE }, /* MSI KT4V */
>                 { .vendor = 0x1462, .device = 0x5901, .action = VIA_DXS_NO_VRA }, /* MSI KT6 Delta-SR */
> +               { .vendor = 0x1462, .device = 0x7023, .action = VIA_DXS_ENABLE }, /* MSI K8T Neo2 FIR */
>                 { .vendor = 0x1584, .device = 0x8120, .action = VIA_DXS_ENABLE }, /* Gericom/Targa/Vobis/Uniwill laptop */
>                 { .vendor = 0x161f, .device = 0x202b, .action = VIA_DXS_NO_VRA }, /* Amira Note book */
>                 { .vendor = 0x161f, .device = 0x2032, .action = VIA_DXS_48K }, /* m680x machines */

ac97 is an ALC850 which works with the latest ac97_codec.c.

regards,
Mike


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
