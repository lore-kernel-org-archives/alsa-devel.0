From: Zinx Verituse <zinx@epicsol.org>
Subject: Re: patch, and other via82xx (VT8235) capture problems
Date: Thu, 23 Oct 2003 20:05:02 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031024010502.GA22833@bliss>
References: <20031023044843.GA19701@bliss> <s5hznfr99zs.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hznfr99zs.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 23, 2003 at 06:47:35PM +0200, Takashi Iwai wrote:
> 
> thanks for the patch.  now applied to cvs.
> 
> > Are the specs for the VT8235 available anywhere?
> 
> not in public i know of...
> 

Ah, too bad.

> Takashi

Any ideas on the problem with me not being able to record
if the Input Source is set to Mic?

arecord records when it's set to Line (as it was forced, before),
and does playback as well..

When it's set to Mic, I get no playback from a Mic (and I'm not
wanting to hook up powered output in to the jack when it's set
to Mic), but I suspect it's still Line-in, and the register
being twiddled isn't right, or needs some more setup.

arecord waits a bit, then gives the error I mentioned:
arecord: pcm_read:1110: read error: Input/output error

dmesg says nothing :/

If nothing else, the settings do have to do with the actual
capture sources (idx 0 vs. idx 1), because when I set idx 0
to mic, it can't record, but idx 1 can, and when I set idx 1
to mic, it can't record, but idx 0 can.  When both are set
to mic, neither can record.

Any recommendations for stuff to try would be apreciated, as
I really would like to be able to record without getting
another sound card :/

-- 
Zinx Verituse


-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
