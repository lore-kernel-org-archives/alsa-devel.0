From: Jan Depner <eviltwin69@cableone.net>
Subject: Re: [ot] Re: Xruns with Audiophile 2496 M-audio
Date: Sat, 29 May 2004 10:32:10 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1085844730.21679.33.camel@eviltwin>
References: <20040529114908.2118135c@pentium233.krystal.net>
	 <Pine.LNX.4.58.0405291234350.566@autumn>
	 <20040529131601.641aa202@pentium233.krystal.net>
	 <1085830277.21677.17.camel@eviltwin>
	 <20040529140631.09962c03@pentium233.krystal.net>
	 <Pine.LNX.4.58.0405291413180.566@autumn>
	 <1085839300.21679.28.camel@eviltwin>
	 <Pine.LNX.4.58.0405291614570.566@autumn>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0405291614570.566@autumn>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Tim Goetze <tim@quitte.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 2004-05-29 at 09:31, Tim Goetze wrote:

> depends on what 'system' we're talking about, which isn't really clear
> in the first place (nor is it too important, but here goes anyway ...
> :)
> 
> you can see the whole setup as the system, then latency is the time
> from keypress to voltage change at the DAC out. or you can just look
> at the kernel side as as you do. or you can look at the time from MIDI
> interrupt to the audio DAC converting the first affected audio sample.
> 
> all examples of valid 'systems' to look at in this context, depending
> on whether you assume the musician's, the kernel- or the audio
> application-programmer's view.
> 
	Agreed.  But the problem that keeps popping up on the lists is that
people who are not doing live sound, have cards that do hardware
monitoring, and don't need to use a tiny buffer size waste their time
trying to get the minimum buffer size because they think they need to
get 2-3ms latency.  So, they get xruns out the wazoo and wonder how to
fix it.  In this case he *needs* a small buffer size though since he's
doing, essentially, a live application.

Jan




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
