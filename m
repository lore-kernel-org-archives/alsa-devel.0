From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: pcm interfaces questions
Date: Wed, 26 Mar 2003 10:48:26 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18yD40-0005UM-00@sc8-sf-list1.sourceforge.net>
References: <XFMail.20030326151822.pochini@shiny.it>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 26 Mar 2003 15:18:22 +0100."
             <XFMail.20030326151822.pochini@shiny.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@shiny.it>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>> the "pcm substreams" belong to each pcm stream.  when you open a pcm
>> device, one pcm substream will be used at each time.
>> snd_pcm_new() takes the argument how many pcm substreams are created
>> for each pcm stream.  you can give more than one here only if the
>> hardware supports multiple-playback/capture, such as emu10k1.
>> otherwise, these arguments must be 1 or 0.
>
>The hw supports it. My cards has 8 analog outputs that can be used
>indipendently or grouped. From inside hw_params callback I have no
>way to know which channels the user wants to use. My idea is to tell
>snd_pcm_new() to create 8 playback substreams. When an app opens
>substream N, C channels wide, I use substream N, and I make
>substreams from N+1 to N+C-1 not available.

sorry, i misread your original question. i thought you were asking
about the user of the user-space snd_pcm_open() call, not a driver
side function.

i am not sure this is the best way to do this. i used this approach
with the original hammerfall driver (26 channels), and it got very
unworkable. i found it much better (and more efficient) to create 1
device with the capability to handle up to 26 channels.

your description is a bit confusing as well. when you say the h/w
supports 8 analog outputs, do you mean 8 independent audio streams, or
do you mean 8 synced channels of output? these are very different
things. 

--p


-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
