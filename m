From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Typo in configure.in : dummy sequencer
Date: Thu, 20 Mar 2003 09:28:50 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303200928390.1318-100000@pnote.perex-int.cz>
References: <3E797921.410C8222@srr.ro>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3E797921.410C8222@srr.ro>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Andrei Boros <andrei@srr.ro>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 20 Mar 2003, Andrei Boros wrote:

> make: Nothing to be done for `all-deps'.
> autoconf: Undefined macros:
> configure.in:797:  AC_DEFINE_CONFIG_SND_SEQ_DUMMY)
> 
> Should read : AC_DEFINE(CONFIG_SND_SEQ_DUMMY)

I have this line in my tree:

AC_DEFINE(CONFIG_SND_SEQ_DUMMY_MODULE)

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: Tablet PC.  
Does your code think in ink? You could win a Tablet PC. 
Get a free Tablet PC hat just for playing. What are you waiting for? 
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
