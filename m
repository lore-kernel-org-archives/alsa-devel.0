From: Louis Garcia <louisg00@bellsouth.net>
Subject: Re: Configuring ALSA in kernel-2.5
Date: 27 Mar 2003 17:41:02 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1048804862.2591.10.camel@tiger>
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

I finally got sound working, thanks. Now if I can only get the modules
to load at boot. Here is the sysinit script part that deals with sound.
How can I modify it to load the alsa modules and oss compat modules?
Oh also, gnome-volume-control does not seem to know that alsa is muted.
Is their a way, possibly in /proc or /sys to unmute the sound?

Thanks, --Lou

# Load sound modules if and only if they need persistent DMA buffers
if LC_ALL=C grep -q "options sound dmabuf=1" /etc/modules.conf
2>/dev/null ; then
  RETURN=0
  alias=`/sbin/modprobe -c | awk '/^alias sound / { print $3 }'`
  if [ -n "$alias" -a "$alias" != "off" ]; then
      action $"Loading sound module ($alias): " modprobe sound
      RETURN=$?
  fi
  alias=`/sbin/modprobe -c | awk '/^alias sound-slot-0 / { print $3 }'`
  if [ -n "$alias" -a "$alias" != "off" ]; then
      action $"Loading sound module ($alias): " modprobe sound-slot-0
      RETURN=$?
  fi
fi




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
