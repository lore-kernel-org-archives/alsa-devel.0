From: Rusty Phillips <rustyp@freeshell.org>
Subject: Omnistudio USB further problem report
Date: Thu, 27 Jan 2005 17:23:34 -0500
Message-ID: <1106864615.308.9.camel@localhost.localdomain>
References: <1106345994.17958.31.camel@localhost.localdomain>
	 <1106347480.3232.67.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1106347480.3232.67.camel@krustophenia.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Okay, I can be even more specific with some of it's problems:
1)  The second channel of the USB device is the only channel that has
clicks and pops.  Further, it looks like its outputting a waveform, not
white noise.  It's not 60 hz, but it's pretty close to that.
2)  There are some strange initialization problems:
	If you playback on channels 1 or 2 before recording then Jack will not
do recording and playback at the same time, even though aplay and
arecord run just fine at the same time.  What happens when you try is
that you get white noise saturating the signals on all lines.
	If you record on channels 1 or 2 before playing back, then you can
never playback on 1 and 2 unless you're using jack (i.e. normal alsa
playback doesn't work anymore - all you hear is silence).  This is also
fixed by restarting the device.
3)  The S/N ratio is 10:1 on a -10dB signal.  Isn't that fantastically
bad?

Is there anything you can tell me?  Is anyone working on this?  Will
anyone be working on this?

On Fri, 2005-01-21 at 17:44 -0500, Lee Revell wrote:
> On Fri, 2005-01-21 at 17:19 -0500, Rusty Phillips wrote:
> > I've done a lot to narrow this down, and I know I'm getting crackles and
> > pops on my Omnistudio USB from within the computer (it has zero latency
> > monitoring, so I can hear what happens on the device).
> > 
> > This only happens when recording - not playback, and I know it happens
> > on both my Intel 440BX motherboard (which doesn't have any problems
> > reported - not sure of the actual model) and my Abit KG7, which has a
> > Via 686B southbridge, which is reported to show such problems.
> > 
> > The Abit board is dual-boot, and I found a Windows USB patch from VIA
> > called the "USB filter patch."  This got rid of the pops and crackles
> > when recording in Windows.  
> 
> Please give some more information about what the USB filter patch does.
> Got a link?
> 
> What kernel are you using?
> 
> Lee
> 
-- 



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
