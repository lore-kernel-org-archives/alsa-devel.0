From: ross@lug.udel.edu
Subject: Re: ice1712: Card ID problem
Date: Thu, 23 Sep 2004 18:40:42 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040923224042.GA7729@jose.lug.udel.edu>
References: <20040908203346.GA27226@jose.lug.udel.edu> <20040923163649.7xgf4teok0cokcos@webmail.vermonster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20040923163649.7xgf4teok0cokcos@webmail.vermonster.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Brian Kaney <brian@vermonster.com>
Cc: alsa-devel@lists.sourceforge.net, bkaney@gmail.com
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 23, 2004 at 04:36:49PM -0400, Brian Kaney wrote:
> DEBUG: card_eeprom.subvendor = 3b152b11
> DEBUG: adcIDs: 2, 2, 2, 0
> DEBUG: dacIDs: 1, 1, 1, 2
> mixer.c: pcm_output_channels = 8
> mixer.c: nb_active_channels = 8
> mixer.c: input_channels = 8
> mixer.c: nb_active_channels = 0
> using    --- input_channels: 0
>          --- output_channels: 0
>          --- pcm_output_channels: 8
>          --- spdif in/out channels: 2
> 
> 
> Looks like my vendor ID is a) missing something (where is the 0x part?) and 

The 0x part indicates that the number about to follow is in hexadecimal
notation.  I'm not sure why it didn't print.


> b) also not in the envy24control.h file.

As Dirk told me, the real problem is that it's not in the kernel
drivers.  These subvendor ID's need to be added to the driver I guess,
but it's very strange that they're different from the standard.
Especially since mine used to work normally!

> I am a bit over my head here...should I try to cob this vendor id in a 
> similar
> way Dirk posted?

Yea - in your alsa-driver tree (or Linux kernel, if you use 2.6), find
sound/pci/ice1712/delta.h.  Change:

#define ICE1712_SUBDEVICE_DELTA44_2    0x121433a0

to:

#define ICE1712_SUBDEVICE_DELTA44_2    0x3b152b11

And you should be good to go after a recompile.

We really do, however, need a long term solution to this problem.
Manually adding any IDs that come up is going to get old fast...

-- 
Ross Vandegrift
ross@lug.udel.edu

"The good Christian should beware of mathematicians, and all those who
make empty prophecies. The danger already exists that the mathematicians
have made a covenant with the devil to darken the spirit and to confine
man in the bonds of Hell."
	--St. Augustine, De Genesi ad Litteram, Book II, xviii, 37


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
