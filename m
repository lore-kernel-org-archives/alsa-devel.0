From: Tony Vroon <tony@linx.net>
Subject: Re: ALSA package release v1.0.26 (user space)
Date: Fri, 07 Sep 2012 14:26:01 +0100
Message-ID: <5049F5E9.2090507@linx.net>
References: <5049E645.2000101@perex.cz> <5049F289.9030503@linx.net>
 <s5htxvaufvp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gold.linx.net (gold.linx.net [195.66.232.40])
 by alsa0.perex.cz (Postfix) with ESMTP id C72F1261711
 for <alsa-devel@alsa-project.org>; Fri,  7 Sep 2012 15:25:40 +0200 (CEST)
In-Reply-To: <s5htxvaufvp.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 07/09/12 14:22, Takashi Iwai wrote:
> I'm not sure about alsa-headers, though.  Isn't it a package 
> containing header files from alsa-lib?

We generate only our headers from alsa-driver, and don't use the
actual drivers in there (favouring the kernel for that). If you're
saying that the same headers can be stolen from the alsa-lib tarball
instead that would be delightful.
I shall have a proper look at this over the weekend or on Monday, and
if I can come up with a good reason as to why that wouldn't work I'll
share it with you.

In all honesty I inherited ebuild scripts that worked like this and
haven't had the need to revise that until now.

Regards,
- -- 
Tony Vroon
Server systems manager
London Internet Exchange Ltd, Trinity Court, Trinity Street,
Peterborough, PE1 1DA
Registered in England number 3137929
E-Mail: tony@linx.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBJ9ekACgkQp5vW4rUFj5qhpQCfSmctWhcqY2FpKqPmcAV18+DX
zhwAnihPe26oXXBAF1L4T9KzxmAemIn5
=GwOC
-----END PGP SIGNATURE-----
