From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: "test" models in Intel HDA (and probably some other drivers)
Date: Thu, 16 Feb 2006 11:30:47 +1030 (CST)
Message-ID: <200602160100.k1G10lb9023977@auster.physics.adelaide.edu.au>
References: <20060215232101.593131345E@sc8-sf-spam2.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20060215232101.593131345E@sc8-sf-spam2.sourceforge.net> from "alsa-devel-request@lists.sourceforge.net" at Feb 15, 2006 03:20:03 PM
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, rq@akl.lt, rlrevell@joe-job.com, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Takashi wrote:
> The first thing you need to debug is to use the latest ALSA version.
> That is, if you cannot compile drivers, there is no way to debug
> further in the current situation -- even if you can use test model.

This is true of course if there's a lowlevel issue - a problem talking to
the codec and getting it to generate analog output.  In this case I agree
completely with the above comments.

However, in fairness there are a large number of laptops out there utilising
the HDA hardware with the realtek codecs.  In these cases the basic codec
functionality is mostly working fine and has been ever since I started
playing with ALSA on my S7020 (around 1.0.9 or there abouts, from memory). 
The *only* problem on such laptops is the issue of which chip pins the
laptop manufacturers have connected to which jacks/speakers etc.  In these
situations you do not necessarily need the latest CVS (unless of course that
particular model has been recently added) - all you need is a mixer with all
the pin controls enabled so one can discover what controls what.

To consider the situation I'm most familiar with, if you purchase a laptop
today using the ALC260 codec chip, the intel-hda driver will basically work
- the DAC will produce audio quite nicely.  The issue will be one of ensuring
that ALSA's idea of the pin connections reflects reality for that laptop;
if it doesn't ALSA may not present controls which relate to pins in use on
that laptop (resulting in "no sound") or controls which are presented might
not control what ALSA thinks they control.  It is this situation where having
access to the test models would be helpful for users and where the ability
to compile is not necessarily required IMHO.

Lee wrote:
> Please provide the bug ID# of a case where a user could only get sound
> with the "test" model.

I didn't file a bug at the time since I ended up diving in and providing a
patch.  However, the situation I had with the Fujitsu S7020 is one where the
test model, had it existed at the time (Aug/Sept 2005), would have allowed
me to get sound out of all the jacks and the internal speaker, and work out
the routing required without having to resort to hacking mixer controls to
do the tests.  The default HDA model at the time could only manage the
internal speaker (and labelled it "headphones").

The situation being considered is one where the lowlevel hardware is
operating fine and the only problem is the analog routing chosen by the
respective laptop makers.

Of course, whether the presence of the test model in the non-debug
configuration would translate to more bug reports in reality I don't know. 
I guess evidence thus far suggests it wouldn't.

Anyway, I've said enough, the decision has been made and I respect that.

Regards
  jonathan


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
