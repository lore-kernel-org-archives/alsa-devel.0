From: Hanbiao Wang <hbwang@lecs.cs.ucla.edu>
Subject: Re: Stream Synchronization of VXPocket 440 card
Date: Fri, 8 Oct 2004 10:00:08 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0410080948120.27057@concorde.cs.ucla.edu>
References: <Pine.LNX.4.58.0410071320100.16810@concorde.cs.ucla.edu>
 <s5hzn2x5xu8.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hzn2x5xu8.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 8 Oct 2004, Takashi Iwai wrote:

> At Thu, 7 Oct 2004 13:44:04 -0700 (PDT),
> Hanbiao Wang wrote:
> >
> > Hi all,
> >     VXPocket 440 card has two stereo input streams. Can these two streams be
> > synchronized by calling snd_pcm_link()?
> >     According to the ALSA project webpage, streams can synched only if the
> > hardware supports this feature. The ALSA project webpage, the
> > snd_pcm_info_get_sync() function returns synchronization ID -
> > snd_pcm_sync_id_t, which is equal for hardware synchronized streams.
> > I examined the sync IDs of these two streams of the VXPocket 440 card as
> > follows:
> > 1. call snd_pcm_open() on hw:0,0 in order to get pcm handle h0
> > 2. call snd_pcm_info() on pcm handle h0 to get pcm info f0
> > 3. call snd_pcm_info_get_sync() on f0 to get sync ID0 of hw:0,0
> >
> > 4. call snd_pcm_open() on hw:0,1 in order to get pcm handle h1
> > 5. call snd_pcm_info() on pcm handle h1 to get pcm info f1
> > 3. call snd_pcm_info_get_sync() on f1 to get sync ID1 of hw:0,1
> >
> > snd_pcm_sync_id_t has three data fields:
> > unsigned char 	id [16]
> > unsigned short 	id16 [8]
> > unsigned int 	id32 [4]
> >
> >     ID0.id is "-1073743584" while ID1.id is "-1073743600". These sync IDs
> > are apparently not identical. So these two streams look like not synched
> > by the hardware. However, the manufacture of VXPocket 440 cards told me
> > that these two input streams share the same internal hardware clock. So
> > there is no obvious reason for the hardware not to synchronizes these two
> > input streams. The is a contradiction to me. Is there anything wrong in my
> > examination code? Please help me on this issue if you have any experience
> > related to my question. Thanks a lot in advance.
>
> You're not wrong.  The h/w sync feature is not implemented (yet) on
> ALSA vx drivers :)  You can still use software sync with
> snd_pcm_link(), though.
>
>
> Takashi
>
Takashi,
    Thanks a lot. Your answer is very helpful. I have a related question.
I first run snd_pcm_link() on the PCM handles of hw:0,0 and hw:0,0 of
VXPocket 440, and then start them by calling snd_pcm_start().
Then I use snd_pcm_status_get_trigger_tstamp() to examine the tigger time
of both PCM. I found that the difference of tigger time between these two
PCM is 3 us. Does this number look reasonable to you?

In addition, I'm not clear what exactly is the tigger time defined. PCM
start probably is one of the scenarios in which "trigger is involved".
However, other than that, are there any more scenarios that could be
regarded as "triggerred"? Thanks a lot.


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
