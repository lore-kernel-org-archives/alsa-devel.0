From: Tobias Deiminger <tobias.deiminger@ngi.de>
Subject: Re: Can't record properly with cmi8738 card
Date: Tue, 09 Sep 2003 20:54:29 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <bjl0gc$2mv$1@sea.gmane.org>
References: <200308241501.58837.tobias__7241.2152695053$1063096402@rueckverdumung.de> <yw1x65k2bb0y.fsf@users.sourceforge.net>
Reply-To: tobias.deiminger@ngi.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8Bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Måns Rullgård wrote:

> Tobias Deiminger <tobias.deiminger@ngi.de> writes:
> 
>> I've got this card (Anubis Typhoon):
>> [CMI8738MC6     ]: CMI8738-MC6 - C-Media PCI CMI8738-MC6
>>                      C-Media PCI CMI8738-MC6 (model 55) at 0xd400, irq 10
>>
>> and i'm using alsa 0.9.6.
>>
>> I want to record something via mic-in using DAP for example. When I
>> tried it the first time, i could only record a very low signal
>> (although the signal was monitored clean and loud to the
>> speakers). Then I turned off the "mic-to-center" switch as described
>> at alsa-project.org. Now the recorded signal was higher, but still
>> to low to work properly with it. What's wrong?  Mic-capture is on,
>> mic and mic-caputre are set to max and mic-boost is on. Is this a
>> general problem with this card/driver?
> 
> Mic input works fine with my Hercules Gamesurround DVD 5.1 (or
> whatever the name was) based on the same chip, so it can work.  What
> type of microphone do you use?
> 

Maxtone Moving-Coil Mic Imp. 600 Ohm....
but i've got the same problem if I use my guitar instead of a mic. I tried 
also to use my v-amp as preamp for the guitar and this works a little 
better, 
but if I turn the preamp master too loud then the recorded signal gets 
distorted.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
