From: Torrey Hoffman <thoffman@arnor.net>
Subject: Re: ice1712 driver broken in 2.6.1-mm kernels
Date: Wed, 21 Jan 2004 11:18:50 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1074712729.5895.11.camel@moria.arnor.net>
References: <1074633766.6579.2.camel@moria.arnor.net>
	 <Pine.LNX.4.58.0401202308390.2010@pnote.perex-int.cz>
	 <1074637277.6579.16.camel@moria.arnor.net>
	 <Pine.LNX.4.58.0401210908220.2010@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from devil.servak.biz (devil.servak.biz [209.124.81.2])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA20796
	for <alsa-devel@alsa-project.org>; Wed, 21 Jan 2004 20:22:24 +0100
In-Reply-To: <Pine.LNX.4.58.0401210908220.2010@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA Development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

OK, 2.6.2-rc1 with the alsa-bk-2004-01-20.patch.gz gets my sound working
again, thanks!

Just one problem remains to be solved for this card:  The Audiophile
24/96 is a 4-in, 4-out card (stereo analog input and output, plus
independent SPDIF input and output).  But only one set of inputs and
outputs is showing up for use:

[thoffman@moria thoffman]$ cat /proc/asound/cards
0 [ICH5           ]: ICH - Intel ICH5
                     Intel ICH5 at 0xfc102000, irq 17
1 [M2496          ]: ICE1712 - M Audio Audiophile 24/96
                     M Audio Audiophile 24/96 at 0x6000, irq 20

[thoffman@moria thoffman]$ cat /proc/asound/devices
  0: [0- 0]: ctl
 20: [0- 4]: digital audio playback
 27: [0- 3]: digital audio capture
 26: [0- 2]: digital audio capture
 25: [0- 1]: digital audio capture
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
 33:       : timer
 32: [1- 0]: ctl
 40: [1- 0]: raw midi
 48: [1- 0]: digital audio playback
 56: [1- 0]: digital audio capture

[thoffman@moria thoffman]$ cat /proc/asound/pcm
00-00: Intel ICH : Intel ICH5 : playback 1 : capture 1
00-01: Intel ICH - MIC ADC : Intel ICH5 - MIC ADC : capture 1
00-02: Intel ICH - MIC2 ADC : Intel ICH5 - MIC2 ADC : capture 1
00-03: Intel ICH - ADC2 : Intel ICH5 - ADC2 : capture 1
00-04: Intel ICH - IEC958 : Intel ICH5 - IEC958 : playback 1
01-00: ICE1712 multi : ICE1712 multi : playback 1 : capture 1

Shouldn't there be separate devices for the analog & SPDIF inputs and
outputs?  If not, how do I send different signals to the analog &
digital outputs?

Thanks,

Torrey Hoffman

On Wed, 2004-01-21 at 00:08, Jaroslav Kysela wrote:
> On Tue, 20 Jan 2004, Torrey Hoffman wrote:
> 
> > On Tue, 2004-01-20 at 14:09, Jaroslav Kysela wrote:
> > > On Tue, 20 Jan 2004, Torrey Hoffman wrote:
> > > 
> > > > You may already know this, but the ice1712 driver doesn't work in Andrew
> > > > Morton's 2.6.1-mm? kernels which include the latest ALSA updates.
> > > >
> > > > 
> > > > Tested with an M-Audio Audiophile 24/96. 
> > > 
> > > What exactly does not work? I tested EWX 24/96 with mm3 and it works 
> > > pretty well.
> > 
> > In 2.6.1-mm5, which I'm running at the moment, I just get no sound
> > output.  No error messages.  The envy24control level meters don't show
> > any sound output.
> > 
> > 2.6.1 vanilla works fine.  So does the 2.4 kernel that comes with Fedora
> > Core 1, using the latest ALSA driver sets from FreshRPMs.
> 
> Can you try 2.6.1-rc1 with alsa-bk-2004-01-20.patch.gz available at our 
> ftp site (/pub/kernel-patches)? It should fix your problem.
> 
> 						Jaroslav
> 
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SuSE Labs
-- 
Torrey Hoffman <thoffman@arnor.net>



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
