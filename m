From: Thomas Charbonnel <thomas@undata.org>
Subject: Re: HDSP 9632 driver and expansion cards
Date: Sat, 24 Jan 2004 13:56:26 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40126B7A.3000801@undata.org>
References: <1074650862.6893.10.camel@rivendell.home.local> <400E74F6.1040803@undata.org> <02f701c3e04e$1f39d2e0$5d40a8c0@FRiskMan.com> <400EEDE9.80208@undata.org> <013301c3e0fc$f4ea92e0$5d40a8c0@FRiskMan.com> <4010F57E.7070207@undata.org> <01e001c3e1d4$a32393c0$5d40a8c0@FRiskMan.com> <026e01c3e1ee$34858ee0$0369a8c0@BigMotha>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <026e01c3e1ee$34858ee0$0369a8c0@BigMotha>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Edward Wildgoose <ed@wildgooses.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Edward Wildgoose wrote :
>>>Just to make it clear that this is a software problem and not the
>>>problem that Tim, Paul and Mark reported, could you please try to route
>>>an incoming signal (through analog or digital in) to your amp using
>>>hdspmixer and tell me if the routed sound suffers from the same audio
>>>corruption as the one being played back ? (this test should be done
>>>while you're playing back a stuttering software stream)
>>
> 
> OK, I'm sure that I misunderstand what you are asking, but here is what I did:
> 
> Set mplayer playing with something like "mplayer file.mpg -ao alsa9:rme9632plug" - It sutters like crazy and mplayer reports "xruns
> of at least 10ms".
> 
> At the same time I spun a disk in the CD player, and changed the hdspmixer so that spdif mapped through to the front speakers
> instead of the mplayer audio.  CD output was fine, mplayer continued spewing errors up the screen.
>

That's exactly what I was asking for, thanks. This is also good news 
because you seem to be safe from the problem Tim, Paul and Mark are 
experiencing.

> I have just had a peek at the mplayer alsa output code, and compared with the verbose logs.  It does seem that mplayer has managed
> to set "chunksize" to 1024 and asked for 2 fragments - so this should be quite reasonable.  Switching to mmap or noblock mode makes
> no difference (neither does switching to the OSS device...)
> 
> Any ideas what could be happening?  As I said, the same problem happens with Mythtv under OSS, and I think also under alsa.  Some
> other apps are fine, alsaplayer for example.
> 

Still looks like a design issue for the misbehaving apps, that may also 
be emphasised by the system. Since I updated to the 2.6.x series, disk 
accesses are a major cause of audio dropouts for me as long as the audio 
apps do not run with realtime priviledges. SCHED_FIFOed apps on the 
other hand work as expected even with low latency settings.

> Quite peculiar...
> 
> I just checked and I actually have alsa 1.00 rc2.  Am I missing any driver updates?
> 

Nothing hdsp specific.

> asound.conf is pretty empty in case it matters.  Just an entry for the hardware device and a plug device for the same.
> 

There should be no problem here.

Thomas




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
