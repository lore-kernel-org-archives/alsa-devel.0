From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [patch] Add ID for Hercules PC DJ Console (Windows
 Edition)
Date: Wed, 5 Oct 2005 14:23:34 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0510051419030.3797-100000@studcom.urz.uni-halle.de>
References: <2c746f620510040252o4f7eb7d6s2a28a3b99a0e0ce8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <2c746f620510040252o4f7eb7d6s2a28a3b99a0e0ce8@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Eric Shattow <lucent@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Eric Shattow wrote:
> The following patch is against today's CVS code.
>
> ...
> +               /* Hercules DJ Console (Windows Edition) */
> +               .id = USB_ID(0x06f8, 0xb000),
> +               .ignore_ctl_error = 1,
> ...

Thanks, applied (by hand, your mailer destroyed line wrapping and
whitespaces).

Clemens



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
