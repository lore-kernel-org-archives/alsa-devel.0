From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: AC3 Passthrough on Audigy2 ZS not working
Date: Fri, 11 Mar 2005 15:09:58 -0500
Message-ID: <1110571798.19093.9.camel@mindpipe>
References: <20050311112625.770838C515@sc8-sf-spam1.sourceforge.net>
	 <4231C749.80807@mail.utexas.edu>
	 <1110568030.14807.44.camel@cthulhu.rlyeth.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <1110568030.14807.44.camel@cthulhu.rlyeth.net>
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: The Orqwith Vagrant <theorqwithvagrant@bredband.net>
Cc: alsa-user@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 2005-03-11 at 20:07 +0100, The Orqwith Vagrant wrote:
> > I actually read through those threads, but as you say, the conversation
> > trailed off. I have a Sony STR-DE697, so I'm not in exactly the same
> > boat as you're in - but given that the AC3 pass-through works correctly
> > in windows, there cannot be an inherent hardware problem. I'm
> > unfortunately not able to do any capture tests as the basic ZS doesn't
> > have an spdif in.
> > 
> > --phil
> 
> Our amps may, however, both be using the same DSP processor for DD/DTS
> decoding. Sony doesn't spell out what DSP they are using, but some
> digging revealed that some previous Sony models with 32-bit DSPs have
> used DSPs from the Analog Devices "SHARC" family of DSPs. I've tried to
> find a service manual for the STR-DE697, to make sure, but been
> unsuccessful. I'm realistic, so I won't ask you to open up your amp and
> take a peek... ;)
> Anyway, if they both do use SHARCs, we may still be hitting the exact
> same problem, since the part of our amps that actually recieve and
> process the SPDIF stream would be the same, even if the amps themselves
> have different manufacturers.
> 
> In any case, your situation sounds much too similar overall for me not
> to believe the root cause isn't the same. Let's see if James or any of
> the other alsa devs manage to find something interestnig in the dumps I
> provided; if they come up with a fix that solves the problem for me and
> Brian, I'm willing to bet it will work for you as well. But time will
> tell... :)

[cc'ing alsa-devel]

James actually had an idea about what may cause this.

Apparently the Audigy2 has a hardware bug where AC3 passthrough has a
one sample phase error between the left and right channel, and the left
and right channel are swapped.

It's possible that some receivers really don't like this.

Fortunately this bug can be 100% worked around in the DSP code.  I have
not had time to implement it yet.  But if you can understand emu10k1 DSP
code and want to see how it's done, check out the "Epilog" plugin from
this (Windows) driver:

http://www.kxproject.com

Lee




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
