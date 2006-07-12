From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: independent play(write) on the left/right channel
 of audio devic	e
Date: Wed, 12 Jul 2006 11:53:19 +0200
Message-ID: <20060712095319.GC22449@turing.informatik.uni-halle.de>
References: <C980A03F3B62744E814B843AF92AC6D81ED3E1@tndki007.kiel.thales-naval.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-reply-to: <C980A03F3B62744E814B843AF92AC6D81ED3E1@tndki007.kiel.thales-naval.de>
Content-disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: "Steen, Gerd" <gerd.steen@de.thalesgroup.com>
Cc: "'alsa-devel@lists.sourceforge.net'" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Steen, Gerd wrote:
> my configuration are 2 total independent Task, which need to write on the
> audio device. 
> 
> ->Task one needs to write on the right channel of stereo device Task two 
> ->needs to write on the left channel of stereo device

Put the following in ~/.asoundrc or /etc/asound.conf:

pcm.left {
	type dshare
	slave {
		pcm "hw:0"	# or whatever the stereo device is
		channels 2
	}
	bindings {
		0 0
	}
}	

pcm.right {
	type dshare
	slave {
		pcm "hw:0"
		channels 2
	}
	bindings {
		0 1
	}
}	

Then use devices "left" and "right", or "plug:left" etc. for automatic
sample rate/format conversion.


HTH
Clemens


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
