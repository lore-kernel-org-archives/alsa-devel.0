From: Kai Vehmanen <kvehmanen@eca.cx>
Subject: Re: Advice on using ALSA with callbacks?
Date: Thu, 29 Dec 2005 11:44:08 +0200 (EET)
Message-ID: <Pine.LNX.4.62.0512291136390.25093@ecabase.localdomain>
References: <Pine.LNX.4.61.0512281715520.11482@holly>
 <Pine.LNX.4.61.0512281912160.9509@tm8103.perex-int.cz>
 <Pine.LNX.4.61.0512281819110.11482@holly>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.61.0512281819110.11482@holly>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Dave Raggett <dsr@w3.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

On Wed, 28 Dec 2005, Dave Raggett wrote:

> I am currently using poll() with OSS but don't understand how
> to get this to make this work with ALSA. In OSS it is easy
> to get a file descriptor for use with poll by opening /dev/audio.
> Is there something analogous for use with ALSA?  Can ALSA be
> set up in such a way that poll only sees the file descriptor
> as ready for reading when a complete frame is available, and
> likewise to only become ready for writing when there is space
> for a complete frame of playback data?

yes, as Jaroslav already replied, snd_pcm_poll_descriptors() does just the 
thing.

To configure the wake-up threshold, you need to configure the "avail-min" 
property with snd_pcm_sw_params_set_avail_min() and friends. Additionally 
it's good to set the period size (usually the interrupt frequency) to 
match your blocksize with snd_pcm_hw_params_set_period_*() functions.

All in all, I've used ALSA in various networked apps that use a 
centralized poll/select driven event-loop, and the alsa-lib API is very 
nice (things like avail-min are very useful and not supported by OSS).

--
  under work: Sofia-SIP at http://sofia-sip.sf.net


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
