From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Mixer Event
Date: Fri, 8 Oct 2004 13:44:23 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0410081343470.2723@pnote.perex-int.cz>
References: <41667ABC.8080805@vidsoft.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <41667ABC.8080805@vidsoft.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Gregor Jasny <jasny@vidsoft.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 8 Oct 2004, Gregor Jasny wrote:

> Hi all,
> 
> I want to poll a mixer device for events. After setting the callback 
> handler i get for every channel a callback with mask 4 (I think this is 
> 'add device'). But after waiting at poll() and altering the volume of a 
> channel I get an error at snd_mixer_poll_descriptors_revents():
> 
> snd_mixer_poll_descriptors_revents() POLLNVAL:  Operation not permitted
> 
> I've attached the source.

'revents && POLLNVAL' should be 'revents & POLLNVAL'

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
