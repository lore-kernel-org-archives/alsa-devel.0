From: Maarten de Boer <mdeboer@iua.upf.es>
Subject: Re: ALSA CVS and JACK?
Date: Tue, 25 Feb 2003 19:06:28 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030225190628.2b0033bf.mdeboer@iua.upf.es>
References: <200302251737.h1PHbfk20233@linuxaudiosystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200302251737.h1PHbfk20233@linuxaudiosystems.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> can jaroslav or takashi fill me in on the current state of ALSA CVS
> with respect to JACK? there have been many, many reports of JACK
> crashing machines when run with recent ALSA CVS in real-time mode, and
> mentions here on alsa-devel of configure-time JACK detection that
> causes certain code to be commented out, or something like that.

I don't find those mentions, and I don't find the code either. (Though
my CVS is not 100% uptodate). I believe that the only configure-time
JACK detection is related to the pcm_jack plugin. If jack is not present
it should not be compiled, because it will cause link errors. 

I also have experienced crashed (well, freezes) with jack in RT mode,
but I don't think it has to do anything with alsa.

Maarten


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
