From: Josh Green <jgreen@users.sourceforge.net>
Subject: Re: [linux-audio-dev] Re: Audigy1 MIDI input,
	wavetable support?
Date: 09 Mar 2003 01:16:54 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1047201417.2033.12.camel@sprekhole>
References: <20030307154402.GA338@znex>
	<1047065951.3136.55.camel@sprekhole>  <20030307232944.GA292@znex>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030307232944.GA292@znex>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: LAD <linux-audio-dev@music.columbia.edu>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 2003-03-07 at 15:29, Mark J Roberts wrote:
> Josh Green:
> > If you want to check these projects out, you can either wait a few days
> > for FluidSynth 1.0 to be released which a release of Swami will follow
> > shortly after, or you can get Swami CVS and FluidSynth CVS. Cheers.
> 
> Thanks for all the help. Savannah CVS is giving me unexpected EOFs
> at the moment, so I just tried iiwusynth 0.2.1. I'm very impressed.
> It worked right out of the box.
> 
> Do you have support in the works for DLS/Gigastudio format? I'd be
> thrilled if I could get that working.

Actually, yes :) I'm currently working right now with DLS support (like
within the last few days). I have put a lot of work into getting the
archetecture in place in Swami to support different patch formats.
DLS2/Gigastudio is the first other format I am adding (I have not yet
researched what additional info is added by Gigastudio, if any). I
currently have all the run time objects defined as well as the DLS
loader, just haven't tested it yet. This is all with the new Swami
branch, which is not quite ready for public consumption. FluidSynth is
most likely going to stay SoundFont based, which isn't really a problem,
since it has a nice API that allows for other formats to be synthesized
(within the scope of a SoundFont of course). If you would like to know
when this stuff is available, you could join the swami-devel list
(http://lists.sourceforge.net/lists/listinfo/swami-devel) it currently
has very little traffic, so no worries there. I'm really excited about
where Swami is going, its somewhat of a slow process, but it is
definately getting there :) Cheers.
	Josh Green



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
