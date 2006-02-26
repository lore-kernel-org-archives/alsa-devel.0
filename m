From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [PATCH] Add support for Acer TravelMate and similar laptops
Date: Mon, 27 Feb 2006 09:45:55 +1030 (CST)
Message-ID: <200602262315.k1QNFtak008145@auster.physics.adelaide.edu.au>
References: <44022D35.7050909@akl.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <44022D35.7050909@akl.lt> from "Rimas Kudelis" at Feb 27, 2006 12:35:33 AM
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
Cc: alsa-devel@lists.sourceforge.net, Paulo Matias <syscoder@gmail.com>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

Hi Rimas

> Also, please note the "(?)"'s next to CD and Beep controls. These 
> controls don't actually influence anything now, but I suspect they 
> would work after a few more GPIO commands are issued, so I've left 
> them there for now (read below).

Stylistically I think the "?" can be omitted, but others might have different
opinions.

> Btw, this patch also fixes a few comment typos in patch_realtek.c and 
> changes one setting in test model (it seems like inicially copy-pasted 
> from Fujitsu model). Also, it adds lines muting NID 0x15 for Fujitsu 
> model on startup (Jonathan, you said it turned out not to be 
> problematic at all).

Please, I would very much like to test this Fujitsu change before it goes
in.  It *appeared* that perhaps with the most recent CVS the omission of
NID 0x15 was not necessary but I have not verified this in the context
of the model-specific initialisation verbs yet.

> Jonathan, how about your idea to add GPIO controls to the test model? 

Hopefully coming early this week. 

> Now a few notes/questions:
> * is there any reason in defining ADC NIDs for every model separately? 
> They seem to be the same anyways, and not to get in anyones way. Or do 
> they?

Up to this point the reason for the differing definitions has been
due to the different ways things needed to use the ADC NIDs.  As part of
a consolidation patch I'm preparing for Takashi I hope to clean this
stuff up a bit.

> * If the jack is called "Line In", should I leave it as "Line" in 
> mixer, or should I name it "Line In"?

What do you think is less confusing?

> * What's your opinion about adding a model configuration line that 
> would only check the subvendor (and ignore the subdevice setting)? 
> There would be more chances to autodetect an Acer laptop then, but 
> OTOH, if one day there'll be an ALC-260 based Acer with a different 
> config, you'd risk to misdetect, or to regress in automatic Acer 
> detectlion by removing that line...

I believe the generally accepted way is to include both.  If the machine
config did change in future there's really no guarantee that the existing
models will just magically work.  It's better to effectively force the new
models to be explicitly tested, and only when they're verified do they get
added to the "known model" list.

In the next day or so I'll be sending a list of pending patches to Takashi
(as requested) so everything can be synced correctly and nothing gets
missed.  Some of these will result in minor changes to the Acer config.  Do
you mind if we hold your patch over until then, and I'll submit it with the
rest?  It will make Takashi's (and my) life easier if we do it this way.

Regards
  jonathan


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
