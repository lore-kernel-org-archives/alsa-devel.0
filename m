From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [RFC] Extra info via the TLV interface
Date: Mon, 4 Sep 2006 15:04:43 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0609041455110.9339@tm8103.perex-int.cz>
References: <44FC20B0.4060501@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <44FC20B0.4060501@superbug.co.uk>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 4 Sep 2006, James Courtier-Dutton wrote:

> Hi,
> 
> I would like to now pass extra info regarding the controls via the TLV
> interface.
> 1) Whether the control is Playback, Capture or Both.
> 2) Whether the control is digital or analog.
> 3) Some description of the routing of the control. i.e. how it links to
> other controls.
> 4) Both "short" and "long" mixer control names.
> 5) Control grouping. I.e. to have mixer controls "Front" and "Surround"
> next to each other.

In my opinion, all these GUI hints should be elsewhere (userspace), 
otherwise we'll end up with drivers containing digital photos of 
sound chips in the TLV structure :-)

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
