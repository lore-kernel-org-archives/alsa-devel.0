From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Sound Card Driver
Date: Mon, 20 Dec 2004 00:43:00 -0500
Message-ID: <1103521381.1252.62.camel@krustophenia.net>
References: <1103520934.5179.13.camel@oaks.mumbai.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1103520934.5179.13.camel@oaks.mumbai.redhat.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: kshriyan@redhat.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 2004-12-20 at 11:05 +0530, Kaushal Shriyan wrote:
> Hi All !
> 
> I have got INTEL915GM Mother Board with onboard sound chip
> C-Media CM9880L with RHEL 3.0 Base kernel Loaded(2.4.21-4.EL).
> I would appreciate if you can guide me how to build driver.
> 
> I have downloaded alsa-driver-1.0.7,but I am getting the below error
> 
> 1 out of 8 hunks FAILED -- saving rejects to file pdaudiocf.c.rej

This looks like a bug.

But, you could probably work around the problem by only compiling for
the card you use.  Assuming that chipset requires the intel8x0 driver,
try cvscompile --with-cards=intel8x0, or ./configure
--with-cards=intel8x0 in the alsa-driver directory.

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
