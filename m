From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: Fwd: arecord bug?
Date: Tue, 18 Mar 2003 16:30:35 +0200 (EET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303181622330.9177-100000@vaino.wakkanet.fi>
References: <BE6FC7E8-5926-11D7-A553-0003934489D0@mac.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <BE6FC7E8-5926-11D7-A553-0003934489D0@mac.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jon Ellis <ashura666@mac.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 18 Mar 2003, Jon Ellis wrote:

>> http://bugs.gentoo.org/show_bug.cgi?id=12724
[...]
>>  and it's giving me grief because it takes so long to reproduce. The 
>> basic problem is that either arecord or oggenc hangs after 400min 
>> 47sec. The fact that lowering the sample rate (and talking to the ogg 
>> devs) makes me think that this is a overflow somewhere in arecord.

If Takashi's guess is right and you are facing the 32bit problem, may I
suggest using ecasound:

ecasound -f:16,2,44100 -i alsa -o stdout |oggenc -r -q 0 -o recording.ogg -

Ecasound should be available as a Gentoo package. Be sure to compile
ecasound with --with-largefile.

As a bonus, you should get much more reliable recording thanks to
ecasound's double-buffering disk i/o subsystem and other mechanisms 
present to fight both disk i/o and scheduling latency spikes.

--
 http://www.eca.cx
 Audio software for Linux!



-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
