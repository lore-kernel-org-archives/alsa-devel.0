From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: pcm interfaces questions
Date: Wed, 26 Mar 2003 11:21:16 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20030326112116.pochini@shiny.it>
References: <1048632431.3099.25.camel@Jay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1048632431.3099.25.camel@Jay>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: paul@linuxaudiosystems.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


>>snd_pcm_new() has two parameters for the number of substreams
>>for playback and capture.
>
> its a language problem. its not the number of substreams as in "the
> quantity of substreams". rather, it means "the ID of the substream".
>
>>                         Yes, but what does it mean ? If I
>>have N playback substreams, can I service N applications that
>>use one stream ? Can channels be allocated on demand, to allow
>>the user to use 4 xmms or 1 xmms and a dvd player (5.1) at the
>>same time ? :))
>
> this depends on (1) whether the underlying hardware supports it and
> (2) whether you use a "dmix" PCM device rather than a "hw" PCM
> device. the "hw" PCM device only offers the capabilities of the
> hardware, nothing more.


The hardware supports it: it provides 16 indipendent scatter-gather
lists and each stream has its own sample rate and format. Dmix mixes
several streams into one. It's not what I would like do to.


Bye.



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
