From: Giuliano Pochini <pochini@shiny.it>
Subject: RE: volume always 0 ?!?
Date: Tue, 25 Mar 2003 10:27:03 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20030325102703.pochini@shiny.it>
References: <1048463664.4150.46.camel@Jay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1048463664.4150.46.camel@Jay>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


On 23-Mar-2003 Giuliano Pochini wrote:
>
> setvolume control callback always get uc->value.integer.value[x]==0. Any
> ideas ?

Solved. I had to remove .access=SNDRV_CTL_ELEM_ACCESS_READWRITE and .index=0
from snd_kcontrol_new_t structure init. Strange.


Bye.



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
