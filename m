From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: Adding a new architecture to alsa-driver
Date: Sun, 09 Apr 2006 01:23:28 +0100
Message-ID: <1144542208.10642.9.camel@localhost.localdomain>
References: <1144510532.10642.1.camel@localhost.localdomain>
	 <1144512218.22490.146.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1144512218.22490.146.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 2006-04-08 at 12:03 -0400, Lee Revell wrote:
> On Sat, 2006-04-08 at 16:35 +0100, Adrian McMenamin wrote:
> > I've now wasted two days of my life trying to do this and I have had no
> > luck, can someone explain the steps needed to added SH (ie
> > CONFIG_SUPERH) to the alsa-driver build. I am sure somebody knows the
> > steps needed to make this happen
> 
> I already explained it.  What *exactly* does not work if you change the
> Makefiles as I explained?

The changes you suggest simply are inadequate. There is no makefile
without configure and even though I have managed to patch the configure
file so it will create a Makefile, a make simply builds the alsa core
and doesn't touch the sh sub directory despite having this in the
makefile:

ifeq (y,$(CONFIG_SUPERH))
SUBDIRS += sh
endif




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
