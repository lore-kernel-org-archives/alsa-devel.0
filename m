From: Kris Modrak <u9514439@anu.edu.au>
Subject: Re: Rate Conversion
Date: Tue, 02 Jul 2002 10:43:44 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D20F740.962F19F4@anu.edu.au>
References: <200206281126.g5SBQLTk004595@anu.edu.au>
Reply-To: u9514439@anu.edu.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: Jaroslav Kysela <perex@suse.cz>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:
> 
> >> You don't need to do this. Use the 'plughw' device which should do all
> >> conversions from you.
> >
> >I am a little confused about your advice. I am not sure how to access
> >the 'plughw' device from my application.
> 
>      snd_pcm_open (&handle, "plughw:N,M", ...)
> 
> where N and M are the card number and subdevice number. Preferably,
> this is a string supplied by the user, not hard coded into the application.
> 
> >I am not sure of how I should be setting up my PCM devices. How do I
> >tell them to convert, say, 8kHz audio data to 44.1kHz audio data so my
> >hardware can play it at the correct speed?
> 
> just as in the few token API examples. using
> snd_pcm_hw_params_*(). there is no difference setting the parameters
> no matter what "type" of PCM device you are using.

If use the virtual plughw:0,0 device and set the rate to 8kHz, at what
rate is my actual hardware device set to? Where are these settings made
and how are they decided?

Do I need to, or is it possible to, tell my soundcard to operate at
44.1kHz?

Kris Modrak


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
