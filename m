From: "" <granda@telecable.es>
Subject: Re: Audio and Video sync. Getting Timestamps
Date: Wed,  5 May 2004 11:13:20 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1083748400.4098b030eeb58@www.telecable.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Mensaje citado por Takashi Iwai <tiwai@suse.de>:

> At Tue, 27 Apr 2004 20:36:29 +0200,
> Juan Carlos Granda wrote:
> > 
> > [1  <text/plain; iso-8859-1 (quoted-printable)>]
> > 
> > [2  <text/html; iso-8859-1 (quoted-printable)>]
> > Hi,
> >  
> > I'm developing a Multi-thread app for capturing audio+video and i have a
> few
> > questions. The app is based on 3 threads:
> >  
> >  - 1 thread for capturing audio using ALSA lib.
> >  - 1 thread for capturing video using V4L2.
> >  - 1 thread for saving audio+video into an AVI file.
> >  
> > Both of capturing threads store captured data into a queue and the last
> thread picks
> > the data and sync A/V.
> >  
> > I start audio capturing and then the video. So, i need to known the point
> of the
> > stream of audio the video begins.
> > I'm readings frames by period size times. My prob is how to get valid ALSA
> timestamps
> > to eliminate the previous frames of the period the video starts. I've
> tried
> > snd_pcm_status_get_trigger_tstamp but it returns the same timestamp for a
> long period
> > of time (13 secs) (is it related to the period or buffer time?). I've
> tried
> > snd_pcm_status_get_tstamp too but i obtain a delay of several microseconds
> from the
> > period time (50 - 100 more or less) (is it because the clock resolution?).
> 
> the alsa-driver can put timestamp at each period update.
> set SND_TSTAMP_MMAP in snd_pcm_sw_params_set_tstamp_mode().
> 
> 
> Takashi
> 
> 

I set SND_TSTAMP_MMAP like you told me. What function may i use? I've tried
snd_pcm_status_get_trigger_tstamp and snd_pcm_status_get_tstamp, and the first
always return the same timestamp or it changes every 4 or 6 seconds. And the
second returns the "now" timestamp. What am i doing wrong?

Could you explain me the all secuence to make it works?

Thanl, Juan Carlos


> -------------------------------------------------------
> This SF.Net email is sponsored by: Oracle 10g
> Get certified on the hottest thing ever to hit the market... Oracle 10g. 
> Take an Oracle 10g class now, and we'll give you the exam FREE.
> http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 




-------------------------------------------------
Este mensaje fue enviado
utilizando el servicio Webmail de:
http://www.telecable.es


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
