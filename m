From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: Intel HDA and Realtek ALC 260
Date: Tue, 7 Feb 2006 09:34:56 +1030 (CST)
Message-ID: <200602062304.k16N4uaS014401@auster.physics.adelaide.edu.au>
References: <43E6E1B1.3000405@akl.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <43E6E1B1.3000405@akl.lt> from "Rimas Kudelis" at Feb 06, 2006 07:42:09 AM
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Rimas Kudelis <rq@akl.lt>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Rimas

> >>would it be possible to add a "test" model, like in case of ALC880, which
> >>would have controls for all of the chipset pins available? I guess that
> >>would simplify things a lot...
> >>    
> >>
> >I think that's possibly worth considering.  I'll have a look into this
> >tonight ...

I implemented this idea last night; refer to a posting of mine from about
half an hour ago for the patch.  As noted in that post, this new patch
assumes my second-pcm patch from a day ago has been previously applied.

> And the naming of controls - I suppose these should either be named the
> way Paulo has named them (0x08 Volume, for example), or similar to what
> they are marked in Realtek datasheet.

I went with names based on the datasheet - that way everyone can work out
what's being refered to since we've all got the same documentation.  You'll
need the datasheet to make sense of the chip's routing.

> BTW the notebook i'm having this problem with is an Acer Travelmate 4060
> series, like Paulo's (but 4061 in my case), so I could help you
> test/debug the Acer model specifics. Don't hesitate to contact me
> regarding this.

Another point of reference would be useful.  Feel free to grab the patches
noted above and have a go.

Regards
  jonathan


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
