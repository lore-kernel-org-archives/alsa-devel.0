From: Florian Schmidt <mista.tapas@gmx.net>
Subject: proposal: "registering" pcm devices to present choice to user
Date: Thu, 21 Oct 2004 22:04:40 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041021220440.7a6f5d40@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (pop.gmx.net [213.165.64.20])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id CF0F833F
	for <alsa-devel@alsa-project.org>; Thu, 21 Oct 2004 21:48:16 +0200 (MEST)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hi,

maybe i'm out of my mind but what do you think of the following:

libasound config files get extended by a "register" keyword like this:

pcm.dmixed {
	type plug
	slave.pcm "dmix"
	register "Software mixed output"
}

Now when alsa lib traverses its config files on app startup it builds a list
of all "registered" pcm's (the same scheme could of course be used for ctl's
and maybe seq's (??)). This list then can be accessed by an alsa app to
present a list of possible devices to the user. Something like this
(ignoring all alsa coding/naming and whatever conventions :)):

// gets the total number of registered pcm device names
unsigned int get_number_of_registered_pcm_devices();

// returns the name of the index'th pcm definition 
// ("dmixed" in above example)
char *get_registered_pcm_device_name(unsigned int index);

// returns the comment of the index'th pcm definition 
// ("Software mixed output")
char *get_registered_pcm_device_comment(unsigned int index);

This could be "easily" (dunno how easy it would be to extent the config
language) added ontop of the existing alsa-lib api and would be completely
backwards compatible as the old pcm selection by name is still available and
very nessecary for this to work in the first place.

what do you think? shall i go sit in the corner? I can imagine this could
ease device selection by computer newbies and illiterates very much. I'm not
asking anyone to do it. I would try my hands on it myself if anyone thinks
this is a good idea.

Of course there should be a sensible preselection of registered names [in
the global config files [stuff like "plug:front:0", "plug:surround50",
etc]], so that the user won't have to do any of this himself if he's not
fumbling with .asoundrc himself.

Florian Schmidt

P.S.: I'm aware that in a sense this is orthogonal to alsa's philosophy when
it comes to device selection, but still i think it could work very well in
practice.


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
