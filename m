From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: PCM Params
Date: Thu, 27 May 2004 09:00:02 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200405271300.i4RD02UG014654@dhin.linuxaudiosystems.com>
References: <20040527120720.6778.qmail@web25107.mail.ukl.yahoo.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 27 May 2004 13:07:20 BST."
             <20040527120720.6778.qmail@web25107.mail.ukl.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?iso-8859-1?q?Brian=20Furey?= <brianmfurey@yahoo.co.uk>
Cc: ALSA LIST <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>ok paul i had another look at the driver playback/capture tutorials. I have on
>e question.Do applications initialize and use a pcm_handle of the alsa driver 
>when they begin interaction with it?Surely not....

surely yes. 

ALSA isn't structured the way windows seems to concieve of audio. We
don't have separate tools to configure the driver, and then have
applications just use it. Each application configures the driver to
the setup that it requires. It might leave many things to their
default settings, but some basic configuration is nearly always done.
 
>I thought that the driver would work totally independently of my VoIP and this
> is why I asked the question is it possible to change driver parameters direct
>ly. 

The application changes them. There are some h/w parameters that get
changed by "utilities", but not the basic stuff like h/w buffer size,
interrupt interval (period size), sample rates and so on.

If you want a different model, in which no h/w configuration is done
and you are presented with a highly abstract audio API, JACK is worth
looking at.

--p


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
