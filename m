From: Mark Hubbard <mark@egghead.free-online.co.uk>
Subject: M-Audio Revolution surround sound bug fix?
Date: Tue, 30 Sep 2003 13:54:37 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030930125437.GA416@rhubarb>
References: <20030929151409.GA4230@rhubarb>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20030929151409.GA4230@rhubarb>
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

Surround sound with the M-Audio Revolution still doesn't work
using latest cvs compile despite the recent "fix" to ak4xxx-adda.c
on 11th September:

- fixed the reset of AK4355 codec.
  the surround sounds on m-audio revo 7.1 should work now.
- write to only the register image instead of i/o writing in
  change the clock mode on AK codecs of revo board.
- fixed the non-cleared memory.

Does anyone have any ideas?

Thanks

MarkH

Reposted as the original mail didn't get through?


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
