From: Giuliano Pochini <pochini@shiny.it>
Subject: RE: aplay/arecord
Date: Fri, 01 Oct 2004 09:29:24 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20041001092924.pochini@shiny.it>
References: <001a01c4a775$3ea1f470$0201010a@ankkennedy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <001a01c4a775$3ea1f470$0201010a@ankkennedy>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Andy Kennedy <akennedy@wpid-am.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On 01-Oct-2004 Andy Kennedy wrote:

> arecord -r 44100 -f U8 -c 2 -D hw:0,0 something.wav -- Invalid format.
>
> What am I doing wrong here?  Why will it not let me have U8 as the format on
> hw:0,0, when it is the same thing as the others. . .

No, it's not the same thing.  plughw: transparently converts
the given format to one that the card supports, while hw:
doesn't. In this case your card can only record S16_LE, so
the data must be converted to U8.


--
Giuliano.


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
