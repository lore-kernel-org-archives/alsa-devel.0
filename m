From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: pcm interfaces questions
Date: Wed, 26 Mar 2003 15:18:22 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20030326151822.pochini@shiny.it>
References: <s5h4r5qpj5t.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h4r5qpj5t.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


On 26-Mar-2003 Takashi Iwai wrote:
> the "pcm substreams" belong to each pcm stream.  when you open a pcm
> device, one pcm substream will be used at each time.
> snd_pcm_new() takes the argument how many pcm substreams are created
> for each pcm stream.  you can give more than one here only if the
> hardware supports multiple-playback/capture, such as emu10k1.
> otherwise, these arguments must be 1 or 0.

The hw supports it. My cards has 8 analog outputs that can be used
indipendently or grouped. From inside hw_params callback I have no
way to know which channels the user wants to use. My idea is to tell
snd_pcm_new() to create 8 playback substreams. When an app opens
substream N, C channels wide, I use substream N, and I make
substreams from N+1 to N+C-1 not available.


Bye.



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
