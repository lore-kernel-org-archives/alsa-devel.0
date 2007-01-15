From: Ed Wright <edo.wright@gmail.com>
Subject: Re: intel-hda, 965 chipset,
	STAC9227 - problem - resolved
Date: Mon, 15 Jan 2007 19:46:33 +0900
Message-ID: <45AB5B89.600@gmail.com>
References: <45A6488F.4010808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <45A6488F.4010808@gmail.com>
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

Turns out the problem had nothing to do with my earlier guesses.

Running an strace on aplay showed that even though alsa-lib and 
alsa-utils were compiled/installed with the default "prefix" (/usr), the 
utilities were looking for alsa.conf, etc. under /usr/local for some reason.

Anyway, I symlinked the directory and all seems to be working.

Ed

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
