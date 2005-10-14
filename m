From: Giuliano Pochini <pochini@shiny.it>
Subject: RE: how does alsa keep passing data into driver?
Date: Fri, 14 Oct 2005 09:36:33 +0200 (CEST)
Message-ID: <XFMail.20051014093633.pochini@shiny.it>
References: <bf04f99c0510131947m1a5e0a68n631b761818887222@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <bf04f99c0510131947m1a5e0a68n631b761818887222@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Tehn Yit Chin <tehn.yit.chin@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On 14-Oct-2005 Tehn Yit Chin wrote:

> I am trying to understand how the ALSA pass PCM data to the driver. I h=
ave
> understand that when the driver starts up, a start trigger event is cre=
ated
> and some PCM data is passed in. After that, how does the subsequent PCM=
 data
> get pass into the driver?

The ALSA middle layer passes PCM data to the driver only if the driver
attaches a function to the .copy() callback. Otherwise (and this is the
most common case) the ALSA ml copies data to/from the buffer on its own.


> I also realise that a pointer event is generated, but from the docs, th=
e
> pointer event is for figuring out the current position.

Yep. ALSA needs to know what part of the buffer has been consumed so it
can copy new data to/from that part.


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
