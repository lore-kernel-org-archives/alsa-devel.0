From: James Tappin <sjt@star.sr.bham.ac.uk>
Subject: Re: alsa09 sound for portable computers
Date: Mon, 8 Apr 2002 16:31:33 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020408153134.67F904CAD@xun0.sr.bham.ac.uk>
References: <3CACBDD6.3060705@superbug.demon.co.uk> <3CB1AEBD.203@superbug.demon.co.uk> <s5h8z7ymdi2.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
In-Reply-To: <s5h8z7ymdi2.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Monday 08 Apr 2002 16:11, Takashi Iwai wrote:

> the latest alsaconf above can detect even non-pnp cards, well, in a
> very silly way.
> it tries to load the driver(s) with all possible paramter
> configurations and tests aplay/arecord to check.
> that's why it warns at the beginning.
> but it works, anyway.

Does it handle supposedly impossible settings? If I remember correctly, at 
least on the old Toshiba Tecra 780, one of the I/O ports of the OPL3/SA2 
(non-pnp) is at a location which the opl3/sa2 module docs don't list as a 
possible value (and nor does any other opl3/sa2 documentation I've ever seen).

That machine is still using Alsa 0.5 as it's using out-of-the-box SuSE 7.3, 
and I recall doing the modules.conf settings many years ago by manually 
matching up the bios screen with the alsa docs, and have just kept 
replicating the settings since.

James

-- 
+------------------------+-------------------------------+---------+
| James Tappin           | School of Physics & Astronomy |  O__    |
| sjt@star.sr.bham.ac.uk | University of Birmingham      | --  \/` |
| Ph: 0121-414-6462. Fax: 0121-414-3722                  |         |
+--------------------------------------------------------+---------+
