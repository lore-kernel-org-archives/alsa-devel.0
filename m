From: "=?UTF-8?Q?Rafael_Esp=C3=ADndola?=" <rafael.espindola@gmail.com>
Subject: trying to get sound working at a mac book pro (core 2
	duo)
Date: Wed, 14 Feb 2007 19:21:54 +0000
Message-ID: <564d96fb0702141121j185378d1m4c3a192831442fb7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
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

I have installed the alsa drivers from the mercurial repository and
the current status is

*) Headphone works
*) Speakers work
*) Headphone sensing works
*) Internal microphone doesn't

I haven't tried to use an external microphone.

Following the steps in http://www.jasonparekh.com/?page_id=9 resulted
in the microphone working but the speakers stoped.

The subsystem ID of my card is 0x106b1e00. This is the only difference
from the one on http://www.jasonparekh.com/?page_id=9.

I tried to grep for this subsystem in the windows driver (from
bootcamp 1.1.2) but it is not listed. Has someone installed windows on
one of these systems? Does sound works?

Any ideas on how to try to find out the correct pin setting? Maybe
looking at the macos driver?

And in the case I can make it work, what is the correct way to do an
switch on the subsystem? Is there a variant of
snd_hda_check_board_config that also uses subsystem ID to
disambiguate pin configs?

Thanks,
Rafael

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
