From: Juan Linietsky <coding@reduz.com.ar>
Subject: Re: Alsa MIDI device description extension proposal.
Date: Sat, 23 Mar 2002 22:39:59 -0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020323223959.2c3dd215.coding@reduz.com.ar>
References: <20020322221629.57fa7159.coding@reduz.com.ar>
	<3C9D1F46.EDBA5BF0@hardco.de>
	<20020323221416.64d0ed46.coding@reduz.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <20020323221416.64d0ed46.coding@reduz.com.ar>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


> Yet again, I think sysex is dumb, because of the above reasons. It's just annoying in any possible way. A library call plus driver support is simpler and cleaner for the developer and the user. Alsa sequencer does rock and it's extremely simple to use, and these are the main advantages. Implementing this functionality as sysex would really be a big annoyance.
> And from what i know It's not more work for the library developing, A driver is not supposed to be forced to answer that IO call, if the driver
> doesnt support it, will just return an error in the call, and alsa lib will take care of that.
> 
> 

I think this wasnt clear enough, let me rephrase it better.

Sysex is basically meant for users, so using sysex brings the following problems:
-It's harder from the developer standpoint to do this, specially from their app. It's harder to code, much less abstracted (since he's not supposed to manage sysex code at driver level) Instead of just using a few simple library calls, he has to capture the input sysex calls, and parse it. And, also being myself such a fan of how clean the alsa sequencer api is, this would be torture ;). Also more annoying for driver developers
who instead of just sending the info, they have to encoding as sysex.
-It's useless for the user. This is not some kind of sysex you use to set patches or something like that. It's sysex for retrieving information that "interferes" with the normal way you communicate with the driver, so the user has access to things that there isnt any point in it having access to.

So, thats why I really think the sysex approach is overcomplicated, kills
the clean interface to the alsa sequencer, and since it's only for alsa,
it definitively has no point in being there. A library call is simpler to use, simpler to write, and fits much nicer with the overal sequencer api.

I know that probably many of you think this is not the right approach
just because of the fact that it hasnt been done before in audio APIs.
But this only because of midi limitations that no one attempted this.
It's only starting to be done recently, and one of the better examples
is Steimbergs VST and Sonar's DXi, which both finally allow for this

(Althought I dont like the way those apis work since they force you to run an instance of the program per channel)

All in all, i think this HAS to be a library call, it's not some extra useless thing, and I'm sure that any programmer of sequencer programs 
will like to make use of it, as much as users will like the result.
(And I'm telling you this from my perspective which is both user 
and app programmer)

regards

Juan Linietsky













> regards.
> 
> Juan Linietsky
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
