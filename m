From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] emu10k1 multichannel support
Date: Fri, 28 Jan 2005 22:54:45 -0500
Message-ID: <1106970885.3051.88.camel@krustophenia.net>
References: <1106091073.24484.60.camel@krustophenia.net>
	 <s5hpt01tler.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hpt01tler.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 2005-01-19 at 17:48 +0100, Takashi Iwai wrote:
> At Tue, 18 Jan 2005 18:31:12 -0500,
> Lee Revell wrote:
> > 
> > As promised, here's an updated patch to add real multichannel playback
> > support (and improved multichannel capture) to the emu10k1 driver.
> > 
> > http://www.alsa-project.org/~rlrevell/emu10k1-multichannel-v001.patch
> > 
> > Please test it and report any problems.  I am especially interested in
> > any regressions that impact regular PCM playback (the hw:0,0 device).
> 
> The new function looks great.
> Let me know if you think the patch is mature enough to be merged.
> 
> 

OK, I have posted the latest version:

http://www.alsa-project.org/~rlrevell/emu10k1-multichannel-v007.patch

All the known bugs I mentioned have been fixed.  I would like to test
this version a while before signing off on it, then it should be ready
to merge.  Since this patch touches almost every file in the driver, I
can split it up and post it as a series of patches if necessary.

The mixer controls for multichannel PCM have been fixed and moved to
IFACE_PCM.  My solution was to use the same emu10k1_pcm_mixer_t
structure internally as for regular PCM substreams, but only the "mono"
component is exposed to userspace.

Regular PCM controls (32 substreams, one per substream):

numid=64,iface=MIXER,name='EMU10K1 PCM Send Routing'
  ; type=INTEGER,access=rw---,values=24,min=0,max=63,step=0
  : values=0,1,2,3,0,0,0,0,0,1,2,3,0,0,0,0,0,1,2,3,0,0,0,0
numid=96,iface=MIXER,name='EMU10K1 PCM Send Volume'
  ; type=INTEGER,access=rw---,values=24,min=0,max=255,step=0
  : values=255,255,0,0,0,0,0,0,255,0,0,0,0,0,0,0,0,255,0,0,0,0,0,0
numid=128,iface=MIXER,name='EMU10K1 PCM Volume'
  ; type=INTEGER,access=rw---,values=3,min=0,max=65535,step=0
  : values=65535,65535,65535

Multichannel PCM controls (one 16 channel substream, one per channel)

numid=161,iface=PCM,name='Multichannel PCM Send Routing',index=1
  ; type=INTEGER,access=rw---,values=8,min=0,max=63,step=0
  : values=1,0,13,14,60,61,62,63
numid=177,iface=PCM,name='Multichannel PCM Send Volume',index=1
  ; type=INTEGER,access=rw---,values=8,min=0,max=255,step=0
  : values=255,0,0,0,0,0,0,0
numid=193,iface=PCM,name='Multichannel PCM Volume',index=1
  ; type=INTEGER,access=rw---,values=1,min=0,max=65535,step=0
  : values=65535

Although this wastes a little space, because we allocate for 24 + 24 + 3
elements per channel and use 8 + 8 + 1, I think it's the cleanest
solution.  Using a different structure for the multichannel mixer would
have made the patch a lot bigger.

Lee




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
