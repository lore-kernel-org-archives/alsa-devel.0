From: Paul Davis <pbd@op.net>
Subject: Re: how to define a 2-index control element?
Date: Mon, 06 May 2002 07:22:28 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205061121.g46BLOD25612@post2.fast.net>
References: <Pine.LNX.4.33.0205060830570.520-100000@pnote.perex-int.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Mon, 06 May 2002 08:46:20 +0200."
             <Pine.LNX.4.33.0205060830570.520-100000@pnote.perex-int.cz>
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

>> there's no reason to do that. if you're going to require that the user
>> merge two values into a single variable (as above), the user can put
>> the merged result in control->value.integer.value[0]. i just wanted a
>> way to avoid the user having to do this, because otherwise, it will be
>> impossible to ever build an automated GUI for the control (you'll
>> never be able to figure out how to generate the correct values from
>> the control API's description of the control).
>
>Do we need this? We need to drive hardware via the control API. So each 
>controlled elements must be mapped to the user space. In user space, we 
>can do more complex remapping for some GUIs in alsa-lib.

for all the existing controls i've looked at, the existing API seems
capable of telling a user-space application everything it needs to
know about the control in order to usefully control it. in fact,
several elements of the control API appear to be based around
precisely this idea.

this seems like too good a feature thing to give up unless really necessary.

>> i guess i'll continue on trying to think of a different way to do
>> this. but it seems to me that if the control API cannot support
>> controls that need user data to read/write them, then we need to fix
>> the control API.
>
>If you use another system, you'll lose:
>
>- locking of elementary controls
>- notification of changes for elementary controls

i wasn't planning on going outside the control API. i just need some
other way of doing things. As it is, user space can pass multiple data
into the driver via the control->value union. Its just that there is
no way for the control API to tell user space that this is what it
expects. Code written by someone who knows how to use this control
will work just fine, but naive code that thinks it can find out about
a control from the API will not be successful.

right now the API doesn't seem to support the idea that a "read" of a
control requires specific data from the user. is this such a terrible
thing to add?

--p

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
