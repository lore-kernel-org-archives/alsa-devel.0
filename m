From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: More than 8 soundcards
Date: Fri, 07 Apr 2006 09:51:54 +0200
Message-ID: <20060407075154.GA4670@turing.informatik.uni-halle.de>
References: <44356C8D.1010402@riccardotempesta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <44356C8D.1010402@riccardotempesta.com>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Riccardo Tempesta <info@riccardotempesta.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Riccardo Tempesta wrote:
> I'm trying to use more than 8 soundcards with ALSA.
> 
> I've seen the following line in "driver.h"
> #define SNDRV_CARDS 8 /* number of supported soundcards - don't change - minor numbers */
> 
> What does "don't change - minor numbers" mean?

That ALSA allocates 32 minor numbers per card, and due to the limit of
256 minor numbers it is not possible to have more than 8 cards.

Since 1.0.11rc1, driver.h has the following code:

/* number of supported soundcards */
#ifdef CONFIG_SND_DYNAMIC_MINORS
#define SNDRV_CARDS 32
#else
#define SNDRV_CARDS 8		/* don't change - minor numbers */
#endif

If you don't use the in-kernel ALSA, add the --enable-dynamic-minors
option to the configure call.


HTH
Clemens


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
