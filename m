From: Joshua Haberman <joshua@haberman.com>
Subject: questions about card detection
Date: 29 Aug 2003 02:04:24 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1062147863.5596.15.camel@trimble1dhcp30.ups.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Two questions.

First: Is it possible to determine the maximum number of channels for a
sound card that is in use by another application?  My method for
detecting the number of channels is:

- open the pcm
- use the hw_params API to determine the number of channels

But if another application has the sound card open, it cannot be opened
again and therefore the hw_params API cannot be used!

Second question: what is the meaning and intended use of the
card,device,subdevice design of ALSA?  I thought this would become clear
to be once I bought a multichannel card, but now I own an Audiophile
2496 and it's still a mystery.

"Card" I understand -- I can hold a card in my hand.  But what is a
"device" and a "subdevice?"  When are they ever used, and how?

Josh


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
