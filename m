From: Patrice Tisserand <Patrice.Tisserand@ircam.fr>
Subject: Re: available sampling rate detection
Date: 11 Feb 2003 10:26:25 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1044955585.1415.39.camel@localhost.localdomain>
References: <20030211085359.24a40185.sputnik@on-the-web.ch>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030211085359.24a40185.sputnik@on-the-web.ch>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Herren <sputnik@on-the-web.ch>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2003-02-11 at 08:53, Martin Herren wrote:
[..]
> An additional question, what is the correct way to find out all existing cards/buses on a system ? Currently we scan /proc/asound/card?/ for all pcmX[cp]. Is there a better way to do it ?
> 
I think you case use a loop with snd_card_next

from alsa-lib/src/control/card.c
 /**
 * \brief Try to determine the next card.
 * \param rcard pointer to card number
 * \result zero if success, otherwise a negative error code
 *
 * Tries to determine the next card from given card number.
 * If card number is -1, then the first available card is
 * returned. If the result card number is -1, no more cards
 * are available.
 */
int snd_card_next(int *rcard)  

-- 
Patrice Tisserand <Patrice.Tisserand@ircam.fr>
IRCAM



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
