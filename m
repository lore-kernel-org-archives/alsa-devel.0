From: Rahul Iyer <rahul.iyer@ymail.com>
Subject: Re: ALSA OSS Emulation - Read - EAGAIN Errors
Date: Fri, 8 Aug 2008 19:18:10 -0700 (PDT)
Message-ID: <640255.10395.qm@web59603.mail.ac4.yahoo.com>
References: <s5hy73iqsib.wl%tiwai@suse.de>
Reply-To: rahul.iyer@ymail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from n9.bullet.mail.ac4.yahoo.com (n9.bullet.mail.ac4.yahoo.com
	[76.13.13.237]) by alsa0.perex.cz (Postfix) with SMTP id 01B1E24B78
	for <alsa-devel@alsa-project.org>;
	Sat,  9 Aug 2008 04:18:11 +0200 (CEST)
In-Reply-To: <s5hy73iqsib.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: Alexandre Ratchov <alex@caoua.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi and Alexandre

Thank you for your attention and previous replies.

I understand EAGAIN errors can be ignored as trivial, but given there are so many of them (600 EAGAIN errors on an average for each successful call) indicates an inherent issue. And I believe it was singularly causing poor voice quality and high cpu usage.

Anyway, I have analysed this further and I think part of the problem is with the driver. With 1.0.11rc3 I notice 2 issues 

1. EAGAIN errors if fragment size is not set explicitly (*and* correctly). In our application we don't set fragment size explicitly. And if fragment size is set explicitly, then the best value is 0x7fff0007 (even x7fff0008 also returns EAGAIN errors). Following are some strace stats to prove my point.

---
@160 samples, 8Khz, mono, 8 bit (alsa-driver 1.0.11rc3) - 
Without setting fragment size. Fragment size computed to 1024 bytes (automatically). 
Process 13306 attached - interrupt to quit
Process 13306 detached
% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 49.54    1.017715           1   1794787   1791804 read
 48.97    1.005984           1   1797518           ioctl
  1.30    0.026751          10      2556           write
  0.19    0.004004           2      1752       582 select
  0.00    0.000028           0     13905           gettimeofday
  0.00    0.000010           0      3503           rt_sigprocmask
  0.00    0.000000           0         1         1 open
  0.00    0.000000           0        17           alarm
  0.00    0.000000           0         3           munmap
  0.00    0.000000           0      1477       811 sigreturn
  0.00    0.000000           0        19           sched_yield
  0.00    0.000000           0         2           rt_sigaction
------ ----------- ----------- --------- --------- ----------------
100.00    2.054492               3615540   1793198 total


@160 samples, 8Khz, mono, 8 bit (alsa-driver 1.0.11rc3)
Set fragment size to 0x7fff0008 (256 byutes)
Process 15061 detached
% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 89.48    0.068327          45      1534         2 write
  5.89    0.004499           0     68564     65641 read
  3.31    0.002528           0    507463           sched_yield
  0.87    0.000664           0    142230           kill
  0.39    0.000296           0     71115           ioctl
  0.06    0.000043           0     14771           gettimeofday
  0.01    0.000006           0      7613           rt_sigprocmask
  0.00    0.000000           0         3         1 open
  0.00    0.000000           0         2           close
  0.00    0.000000           0        16           alarm
  0.00    0.000000           0         3           munmap
  0.00    0.000000           0      1502      1433 sigreturn
  0.00    0.000000           0      3807      1408 select
  0.00    0.000000           0         2           rt_sigaction
------ ----------- ----------- --------- --------- ----------------
100.00    0.076363                818625     68485 total


@160 samples, 8Khz, mono, 8 bit (alsa-driver 1.0.11rc3)
Set fragment size to 0x7fff0007 (128 bytes)
Process 15571 attached - interrupt to quit
Process 15571 detached
% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
   nan    0.000000           0      2365           read
   nan    0.000000           0      2325           write
   nan    0.000000           0         1         1 open
   nan    0.000000           0        16           alarm
   nan    0.000000           0      9448           kill
   nan    0.000000           0      4724           ioctl
   nan    0.000000           0     19606           gettimeofday
   nan    0.000000           0         3           munmap
   nan    0.000000           0      2340      1984 sigreturn
   nan    0.000000           0      5135      1984 select
   nan    0.000000           0         4           sched_yield
   nan    0.000000           0         2           rt_sigaction
   nan    0.000000           0     10268           rt_sigprocmask
------ ----------- ----------- --------- --------- ----------------
100.00    0.000000                 56237      3969 total

-------------------------------------------------------------------

However upgrading to alsa-driver-1.0.16 automatically solves the EAGAIN issue without having to set fragment size explicitly.

2. The other issue noticed with alsa-driver-1.0.11rc3 is, read does not always succeed in reading all the bytes requested. I have confirmed there is sufficient data available to read. This is also not an issue in 1.0.16. 
I understand read can return with less bytes especially when its around end of file or interrupted by a signal, so there is a possibility this is related to issue 1. 

So, in conclusion I have been able to improve the quality in SUSE 10 but not to where I would've liked. I find it to be better in 9.2. 

The difference between 9.2 and 10 is the alsa driver version. SUSE 9.2 uses alsa-driver1.0.7rc2, whereas 10 uses 1.0.11rc3/1.0.16. The drivers differ in allocating default fragment size. In SUSE 9.2 (1.0.7) the fragment size defaults to 4096 bytes (when not set explicitly). With both 1.0.11 and 1.0.16, they default to 1024. In fact I am unable to set anything beyond 1024 bytes. SNDCTL_DSP_SETFRAGMENT with 0x7fff0012 does not set the fragment size to 4096, it defaults to 1024! 

Any thoughts on why this might be the case?

Thanks again in advance
Rahul


--- On Thu, 7/31/08, Takashi Iwai <tiwai@suse.de> wrote:

> From: Takashi Iwai <tiwai@suse.de>
> Subject: Re: [alsa-devel] ALSA OSS Emulation - Read - EAGAIN Errors
> To: "Rahul Iyer" <rahul.iyer@ymail.com>
> Cc: alsa-devel@alsa-project.org
> Date: Thursday, July 31, 2008, 10:04 AM
> At Wed, 30 Jul 2008 08:20:09 -0700 (PDT),
> Rahul Iyer wrote:
> > 
> > Hi ALSA Developers
> > 
> > 
> > I have a full duplex voice application, that records
> voice and sends
> > (over a network) as well as receives and plays voice.
> OSS APIs are used
> > to capture and play voice samples. 
> > 
> > The voice quality is noticeably poor in SUSE 10. After
> further
> > investigation, I see most of the 'read' system
> calls fail with EAGAIN
> > (resource unavailable) error.
> 
> EAGAIN is no fatal error but means that samples are not
> available for
> read when the stream is opened in non-blocking mode.  If it
> happens so
> often, it's likely a parameter mismatch.  For example,
> the read period
> size apps expected doesn't match with the size actually
> set.
> 
> It's better to create a small test-case first then
> analyze the problem
> with it.
> 
> 
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
