From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: buffers, periods, cycles.. oh my!
Date: Sat, 04 Sep 2004 22:13:18 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1094350398.6575.573.camel@krustophenia.net>
References: <200408291648.i7TGmvjM015281@localhost.localdomain>
	 <4133A1EC.8000501@davyandbeth.com> <1094237841.2082.22.camel@localhost>
	 <413A6E07.90403@davyandbeth.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <413A6E07.90403@davyandbeth.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Davy Durham <pubaddr@davyandbeth.com>
Cc: mjander@users.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 2004-09-04 at 21:38, Davy Durham wrote:
> Manuel Jander wrote:
> >One second of buffer time... that would be around 176KB ! I very doubt
> >that any soundcard would handle that. If you want such a large buffer, i
> >guess you will need a own buffer implementation in your app. Are you
> >really sure that you need such a large buffer ? Remember that disk
> >drivers and filesystem I/O layers provide additional buffers, so you
> >don't have to bother about actual hardware latencies.
> >
> >  
> >
> Well I figured that if it's a software buffering implementation then 
> what does the software much care about how much buffer time I ask for.
> Now, I'm pretty sure I've got an 8k buffer working, so whatever the 
> buffering mechanism is, it's not straight DMA which was limited by 4k 
> you said.

I believe you are each referring to a different buffer.  "Buffer" in
ALSA terminology almost always refers to the DMA buffer, which is the
one that is divided into periods, etc.  Your app would read() (or
better, mmap()) the capture data from the DMA buffer into a much larger
buffer in memory, then it would get written out from there to the disk. 
This should be done by two different threads so that delays in disk
output will not cause you to lose audio data.

8K buffer works because you have 2 (or more) periods per buffer, and
your app can only "see" one period at a time, because the hardware will
be DMA'ing to/from the other half.

Lee




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
