From: Jesse Chappell <jesse@essej.net>
Subject: Re: Problems with HDSP Multiface+CardBus
Date: Thu, 12 Jun 2003 13:24:47 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <cd0c7150ee2ca9bc60925c63d149d3a5@essej.net>
References: <200306121915.31285.Jaakko.Prattala@Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200306121915.31285.Jaakko.Prattala@Helsinki.FI>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaakko =?iso-8859-15?q?Pr=E4tt=E4l=E4?= <Jaakko.Prattala@Helsinki.FI>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaakko =?iso-8859-15?q?Pr=E4tt=E4l=E4?= wrote on Thu, 12-Jun-2003:

 > Maybe this is just because I don't know how to use the
 > mixer... What I did was
 >  # /sbin/modprobe snd-hdsp line_outs_monitor=1; hdsploader
 >  # for i in $(seq 18); do amixer cset name=Chn,index=$i 32768; done;
 >  # amixer cset numid=5 26,26,32768
 >  # amixer cset numid=5 27,27,32768
 >  # aplay ...
 > Isn't this supposed to give me something through the
 > headphones?
 
I didn't do the line_outs_monitor=1, but I did the amixer stuff
like that, and it worked.  But a word of warning if you do get sound going
eventually: 32768 for the LineOut(headphone) port is *way* too
hot for headphones plugged directly in.  I had to crank it down to 4000 
to get a sane maximum volume.  You don't want to damage your headphones
or your ears.....

jlc



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
