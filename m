From: Peter Zubaj <pzad@pobox.sk>
Subject: Re: [Alsa-devel] Re: Line-in not working on Audigy2
Date: Mon, 21 Nov 2005 20:38:01 +0100
Message-ID: <1132601881.2933.15.camel@localhost.localdomain>
References: <20051104234906.GA7479@cm.nu>
	 <1131222612.13627.26.camel@mindpipe> <20051105204154.GA2134@cm.nu>
	 <1131226035.6781.5.camel@mindpipe> <s5hd5lcpkpu.wl%tiwai@suse.de>
	 <1131378684.8383.14.camel@mindpipe>  <20051121190023.GA2783@cm.nu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <20051121190023.GA2783@cm.nu>
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: Shane <shane-alsa@cm.nu>
Cc: Lee Revell <rlrevell@joe-job.com>, alsa-user@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

There is Analog Mix Capture. Some of analog sources are mixed and then
captured and Analog Mix and Analog Mix Capture controls playback and
capture of this mix. Line in affect both playback and capture volume.

Peter Zubaj

On Mon, 2005-11-21 at 11:00 -0800, Shane wrote:
> On Mon, Nov 07, 2005 at 10:51:23AM -0500, Lee Revell wrote:
> > > > Try this patch.
> > > > 
> > > > Summary: Add support for Audigy 2 subsystem 2006.
> 
> Hi,
> 
> Just got a chance to reboot the machine to test the patch. 
> The card does show up as an Audigy2 in asound.state but I
> still don't get a line capture.  I have a pcm capture, a
> mic capture and a lin2 capture but there doesn't seem to be
> a capture volume for the main analogue line in.
> 
> Shane
> > > > 
> > > > Signed-Off-By: Lee Revell <rlrevell@joe-job.com>
> > > 
> > > FYI, I applied it to CVS now.  Thanks.
> > > 
> > 
> > It would be a big help if someone has time to write a perl script to
> > extract the PCI ID -> name and model number mapping from the Windows
> > drivers, http://www.kxproject.com, and generate the hardware features
> > table.  Email me privately and I'll send you the .inf file.
> > 
> > Lee
> > 
> 



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
