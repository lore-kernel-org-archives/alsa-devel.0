From: Mark Knecht <markknecht@attbi.com>
Subject: Re: kaconnect question and enhancement request
Date: 26 Feb 2003 12:34:35 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1046291677.1196.2.camel@Godzilla>
References: <s5hr89wzn6l.wl@alsa2.suse.de>
	<NDBBLGIKBJENLAMOLFHGGEHGBIAB.mknecht@controlnet.com>
	<s5h8yw4z7bw.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h8yw4z7bw.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>, Matthias Nagorni <mana@suse.de>
List-Id: alsa-devel@alsa-project.org

On Tue, 2003-02-25 at 07:52, Takashi Iwai wrote:

> for connecting between the same input and output, just run like
> 
> 	% aconnect 64:0 64:0
> 
> > 
Takashi-san,
   Thanks. This works fine. If 64:0 is connected to 64:0 in aconnect,
then kaconnect shows it and will allow it to be disconnected. However
kaconnect will not make the connection itself, so I suppose this is an
oversight in kaconnect.

   Thanks for your help.

Cheers,
Mark

   



-------------------------------------------------------
This SF.net email is sponsored by: Scholarships for Techies!
Can't afford IT training? All 2003 ictp students receive scholarships.
Get hands-on training in Microsoft, Cisco, Sun, Linux/UNIX, and more.
www.ictp.com/training/sourceforge.asp
