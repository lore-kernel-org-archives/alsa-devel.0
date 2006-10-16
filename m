From: Daniel Jacobowitz <drow@false.org>
Subject: Re: Asus P5LD2 SE AD1986A snd-hda-intel model and
	master	volume control
Date: Mon, 16 Oct 2006 11:15:13 -0400
Message-ID: <20061016151513.GA22136@nevyn.them.org>
References: <45321DC5.5050608@email.it> <s5hfydobndm.wl%tiwai@suse.de>
	<20061016144326.GA20826@nevyn.them.org>
	<s5hy7rgmhce.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hy7rgmhce.wl%tiwai@suse.de>
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
Cc: EmIScA <emisca@email.it>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 16, 2006 at 05:05:21PM +0200, Takashi Iwai wrote:
> At Mon, 16 Oct 2006 10:43:26 -0400,
> > Or you could adapt the patches I just posted to bind the existing
> > controls :-)
> 
> I've not seen any posts yet...

Weird!  I got a copy back, and it shows up in the sourceforge archives
(Subject: Ganged volume).  Let me know if you want another copy.

> > I'm not sure if there's any advantage, if your PCM control affects
> > all channels; mine only affected front.
> 
> Depends on the codec chip design.
> 
> When you can adjust the volume of each channel at the output PIN (or
> in an earlier path), it's rather annoying that "PCM volume" changes
> only front output.  This will end up with 3 PCM volume controls for
> front, rear and CLFE, which are complex but useless, IMO.

As far as I could tell from the block diagram for the vt1617a, the
master volume affected the output of only the front channel, and the
PCM volume affect the input of only the front channel.  I'm not
entirely clear on why that's useful :-)

-- 
Daniel Jacobowitz
CodeSourcery

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
