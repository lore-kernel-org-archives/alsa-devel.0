From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Arm based driver ?
Date: Wed, 27 Nov 2002 15:31:42 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0211271530360.532-100000@pnote.perex-int.cz>
References: <3DE4CAEA.6020006@mail.alamy.idv.tw>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3DE4CAEA.6020006@mail.alamy.idv.tw>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alamy Liu <alamy_alsa@mail.alamy.idv.tw>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 27 Nov 2002, Alamy Liu wrote:

> Hi All,
> 
>   I am going to write a audio driver which connect to ARM based CPU 
> directly using I2C and L3.
>  From the developer's document. It seems the main structure are Card & 
> Chipset.
> In the Card layer, what kind of card driver should I implement ?
>   A virtual-card ?  (exp : i2c/i2c-pxa250.c and l3/l3-pxa250.c 
> (i2c/l3/l3-pxa250.c ?) )
> Or there is another structure for such a situation ?

Drivers for I2C chips should go to: i2c/
Drivers for L3 chips should go to:  i2c/l3/
The card module should go to:       arm/

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
