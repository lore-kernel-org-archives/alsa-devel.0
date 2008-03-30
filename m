From: rct@frus.com (Bob Tracy)
Subject: Re: [regression] 2.6.25-rc4 snd-es18xx broken on Alpha
Date: Sun, 30 Mar 2008 00:18:14 -0500 (CDT)
Message-ID: <20080330051814.5D9CCDBA2@gherkin.frus.com>
References: <47E86203.5090805@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gherkin.frus.com (gherkin.frus.com [192.158.254.49])
	by alsa0.perex.cz (Postfix) with ESMTP id E814A24560
	for <alsa-devel@alsa-project.org>;
	Sun, 30 Mar 2008 07:18:19 +0200 (CEST)
In-Reply-To: <47E86203.5090805@keyaccess.nl> "from Rene Herman at Mar 25, 2008
	03:22:59 am"
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Michael Cree <mcree@orcon.net.nz>, Krzysztof Helt <krzysztof.h1@wp.pl>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-alpha@vger.kernel.org, Bob Tracy <rct@frus.com>
List-Id: alsa-devel@alsa-project.org

Rene Herman wrote:
> Lovely, so different problem between you and Bob. When you (either of you) 
> have some time for it again, could you try:
> 
> $ sox asskickd.wav -w -t alsa hw

Tight loop at the beginning of the file: rapid continuous repeat of approx.
the first couple tenths of a second.  Hitting <ctrl>C caused playback to
advance to the next small section of the soundfile.  Further <ctrl>C's did
nothing I noticed: had to type <ctrl>\ to kill sox.

> $ sox asskickd.wav -w -r 44100 -t alsa hw

Several seconds of silence, followed by what sounded like continuous pitched
machine-gun fire.  Each <ctrl>C advanced through the file (the pitch of the
machine-gun fire changed slightly).  Still had to type <ctrl>\ to kill sox.

> $ sox asskickd.wav -w -r 44100 -c 2 -t alsa hw

Silence for longer than I had patience to wait :-).  Hitting <ctrl>C several
times finally got me to an even more rapid machine-gun fire than the previous
test.  As in the previous test, each <ctrl>C advanced further through the file,
although the perceived increment was smaller.  Still had to type <ctrl>\ to
kill sox.

-- 
------------------------------------------------------------------------
Bob Tracy          |  "I was a beta tester for dirt.  They never did
rct@frus.com       |   get all the bugs out." - Steve McGrew on /.
------------------------------------------------------------------------
