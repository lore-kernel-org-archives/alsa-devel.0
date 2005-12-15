From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [RFC] Zero-conf ALSA
Date: Thu, 15 Dec 2005 13:06:02 -0500
Message-ID: <1134669963.12086.124.camel@mindpipe>
References: <1132805024.1921.48.camel@mindpipe>
	 <s5hfypmgx0d.wl%tiwai@suse.de> <1134599222.12086.73.camel@mindpipe>
	 <s5hfyouvdhx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hfyouvdhx.wl%tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, ALSA user list <alsa-user@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 2005-12-15 at 11:52 +0100, Takashi Iwai wrote:
> At Wed, 14 Dec 2005 17:27:01 -0500,
> Lee Revell wrote:
> > 
> > On Thu, 2005-11-24 at 11:28 +0100, Takashi Iwai wrote:
> > > > Can #2 be solved by having dmix prefer power of two period/buffer
> > > sizes
> > > > for the slave hw PCM by default?  AFAICT this should work unless an
> > > ALSA
> > > > app has opened the device first and set an incompatible buffer size.
> > > 
> > > It's not so easy, unfortunately.  We'll need to fix to allow dmix the
> > > arbitrary period/buffer sizes.  As long as the constraints of slave
> > > PCM perido size exists, power-of-2 cannot be applied. 
> > 
> > Is the power of 2 period size restriction imposed by OSS, or dmix?
> 
> It's OSS.

Then why can't the OSS emulation open the slave PCM with a power of 2
period size by default?  AFAICT this would only fail if someone else has
already opened the slave PCM with a non power of 2 period/buffer.

Lee



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
