From: "Bill Adair" <adair@gotadsl.co.uk>
Subject: Please add the following to Midiman/MAudio Delta
	Audiophile 2496.
Date: Wed, 28 Feb 2007 21:05:05 -0000
Message-ID: <op.tog8urdln0kn27@if15.tyrhosbarn>
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

I can't add this as the system seems to not work on the wiki:

Bill Adair     adair@gotadsl.co.uk
Wednesday, 28 February 2007	

Creating a .asoundrc file with the content below will route
audio players using alsa to the SPDIF outs shown in envy24control
rather than the PCM outs.
The audio will then not pass through the card's mixer or be resampled
to 48k. Hi-fi feeds to your DAC are then possible.

pcm.!default {
      type plug
      slave.pcm "spdif"
}

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
