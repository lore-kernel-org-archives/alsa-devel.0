From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 11/13] ALSA: Deletion of checks before the function call
 "iounmap"
Date: Wed, 26 Oct 2016 14:28:59 +0200
Message-ID: <1477484939.4059.35.camel@sipsolutions.net>
References: <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net> <54A9355F.4050102@users.sourceforge.net>
 <54A941C1.4020906@users.sourceforge.net> <20161026122605.GA3911@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20161026122605.GA3911@mwanda>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Dan Carpenter <dan.carpenter@oracle.com>, SF Markus Elfring <elfring@users.sourceforge.net>
Cc: alsa-devel@alsa-project.org, Russell King <linux@arm.linux.org.uk>, linux-parisc@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, Clemens Ladisch <clemens@ladisch.de>, LKML <linux-kernel@vger.kernel.org>, Jaroslav Kysela <perex@perex.cz>, Julia Lawall <julia.lawall@lip6.fr>, Thibaut Varene <T-Bone@parisc-linux.org>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2016-10-26 at 15:26 +0300, Dan Carpenter wrote:
> Someone was just mentioning in another thread that removing the check
> from iounmap() is not portable to other arches and then I remembered
> that Markus removed a bunch of these.
> 
> We should consider reverting this, perhaps?

Can't we teach all architectures? Not that reverting it would be a
problem.

johannes
