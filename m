From: Ricardo Cerqueira <alsa-users@cerqueira.org>
Subject: Re: (Was Re: [Alsa-user] Poorly supported HDA intel)
Date: Fri, 20 Oct 2006 18:55:56 +0200
Message-ID: <66e2865bf4a72dae46566dc04c1a0397@192.168.1.254>
References: <s5hpscn0w8i.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hpscn0w8i.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On Fri, 20 Oct 2006 18:48:13 +0200, Takashi Iwai <tiwai@suse.de> wrote:
> At Fri, 20 Oct 2006 18:35:43 +0200,
> Ricardo Cerqueira wrote:
>>
>>
>>
>> On Fri, 20 Oct 2006 18:18:09 +0200, Takashi Iwai <tiwai@suse.de> wrote:
>> > At Fri, 20 Oct 2006 17:55:23 +0200,
>> > Ricardo Cerqueira wrote:
>> >>
>> >> On Fri, 20 Oct 2006 17:52:56 +0200, Takashi Iwai <tiwai@suse.de>
> wrote:
>> >> > At Fri, 20 Oct 2006 17:48:00 +0200,
>> >>
>> >> >>
>> >> >> Hmmm. I was trying to look into codec#0 to check the pin
> assignments,
>> >> > and I
>> >> >> realized it's being cut off at byte 4096, and I'm missing
>> > information.
>> >> > Looks
>> >> >> like something is limiting that proc entry's size to 4k, do you
> have
>> > any
>> >> > idea
>> >> >> where?
>> >> >
>> >> > Are your using HG version of driver?
>> >> > This bug should have been fixed recently.
>> >> >
>> >> >
>> >>
>> >> Yes, pulled about 14 hours ago...
>> >
>> > Strange, it works for me.  I tested to print extra data up to 32k
>> > bytes on my i386 machine, and it looks OK.
>> >
>> > Check alsa-kernel hg tree whether you have a changeset 4658
>> > "Fix re-use of va_list" (although it should work even without this
>> > patch on i386).
>>
>> Yes, I'm at changeset 4662... I checked core/info.c by hand, and the
> va_list
>> change is there... I just tried cloning fresh copies of alsa-kernel and
>> alsa-driver, and the result is the same.
> 
> Weird.  Could you check whether really it's 4k boundary problem?

Looks like it is:

> For example, try the patch below to see whether you get 500 dummy
> lines in codec#0 proc file.
> 

[root@frolic ~]# cat /proc/asound/card0/codec#0 | tail
[76] XXXXX DUMMY LINE XXXX XXXX DUMMY LINE XXXX
[77] XXXXX DUMMY LINE XXXX XXXX DUMMY LINE XXXX
[78] XXXXX DUMMY LINE XXXX XXXX DUMMY LINE XXXX
[79] XXXXX DUMMY LINE XXXX XXXX DUMMY LINE XXXX
[80] XXXXX DUMMY LINE XXXX XXXX DUMMY LINE XXXX
[81] XXXXX DUMMY LINE XXXX XXXX DUMMY LINE XXXX
[82] XXXXX DUMMY LINE XXXX XXXX DUMMY LINE XXXX
[83] XXXXX DUMMY LINE XXXX XXXX DUMMY LINE XXXX
[84] XXXXX DUMMY LINE XXXX XXXX DUMMY LINE XXXX
[85] XXXXX DUMMY LINE XXX[root@frolic ~]#
[root@frolic ~]#
[root@frolic ~]# wc  /proc/asound/card0/codec#0
85 770 4095 /proc/asound/card0/codec#0

--
RC


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
