From: Mark Knecht <markknecht@comcast.net>
Subject: Re: sbLive! -Drive digital IOs exchanged?
Date: Mon, 05 Jan 2004 09:07:59 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1073322479.1905.4.camel@Wizard.knechthome.com>
References: <200312242220.57516.e.jokisch@u-code.de>
	 <s5h65fq2v0v.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h65fq2v0v.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: e.jokisch@u-code.de, Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 2004-01-05 at 08:57, Takashi Iwai wrote:
> At Wed, 24 Dec 2003 22:20:57 +0100,
> Eckhard Jokisch wrote:
> > 
> > Hello guys,
> > I just noticed that the controls ( or their names) of the digital inputs of 
> > Live!-drive are changed. If I want ot get sound out of the coaxial inputs I 
> > have to raise the optocal s "sliders" in alsamixer as well as in 
> > alsermixergui. 
> 
> i don't see any changes of codes regarding this...
> is only the capture switch swapped?
> (to be sure, do you mean "IEC958 Optical Capture" and "IEC958 Coax
> Capture", right?)
> 
> 
> Takashi
> 
Recently the I/O's of the Hammerfall Light also changed:

Old 

playback_1-8   -> ADAT1
playback_9_16  -> ADAT2
playback_17-18 -> spdif (I suppose)

Now

playback_3-10  -> ADAT1
playback_11-18 -> ADAT2
playback_1-2   -> spdif (I suppose)



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
