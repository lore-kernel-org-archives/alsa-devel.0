From: "Nick French" <nick@greensignal.com>
Subject: Re: Multiple PCM files
Date: Wed, 31 Jul 2002 21:20:31 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <121a01c238cf$b88c66b0$360110ac@dillon>
References: <200207312258.48640.do1ypv@linux>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Philipp Vollmer <vollmer.philipp@t-online.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Exactly. I would prefer the second as if I needed to add a third, 4th its
takes no effort and I don't reinvent the wheel as they say.

Does alsa support 2 or is this just JACK's.

The mathematics may be simple for 1 but why should it be done over and over
again. An API is meant to take away repetitive annoyances ;)

Cheers

Nick

----- Original Message -----
From: "Philipp Vollmer" <vollmer.philipp@t-online.de>
To: <nick@greensignal.com>
Cc: <alsa-devel@lists.sourceforge.net>
Sent: Wednesday, July 31, 2002 9:58 PM
Subject: Re: Multiple PCM files


Hello,

Maybe you're working at the same problem as me. At this
point of time.
There are two possibilities:
1. Open one device with one handler and mix the two files
    with arimethic operations as they will be mixed by the sound
    card although.

2. Open one devices but with two handlers in two threads
     and write your pcm data to it.

regards

Philipp ( DO1YPV )





-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
