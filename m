From: Paul Davis <pbd@op.net>
Subject: Re: Difficulty of a Hammerfall DSP Cardbus Driver?
Date: Mon, 13 May 2002 21:09:50 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E177Qny-0000p1-00@usw-sf-list1.sourceforge.net>
References: <20020513210212.GA26667@dogsolitude.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Mon, 13 May 2002 17:02:12 EDT."
             <20020513210212.GA26667@dogsolitude.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: drclaw@dogsolitude.org
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Thanks, I didn't realize that cardbus was that pleasant under linux.
>I'll be sure to let you know if it behaves incorrectly when I'm able to
>test one out.  

just to confirm my suspicions, from src/linux/drivers/pcmcia/cardbus.c: 

/*
 * This file is going away.  Cardbus handling has been re-written to be
 * more of a PCI bridge thing, and the PCI code basically does all the
 * resource handling. This has wrappers to make the rest of the PCMCIA
 * subsystem not notice that it's not here any more.
 *
 *		Linus, Jan 2000
 */

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
