From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Problem with ALSA on PPC
Date: Mon, 12 Jun 2006 18:33:10 -0400
Message-ID: <1150151590.3062.61.camel@mindpipe>
References: <1149891511.3894.296.camel@mindpipe>
	<1149902770.13569.10.camel@mindpipe>
	<1149933605.5081.1.camel@localhost.localdomain>
	<1150112496.21190.38.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1150112496.21190.38.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Cc: Adrian McMenamin <adrian@mcmen.demon.co.uk>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 2006-06-12 at 12:41 +0100, Liam Girdwood wrote:
> Fwiw, I've been using OE 
> 
> http://www.openembedded.org/
> 
> to do all my embedded (non x86) ALSA user space building. It's quite
> simple and I've not had any issues wih building alsa-* yet. It even
> creates the device nodes and puts all the config files in the correct
> place in your target file system. 

I use Kegel's crosstool:

http://www.kegel.com/crosstool/

and modified scripts from the board vendor.  I can't easily switch as
this is what everyone else in the shop uses.

I guess OE solves this problem by building in a chroot or something?  I
cannot see a way to prevent alsa-lib from prepending $PREFIX to the
location of the config files.

Lee
