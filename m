From: Filippo Giunchedi <filippo@esaurito.net>
Subject: Re: detecting codecs for snd-hda-intel ?
Date: Tue, 27 Jun 2006 20:05:14 +0200
Message-ID: <20060627180514.GA21923@esaurito.net>
References: <20060627132656.GA32321@esaurito.net>
	<s5hejxavfr5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hejxavfr5.wl%tiwai@suse.de>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 27, 2006 at 04:23:58PM +0200, Takashi Iwai wrote:
> > any clue on this?
> 
> ALC861 has the following model option values:
> 
> 	  3stack	3-jack
> 	  3stack-dig	3-jack with SPDIF I/O
> 	  6stack-dig	6-jack with SPDIF I/O
> 	  auto		auto-config reading BIOS (default)
> 
> Try model=3stack at first.  This was the old default value

thanks for your quick reply! it works with all of the *stack* models, however in
every model I can't adjust the volume (only PCM slider, no master volume).

Also, the output on lineout is somewhat distorted :| (I noticed that also on
windows btw, I'm suspecting codec problems (?))

filippo

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
