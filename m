From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: sequencer: handling non-registered parameter numbers....
Date: Sun, 15 Jun 2003 14:59:50 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19Rced-0005Jf-00@sc8-sf-list1.sourceforge.net>
References: <3EEC9BC6.5090603@folkwang-hochschule.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Sun, 15 Jun 2003 18:16:06 +0200."
             <3EEC9BC6.5090603@folkwang-hochschule.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>hello alsa gurus !
>
>i have bought a peavey studiomix midi controller on ebay, and it sends 
>NRPN messages (non-registered parameter numbers). when i move a slider, 
>it sends the slider number encoded in 98 and 99 and the value in the 
>DATA ENTRY controllers 6 and 38. i would like to map these to ordinary 
>midi controllers, or better yet, get nrpn support into ardour.
>
>how do i get nrpn controller values from the alsa sequencer without 
>having to parse the individual events and put them together by hand ?

ardour doesn't use the sequencer.

and i don't consider the nrpn messages any different from any other
controller. from libmidi++'s persepective, there are 127 controller
ID's, each with a value. whatever standard mapping they may have to
gain, pan, or nrpn is completely ignored.

14 bit value support is almost impossible to provide: the midi spec is
just ridiculous for that. 

--p


-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
