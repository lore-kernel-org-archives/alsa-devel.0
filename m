From: Giuliano Pochini <pochini@shiny.it>
Subject: RE: which ALSA version supports subdevices for mult
Date: Wed, 14 Jul 2004 10:40:04 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20040714104004.pochini@shiny.it>
References: <85C103B6E3FDC440A06792E90FDF21A1E3FFE8@hyd-lax-msg.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <85C103B6E3FDC440A06792E90FDF21A1E3FFE8@hyd-lax-msg.wipro.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: sailaja.reddy@wipro.com
Cc: alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On 14-Jul-2004 sailaja.reddy@wipro.com wrote:

> I am a new alsa user and I have the following problem:
>
> ** Presently using alsa-driver-0.5.x. But, in this there are no
> subdevices allocatable for multichannel ad-da cards.

ALSA-0.5 is deprecated. Why don't you use 1.0.5 ?


> ** My current need is support of subdevices for multichannel ad-da
> cardss.
>    Which alsa-driver version supports subdevices for multi ad-da cards?

bash-2.05$ cd alsa-kernel/pci/
bash-2.05$ grep -r snd_pcm_new .
[...]
./via82xx.c:    err = snd_pcm_new(chip->card,
chip->card->shortname, 0, 4, 1, &pcm);
                          ^  ^
               outsubdevs |  | insubdevs
[...]


>    "amixer" will be of any help to me?

No. Use "aplay -l" and "arecord -l" to get a list of
available devices/subdevices. Or read the stuff in /proc .



--
Giuliano.


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
