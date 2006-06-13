From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Problem with ALSA on PPC
Date: Tue, 13 Jun 2006 11:45:14 -0400
Message-ID: <1150213515.3062.111.camel@mindpipe>
References: <1149891511.3894.296.camel@mindpipe>
	<1149902770.13569.10.camel@mindpipe>
	<1149933605.5081.1.camel@localhost.localdomain>
	<1149958755.14253.24.camel@mindpipe> <s5h7j3md4bf.wl%tiwai@suse.de>
	<1150149444.3062.55.camel@mindpipe>  <s5hver5bdp5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hver5bdp5.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: Adrian McMenamin <adrian@mcmen.demon.co.uk>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-06-13 at 11:35 +0200, Takashi Iwai wrote:
> At Mon, 12 Jun 2006 17:57:23 -0400,
> Lee Revell wrote:
> > How can I build alsa-lib with a non-standard --prefix, but at runtime
> > have it look for its config files in the standard location?  IOW how do
> > I prevent the --prefix from being prepended?
> 
> How about specifying --datadir=/usr/share explicitly?
> The default config directory is $DATADIR/alsa/alsa.conf.
> 

Won't that cause "make install" to install into /usr/share/alsa on the
build host?

Lee
