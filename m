From: tomasz motylewski <T.Motylewski@bfad.de>
Subject: Re: Re: dmix plugin
Date: Thu, 20 Feb 2003 22:19:24 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0302202156450.17762-100000@mailserver.intern.bfad.de>
References: <Pine.LNX.4.44.0302202045550.1266-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0302202045550.1266-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Abramo Bagnara <abramo.bagnara@libero.it>, Jaroslaw Sobierski <fycio@gucio.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


Jaroslav:
> I think that we can lose more in the client/server model. Also, note that

client/server will have higher latency. The server has to copy the samples
"last minute" to DMA buffer and the client has to manage before the server
copies the data. In the direct model only the client's timing has to be within
the typical(maximum) system latency.

Please note that on many cards supporting DMA if the client is late just a few
samples but still adds the whole period, only these few samples will be
silence. The "nondestructive underrun detection" is the beauty here. The client
knows it is late (by comparing its pointer with HW pointer) but may continue
nevertheless if it knows next data will be coming on time. You know, throwing
out all samples or stopping the card in case of small underrun is like pulling
emergency brake because the train is a bit late. It only makes things worse.

With client/server either either all is good, or the whole period is lost. 

Do I understand it correctly that the server stores data in 32 bit buffer and
then puts it in 16 bit DMA buffer of the card? This is one operation more
compared with mixing directly in DMA buffer.

Best regards,
--
Tomek



-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
