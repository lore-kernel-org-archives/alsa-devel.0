From: Paul Davis <pbd@op.net>
Subject: Re: how to define a 2-index control element?
Date: Sun, 05 May 2002 21:32:12 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205060131.g461VDD16008@post2.fast.net>
References: <Pine.LNX.4.33.0205051747360.509-100000@pnote.perex-int.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Sun, 05 May 2002 17:50:02 +0200."
             <Pine.LNX.4.33.0205051747360.509-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Abramo Bagnara <abramo@alsa-project.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>On Sun, 5 May 2002, Paul Davis wrote:
>
>> >I suggest you to use the field index of struct sndrv_ctl_elem_id (one
>> >byte per dimension).
>> >
>> >id.index = (source << 8) | destination;
>> 
>> but there are 1400+ possible id's ...
>
>I agree with Abramo. We can eventually optimize code to handle such amount 
>of controls.

there's no reason to do that. if you're going to require that the user
merge two values into a single variable (as above), the user can put
the merged result in control->value.integer.value[0]. i just wanted a
way to avoid the user having to do this, because otherwise, it will be
impossible to ever build an automated GUI for the control (you'll
never be able to figure out how to generate the correct values from
the control API's description of the control).

in addition, no automated GUI is possible with 1400+ controls given
the current API. 

in short, i really do not want to implement the H-DSP driver with this
kind of control over the matrix mixer. i raised this issue a month or
two ago, and there was (implicit) agreement then that it was silly to
represent all possible combinations with a 1:1 mapping between ALSA
controls and source/destination pairs.

i guess i'll continue on trying to think of a different way to do
this. but it seems to me that if the control API cannot support
controls that need user data to read/write them, then we need to fix
the control API.

--p

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
