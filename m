From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: how to define a 2-index control element?
Date: Mon, 6 May 2002 08:46:20 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0205060830570.520-100000@pnote.perex-int.cz>
References: <200205060131.g461VDD16008@post2.fast.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200205060131.g461VDD16008@post2.fast.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: Abramo Bagnara <abramo@alsa-project.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, 5 May 2002, Paul Davis wrote:

> >On Sun, 5 May 2002, Paul Davis wrote:
> >
> >> >I suggest you to use the field index of struct sndrv_ctl_elem_id (one
> >> >byte per dimension).
> >> >
> >> >id.index = (source << 8) | destination;
> >> 
> >> but there are 1400+ possible id's ...
> >
> >I agree with Abramo. We can eventually optimize code to handle such amount 
> >of controls.
> 
> there's no reason to do that. if you're going to require that the user
> merge two values into a single variable (as above), the user can put
> the merged result in control->value.integer.value[0]. i just wanted a
> way to avoid the user having to do this, because otherwise, it will be
> impossible to ever build an automated GUI for the control (you'll
> never be able to figure out how to generate the correct values from
> the control API's description of the control).

Do we need this? We need to drive hardware via the control API. So each 
controlled elements must be mapped to the user space. In user space, we 
can do more complex remapping for some GUIs in alsa-lib.

> in addition, no automated GUI is possible with 1400+ controls given
> the current API. 
> 
> in short, i really do not want to implement the H-DSP driver with this
> kind of control over the matrix mixer. i raised this issue a month or
> two ago, and there was (implicit) agreement then that it was silly to
> represent all possible combinations with a 1:1 mapping between ALSA
> controls and source/destination pairs.
> 
> i guess i'll continue on trying to think of a different way to do
> this. but it seems to me that if the control API cannot support
> controls that need user data to read/write them, then we need to fix
> the control API.

If you use another system, you'll lose:

- locking of elementary controls
- notification of changes for elementary controls

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com


_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
