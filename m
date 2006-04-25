From: Matthias Koenig <list@phasorlab.de>
Subject: Re: [PATCH] Support for ESI Miditerminal 4140
Date: Tue, 25 Apr 2006 14:17:03 +0200
Message-ID: <874q0hvohs.fsf@zebra.localdomain>
References: <87wtdeevlh.fsf@zebra.localdomain> <s5hbquq266i.wl%tiwai@suse.de>
	<87wtde56js.fsf@zebra.localdomain> <s5h3bg20y35.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:
> At Tue, 25 Apr 2006 11:49:11 +0200,
> Matthias Koenig wrote:
>> Yes, these long delays have caused me some bellyache.
>> I got the information about the device from reverse engineering the Windows
>> driver and the delay times are exactly taken from there (actually there is a
>> function which repeatedly calls KeStallExecutionProcessor with an argument 
>> of 50us until the given time is elapsed).
>
> Hm, but you call mdelay(50), not udelay(50).
> I won't care about the latter case but mdelay(50) is definitely to be
> avoided.

Yes, it's 50ms of _total_ time to wait.
The Code does something like this (roughly translated to C):

void wait_some_time(long long interval) /* interval is in ms */ 
{
        long long time = PcGetTimeInterval(0); /* Current time in 100ns ticks */
        interval *= 10000;  /* translate to 100ns ticks */
        do {
                KeStallExecutionProcessor(50);   /* This is us */
        } while (interval < PcGetTimeInterval(time));
}

> If it's really mdelay(50), change spin_lock to mutex_lock and replace
> mdelay to msleep() -- at least, for open/close calls, where you can
> sleep safely.

I totally overlooked the following sentence in "Writing an ALSA Driver":
"The open and close callbacks of a rawmidi device are serialized with a
mutex, and can sleep."

So, if I understand this correctly, there is already a mutex held by the
ALSA core and it is guaranteed that there are no multiple accesses of
open/close callbacks?
Hmm, then why should I hold an additional mutex?

>> > You need to irqsave/restore in the interrupt handler.
>> 
>> I'm not sure if I understand your point here.
>> This is what I already do. Do you mean "you _don't_ need to 
>> irqsave/restore ..."?
>
> Yep, exactly.  Sorry for a typo :)

Ok.

Thanks,
Matthias


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
