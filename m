From: noreply@alsa-project.org
Subject: [ALSA - lib 0000173]: ALSA only allows me to set a period size of 0
Date: Fri, 16 Jul 2004 12:58:59 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716105859.9D5E926008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E65AC244
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:58:59 +0200 (MEST)
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


The following bug has been CLOSED
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000173
======================================================================
Reported By:                remon
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Bug ID:                     173
Category:                   hw specific configuration
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     closed
======================================================================
Date Submitted:             03-31-2004 12:40 CEST
Last Modified:              07-16-2004 12:58 CEST
======================================================================
Summary:                    ALSA only allows me to set a period size of 0
Description: 
Hello,

I'm not completely sure if this is a bug or a configuration problem. But
here come's the problem.

I'm using protux/libmustux as sound program and it happend to work without
a problem. Due some stupid actions I had to reinstall everything, and
since I'm using Debian I installed Debian unstable and suddenly the
program (protux) didn't work anymore. Nothing changed on the side of the
audio program, but now ALSA let me set everything which has to be set, but
actually uses 0 as its periodsize :-(

I really don't know why it isn't working anymore, because it worked
before!

Here's the code who prepares the device in exact the same way it's used in
the program:

snd_pcm_open(&pcmHandle, ((const char*) get_real_descriptor().ascii()),
SND_PCM_STREAM_PLAYBACK, block ? 0 : SND_PCM_NONBLOCK) < 0 )
snd_pcm_hw_params_alloca(&hwparams);
r = snd_pcm_hw_params_any(pcmHandle, hwparams);
r = snd_pcm_hw_params_set_access(pcmHandle, hwparams,
SND_PCM_ACCESS_RW_INTERLEAVED);
r = snd_pcm_hw_params_set_format(pcmHandle, hwparams, format);
r = snd_pcm_hw_params_set_channels(pcmHandle, hwparams, channels);
r = snd_pcm_hw_params_set_rate(pcmHandle, hwparams, pRate, 0);
r = snd_pcm_hw_params_set_periods(pcmHandle, hwparams, numPeriods, 0) ;
// now we detect the available min/max period size and the returned values
are 0 - 0 ?? But never mind, we go further...
r = snd_pcm_hw_params_set_period_size_near (pcmHandle, hwparams,
&periodSize, &dir);
r = snd_pcm_hw_params(pcmHandle, hwparams);

But of course, the periodsize will be 0 because ALSA only allows itself to
set it to 0. If you have any idea what is going on, that would be great.
Here are the system specs:

- ALSA 1.0.3 (with kernel 2.4.25) as well as kernel-2.6.4 (problem is same
with both)
- gcc 3.3.3
- ICE 1712 (ENVY 24) sounde card
- using the "plughw" device

If you need more information, let me know please.

Thanks a lot and waiting in advance,

Remon 

P.S. Although it doesn't work with libmustux, arts is working, which
confuses me even more...
======================================================================

----------------------------------------------------------------------
 perex - 03-31-2004 16:32 CEST 
----------------------------------------------------------------------
Why you set values to zero? Also use set_periods_near() function rather
than set_periods(), otherwise some devices will not work.

----------------------------------------------------------------------
 remon - 03-31-2004 16:40 CEST 
----------------------------------------------------------------------
hi,

I was probably not as clear as I could be :-(

In fact, we're using set_periods_near() all the time (see the above listed
calls) and use a period size of about 2205. Strange thing is that the
above code worked for a long time for me, but upgrading to a newer (>=
1.x.x) alsa version gave this problem.

So I set the period size to 2205 but ALSA then uses 0 instead of 2205.
This makes sense in this way, when I detect the min/max values for the
period size alsa _always_ says: min = 0, max = 0. So using the
periodsize_near always goes to value 0, thats the most near value :-(

Hope I made it clearer this time

----------------------------------------------------------------------
 perex - 03-31-2004 16:44 CEST 
----------------------------------------------------------------------
Don't ignore warnings. API was changed:

http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg09892.html

Bug History
Date Modified  Username       Field                    Change              
======================================================================
03-31-04 12:40 remon          New Bug                                      
03-31-04 16:20 perex          Assigned To               => perex           
03-31-04 16:20 perex          Status                   new => assigned     
03-31-04 16:32 perex          Bugnote Added: 0000724                       
03-31-04 16:40 remon          Bugnote Added: 0000726                       
03-31-04 16:44 perex          Bugnote Added: 0000727                       
03-31-04 16:44 perex          Resolution               open => not a bug   
03-31-04 16:44 perex          Status                   assigned => resolved
07-16-04 12:58 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
