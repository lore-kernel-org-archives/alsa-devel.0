From: Tim Goetze <tim@quitte.de>
Subject: Re: Alsa Programming Examples
Date: Sat, 8 Jun 2002 00:43:10 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0206080040150.784-100000@summer.quitte>
References: <200206072212.56183.do1ypv@linux>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200206072212.56183.do1ypv@linux>
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

Philipp Vollmer wrote:

>Hello to all ALSA developers!
>
>I had compiled the examples of the Programming HOWTO succesfully!!!
>I saw many programming mistakes in these files. I don't think ANSI C supports 
>polymorphism! So I had to take parts out of other running code and put it 
>into the example.
>But now, after a few changes I could run the program which starts to send 
>Random PCM Data to the interface.
>
>Now I have following problem:
>Although the program compiled succesfully I get following output:
>
>how1: pcm_params.c:2136: snd_pcm_hw_refine: Assertion && params failed.
>Canceled
>
>What is the problem?

$ man assert

it seems params == 0 when you're calling snd_pcm_hw_refine.

tim


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas - http://devcon.sprintpcs.com/adp/index.cfm?source=osdntextlink
