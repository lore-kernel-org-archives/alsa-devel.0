From: Julien Claassen <julien@mail.upb.de>
Subject: Re: Garbage at end of playback: ecasound or alsa broken?
Date: Sat, 20 Jul 2013 11:57:32 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.1307201153310.1184@flower.world.net>
References: <51EA4CDE.2010503@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ecasound-list-bounces@lists.sourceforge.net>
In-Reply-To: <51EA4CDE.2010503@t-online.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ecasound-list>,
	<mailto:ecasound-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ecasound-list>
List-Post: <mailto:ecasound-list@lists.sourceforge.net>
List-Help: <mailto:ecasound-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ecasound-list>,
	<mailto:ecasound-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ecasound-list-bounces@lists.sourceforge.net
To: Knut Petersen <Knut_Petersen@t-online.de>
Cc: alsa-devel@alsa-project.org, ecasound-list@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello Knut!
   No idea yet, who's to blame. but have you tried repeating the experiment 
with another tool. You can use audacity, so you can use the GUI. There are 
other recording applications. Or you might even try with the alsa utilities 
aplay and arecord. this will require two console or terminals.
   You might also try the same experiment with JACK, if you're not averse to 
it.
   I have two soundcards and use them both via JACK. But I've also used two 
sound devices in ALSA together with Ecasound and didn't experience such 
problems. My ecasound call was something like:
ecasound -f:16,2,44100 -c -i alsa,tape -o alsa,default
   I did digitise a few tapes and prelistened to the volume and audio quality. 
So it's not a problem in general.
   Warm regards
         Julien


----------------------------------------
http://juliencoder.de/nama/music.html

------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
_______________________________________________
Ecasound-list mailing list
Ecasound-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ecasound-list
