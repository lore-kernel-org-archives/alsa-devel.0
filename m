From: Louis Garcia <louisg00@bellsouth.net>
Subject: Re: Configuring ALSA in kernel-2.5
Date: 27 Mar 2003 14:55:21 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1048794921.2474.31.camel@tiger>
References: <1048788276.2474.3.camel@tiger>
	 <20030327190215.GA25637@www.angio.com> <1048793663.2474.26.camel@tiger>
	 <20030327193627.GA26072@www.angio.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030327193627.GA26072@www.angio.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Stephen Hassard <steve@hassard.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Sorry no, I'm not running devfs. Where is that script snddevices?

Thanks for your help, --Lou


On Thu, 2003-03-27 at 14:36, Stephen Hassard wrote:
> Make sure you 
> 
> On Thu, Mar 27, 2003 at 02:34:23PM -0500, Louis Garcia wrote:
> > Well that's my question. I'm running 2.5.66 on RH phoebe beta and need
> > to find out what to choose in the config. I have build a kernel with:
> 
> You didn't mention if you're using devfsd or not. I'll assume that it's not working for you since 2.5.66 requires a new devfs daemon, which isn't available as binary for most distros.
> 
> The above being noted, make sure that you run ./snddevices to create the alsa devices in /dev ..
> 
> > < >     OSS PCM (digital audio) API
> 
> you need the above for digital audio (ie: /dev/dsp)
> 
> > These modules load ok when I modprobe. I think I have to install
> > alsa-libs and the oss compat lib? The kernel documentation should be
> > updated soon.
> 
> you don't need alsa-libs or the oss-compat lib for oss functionality .. the above should be enough ..
> 
> also, make sure that your user has permission to write to /dev/dsp.
> 
> you'll probably need a mixer to unmute the audio. alsa, by design, mutes all audio channels.
> 
> later,
> Steve



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
