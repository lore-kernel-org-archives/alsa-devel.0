From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: MIDI and PCMCIA
Date: Sat, 14 Jun 2003 18:06:10 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19RJ5V-0004v1-00@sc8-sf-list1.sourceforge.net>
References: <20030614234137.73b803f7.pochini@shiny.it>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Sat, 14 Jun 2003 23:41:37 -0000."
             <20030614234137.73b803f7.pochini@shiny.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@shiny.it>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>
>Some of the cards by Echoaudio have a midi port, but it's not MPC401
>compatible. The card has two tiny buffers to send and receive bytes. Where
>can I get infos, sample code, etc. to add midi support to my driver ?
>The Layla24 also exists in PCMCIA edition. Just like above, I need docs...

no docs explicitly, but the hdsp (as just one example; there are
others within the driver tree) has a midi port that is completely
unrelated to MPC401. it also uses a tasklet to handle midi i/o so as
not to affect audio latency.

--p


-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
