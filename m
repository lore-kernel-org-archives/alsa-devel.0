From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: "test" models in Intel HDA (and probably some other drivers)
Date: Thu, 16 Feb 2006 11:07:43 +1030 (CST)
Message-ID: <200602160037.k1G0bhPu023340@auster.physics.adelaide.edu.au>
References: <20060215122901.810A489506@sc8-sf-spam1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20060215122901.810A489506@sc8-sf-spam1.sourceforge.net> from "alsa-devel-request@lists.sourceforge.net" at Feb 15, 2006 04:28:12 AM
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
Cc: rq@akl.lt, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

Rimas wrote:
> > The problem I see here is that those "test" models are only available as
> > a debug feature, which is compiled into the driver only when 
> > CONFIG_SND_DEBUG is defined. I think it would be much more useful to
> > always enable them. ...
> > 
> > Jonathan Woithe said he supports my idea. Takashi, what's your opinion
> > about it? Would you commit a patch fixing this problem to the CVS?

Well, what I said was that I could understand and be happy if the
maintainers wanted to make this change but I wouldn't do it myself - 
there was obviously a reason behind the decision to have things the way
they are and I wasn't fully aware of the issues.

Takashi wrote:
> The test model exists clearly for the debugging purpose.  If only this
> model can bring your device sounds, it means that you need debug
> anyway.  In other words, the test model is not a solution but a method
> to find a solution.

I'm actually not personally fussed either way.  I understand Takashi's
reason for keeping things as they are, but at the same time I can see how
having the test models "in by default" would broaden the potential test base
for these codecs.  If the test models were always available users could
submit useful information to ALSA for their laptop without having to
recompile or patch ALSA - and many people with these laptops have no idea
how to recompile a kernel, nor do they want to.  If the test model was
always available we could simply get them to load that model (which is much
easier than getting source, compiling, installing etc), play with the mixer
and report the findings.  This would be far more useful to ALSA than what
we'd get from these people now (something limited to the likes of "sound
doesn't work").

It is true that the test model is *not* a solution and is rather a tool, as
Takashi said.  One danger of having it "always in" is that some users would
treat it as the solution and we wouldn't get bug reports.

Rimas said:
> That's right, but there's a problem - you cannot find all solutions
> yourself in this case. You need more people for that. IMHO, the more
> people will have access to the method to find a solution, the more
> solutions you'll get. Isn't that a right thing? ...
> :
> Don't forget that there are many people around who aren't Linux geeks,
> and they don't know how to (or simply are afraid/don't want to) compile
> kernel drivers. If we want more Linux on desktops, we should make sure
> Linux is friendly enough for people like them.

This is pretty much along the lines of what I said above.  I guess I can see
both sides to the issue, and there's no real "killer argument" for either
side.

Takashi wrote:
> > So, basically I disagree with changing it.

On balance, if it were up to me I would probably err on the side of always
including the test driver at this stage, for no other reason than to make it
easier for more people to contribute useful information to ALSA.  Down the
track, when the number of untested hardware configurations has decreased
somewhat (resulting in most laptops working out the box under Linux), the
"testing" drivers might well revert to "debug only" status.  However, at the
end of the day Takashi is the maintainer of this driver and I'm happy to go
with whatever he considers is best for the future of ALSA.

Regards
  jonathan


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
