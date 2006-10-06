From: "Eduardo Valentin" <edubezval@gmail.com>
Subject: Re: [EXT PCM / CTL Plugin][RFC][ANNOUNCE] Alsa support
	for n770
Date: Fri, 6 Oct 2006 08:41:35 -0400
Message-ID: <a0580c510610060541g66727f95v78f1ea38d72071ba@mail.gmail.com>
References: <a0580c510610050726i3fe8437cm1e783e1b6305f3bc@mail.gmail.com>
	<s5hvemyu1ql.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hvemyu1ql.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello Takashi,


   Thanks for your response.

On 10/5/06, Takashi Iwai <tiwai@suse.de> wrote:
> At Thu, 5 Oct 2006 10:26:18 -0400,
> Eduardo Valentin wrote:
> >
> > Hello all,
> >
> >
> >     I'd like to announce an alsa plugin project to add support for
> > ALSA application on nokia 770. I'd like also to ask you comments and
> > suggestions about the code.
> >
> >     Although n770 hasn't ALSA kernel driver, it is possible to write a
> > user-space driver to communicate with n770's audio system.
>
> Great, does the plugin work well?


   yes, it does. I tested it with aplay, arecord, alsamixer, amixer,
mplayer and alsaplayer.
Of course, there are some issues. There is a list of limitations in
the end of REAME file. I'll put it here:

- Some application does not recognize the plugin
(ekiga, for example). I think that they look for real card.

These are related to the n770 audio system:

- While the plugin is using a pcm task node, another applications,
for example gstreamer, can not use the same task node. This will cause
unexpected behaviour.

- To prevent more than one application access per task node, I need to do
a processes synchronization. I did it using semaphores from libc (sys/sem.h).
However, If an application does not close alsa device properly, this plugin
will not have chance to release all reserved resouces. One expected
behaviour in this case is to have -EBUSY error for following applications
whose try to open the same alsa device. This issue was partialy solved
(version 0.6)
with __attribute__((destructor)) functions. But if the application
receives an uncaught signal, resources may be kept unreleased.

- If many requests to volume information read / write is done in the
same alsa device while it is being used to do playback, this playback
could be affected and some little stops can be heard.


>
> >    The n770's audio system is based on DSP gateway project:
> > (http://dspgateway.sourceforge.net/pub/index.php)
> >
> >    To add ALSA support, an EXT PCM I/O plugin and EXT CTL plugin were
> > written. The code is based on SDK documentation from the alsa-project
> > site.
> >
> >     The project is in garage.maemo:
> > https://garage.maemo.org/projects/dsp-alsa/
> >
> >      You can have a look at its REAME file in:
> > https://garage.maemo.org/plugins/scmsvn/viewcvs.php/alsa-plugin/debian/README?root=dsp-alsa&view=markup
> >
> >     It is possible also to browse the its source code svn repository in:
> > https://garage.maemo.org/plugins/scmsvn/viewcvs.php/alsa-plugin/?root=dsp-alsa
>
> The code looks good at a short glance.
> (But what is the reason to include <linux/soundcard.h>?)

   Just a mistake. Thanks to advice me.


>
> Do you think of merging this to upstream (likely in alsa-plugins
> repository)?

   It would be a great. But how would it happen? What is the
process/requirements to merge it?

>
>
> thanks,
>
> Takashi
>


-- 
Eduardo Bezerra Valentin

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
