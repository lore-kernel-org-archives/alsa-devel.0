From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: S/PDIF ac3-passthrough problem
Date: Mon, 21 Aug 2006 10:24:08 +0200
Message-ID: <1156148648.21723.269019688@webmail.messagingengine.com>
References: <20060818180241.GB8513@knm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20060818180241.GB8513@knm.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: mark@knm.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Mark Lehrer wrote:
> Hello there.  I have been having a weird problem for the past few
> months, and I think I am going to have to dive into source code to
> figure it out.  The problem: mplayer can play digital audio through
> the S/PDIF connector, but VLC and Mythtv cannot.  Here is the error
> from VLC:
> 
> [00000311] a52 decoder: A/52 channels:6 samplerate:48000 bitrate:448000
> [00000314] alsa audio output error: internal: can't find audio-device (10)
> 
> Could someone please help me to decipher this error a bit?  VLC has a
> device auto-detect, and it set the output device to hw:0,1.

This is wrong.

Look at the mplayer output (probably with -v) to see which device it opens.
It should be something like "iec958:{CARD 0 .....}".


HTH
Clemens

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
