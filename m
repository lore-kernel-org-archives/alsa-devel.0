From: Andy Wingo <wingo@pobox.com>
Subject: Re: Another question/note regarding CVS compile process
Date: Wed, 15 May 2002 21:30:26 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020516013025.GF608@jesus>
References: <000001c1fc61$fffe07b0$ac1f830a@ico>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from jesus (rdu162-226-026.nc.rr.com [24.162.226.26])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id DAA24470
	for <alsa-devel@alsa-project.org>; Thu, 16 May 2002 03:30:59 +0200
Content-Disposition: inline
In-Reply-To: <000001c1fc61$fffe07b0$ac1f830a@ico>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 15 May 2002, Ivica Bukvic wrote:

> One more thing I noticed about my build process:
> 
> When I do ./build prep
> 
> I get the following response:
> 
> aclocal: ../alsa-lib/utils/alsa.m4: 15: duplicated macro 'AM_PATH_ALSA'

This is buggy behavior on the part of aclocal. aclocal comes with
automake, if I recall correctly; upgrade your automake and this error
will go away. Mine is 1.5, as I have automake 1.5. The 1.4 series might
still have this bug, I don't know.

regards,

wingo.

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
