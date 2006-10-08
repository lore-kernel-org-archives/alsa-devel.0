From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: No sound with snd_cmipci
Date: Sun, 08 Oct 2006 19:34:29 +0200
Message-ID: <452936A5.1020902@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi!

I bought some cheap ass sound card yesterday to use in my HTPC system.
Unfortunately, I cannot seem to get it to output any sound.

The card is labeled "PC Line" but is a C-Media CM8738, i.e. snd_cmipci.
There are no error messages whatsoever, just no audio out.

The problem only seems to affect PCM as I did some tests with a mic that
worked just fine. The mixer controls for mic playback and capture both
work and I get valid data when recording. PCM eats data at a reasonable
pace, but no sound it sent out. Also, no data is generated when I set
capture to PCM and try to loop stuff.

I also notice two other effects, but I do not know if they're relevant.
First, the mixer setting "IEC958 In Monitor" cannot be turned off.
Second, when "IEC958 Output" is activated, mic playback is activated
unconditionally.

Any help appreciated.

Rgds
Pierre

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
