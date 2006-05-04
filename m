From: Nicolas Boullis <nboullis@debian.org>
Subject: Re: How to deal with cards with a large on-board buffer?
Date: Fri, 5 May 2006 01:56:53 +0200
Message-ID: <20060504235652.GI4831@home>
References: <20060502234125.GC4109@home> <s5hirongupx.wl%tiwai@suse.de> <20060504011806.GB6067@home> <s5hpsitg7zs.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hpsitg7zs.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, May 04, 2006 at 04:49:43PM +0200, Takashi Iwai wrote:
> 
> I'd suggest to leave as it is right now.  If underruns occur too
> often, something is wrong in another place, e.g. the timing of
> transfer between HOST and on-chip memories.

Thre certainly is some problem... ;-)
The trouble is that I don't know how to fix them, and I don't even 
really understand what happens...

Have you tried to give a look to my code?


Regards,

Nicolas


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
