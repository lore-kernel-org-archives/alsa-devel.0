From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Q: Periodsize for capture, SBLive
Date: Wed, 20 Oct 2004 03:57:37 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1098259057.1429.9.camel@krustophenia.net>
References: <200410190807.i9J87NmG000466@www6.pobox.sk>
	 <20041019081918.GB24099@stud.ntnu.no>
	 <1098217687.23367.0.camel@krustophenia.net>
	 <20041020071517.GA27086@stud.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20041020071517.GA27086@stud.ntnu.no>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?ISO-8859-1?Q?Asbj=F8rn_S=E6b=F8?= <asbjs@stud.ntnu.no>
Cc: Peter Zubaj <pzad@pobox.sk>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 2004-10-20 at 03:15, Asbjørn Sæbø wrote:
> On Tue, Oct 19, 2004 at 04:28:08PM -0400, Lee Revell wrote:
> > On Tue, 2004-10-19 at 04:19, Asbjørn Sæbø wrote:
> 
> > [...]
> > > Why will increasing the channel count give lower latency?
> > 
> > http://sourceforge.net/mailarchive/message.php?msg_id=9514175
> 
> 
> Thanks!  That made things at least a bit clearer.  "Still confused, but 
> on a higher level", as it has been said.
> 
> When the post says that the EMU10k1 can record 16 channels, is that for
> digital sources only?  (I am using the analog inputs.)  I have been of the 
> impression that the SBLive was an 5.1 card.
> 
> And what is the EFX device?  What inputs does it correspond to?

The emu10k1 contains a DSP called the FX8010.  On the emu10k1 this has
16 hardware effects buses, on the emu10k2 has 64.  The FX8010 also has
32/64 (emu10k1/10k2) inputs and outputs.  Some (not all) of these map to
physical inputs and outputs.  The EFX device captures these outputs. 
Each PCM stream has an FX bus routing associated with it.  You would use
DSP code to connect the FX buses to outputs, then you can record these
outputs via the EFX device, whether or not they correspond to physical
outputs.

The userspace code to support all this is not quite there yet but it is
close.

Lee



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
