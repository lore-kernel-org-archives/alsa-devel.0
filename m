From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Multi ice1712 .asoundrc problem
Date: Mon, 14 Nov 2005 04:30:34 -0500
Message-ID: <1131960635.27215.16.camel@mindpipe>
References: <E1EbIYV-00019A-4u@localhost.localdomain>
	 <20051113223105.GA4822@localhost.localdomain>
	 <1131923292.27215.1.camel@mindpipe>
	 <20051114003718.GA5041@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20051114003718.GA5041@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: John Rigg <ad@sound-man.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 2005-11-14 at 00:37 +0000, John Rigg wrote:
> On Sun, Nov 13, 2005 at 06:08:12PM -0500, Lee Revell wrote:
> > On Sun, 2005-11-13 at 22:31 +0000, John Rigg wrote:
> > > This fails with a poll time out. If I add the -C or -P option to start
> > > in capture- or playback-only mode, it starts and runs. 
> > 
> > What happens if you supply both the -P and -C options?  That will give
> > you full duplex without the need to use the asym plugin.
> 
> Exactly the same poll time out occurs. 
> I have separate multi devices defined for playback and capture. 
> If the number of slave channels is not specified as 12 for capture and 10 
> for playback, neither works. To start both I assumed I'd need to combine them 
> into another multi device - I tried asym as it seemed the only possibility. 
> Is there another way, eg. a way to start multi_playback and
> multi_capture devices with a single jackd command?
> 
> John
> 

Yes, for example:

jackd -d alsa -C hw:0,2 -P hw:0,3

Lee



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
