From: Matt Porter <mporter@embeddedalley.com>
Subject: Re: [PATCH] hda: add sigmatel dig mic support and
	refactor 9227
Date: Wed, 25 Oct 2006 17:00:47 -0400
Message-ID: <20061025210047.GB545@matthew-porters-computer.local>
References: <20061025202110.GA351@matthew-porters-computer.local>
	<1161808721.3982.334.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from oh.embeddedalley.com (cpe-088197.static.wadsnet.net
	[65.114.88.197])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id ADD971A2
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Oct 2006 23:00:48 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <1161808721.3982.334.camel@mindpipe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Lee Revell <rlrevell@joe-job.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 25, 2006 at 04:38:41PM -0400, Lee Revell wrote:
> On Wed, 2006-10-25 at 16:21 -0400, Matt Porter wrote:
> > Adds support for digital microphone pin widgets on SigmaTel codecs.
> > Also refactor 9227 support out of the 927x support since the 9227
> > codecs have some differing pin widgets.
> > 
> 
> Just out of curiosity, what the heck is a digital microphone?

Yeah, I guess that term is used all too commonly with various mic
technologies.  In this case, it's a really small SoC with the analog
front end and digital backend all in one package. It has a PDM
output via a 4 wire interface back to the codec. It looks like they'll
be showing up in laptops and handheld devices in the near future.

Check out http://www.akustica.com for some detailed info.

-Matt

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
