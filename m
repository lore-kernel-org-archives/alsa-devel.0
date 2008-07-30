From: Rahul Iyer <rahul.iyer@ymail.com>
Subject: ALSA OSS Emulation - Read - EAGAIN Errors
Date: Wed, 30 Jul 2008 08:20:09 -0700 (PDT)
Message-ID: <233031.41599.qm@web59615.mail.ac4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from n6.bullet.mail.ac4.yahoo.com (n6.bullet.mail.ac4.yahoo.com
	[76.13.13.234]) by alsa0.perex.cz (Postfix) with SMTP id 33A8424998
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Jul 2008 17:20:11 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi ALSA Developers


I have a full duplex voice application, that records voice and sends
(over a network) as well as receives and plays voice. OSS APIs are used
to capture and play voice samples. 

The voice quality is noticeably poor in SUSE 10. After further
investigation, I see most of the 'read' system calls fail with EAGAIN
(resource unavailable) error. This is not the case in SUSE 9.2.
This results in poor voice quality -- broken voice, due to loss of voice samples.

Please take a look at the strace stats below for SUSE 9.2 and 10. Check the errors column for SUSE 10. 

SUSE 9.2
Process 17533 detached
% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 51.54    0.824285          48     17152           gettimeofday
 14.36    0.229609          52      4393       693 select
 9.85     0.157454          76      2081       692 sigreturn
 7.89     0.126199          14      8784            rt_sigprocmask
 7.74     0.123765          20      6201           ioctl
 4.31     0.068929          33      2067           read
 4.31     0.068898          33      2067           write
 0.01     0.000083           6        14           alarm
 0.00     0.000034          11         3           munmap
 0.00     0.000007           4 
        2           rt_sigaction
 0.00     0.000003           3         1         1 open
------ ----------- ----------- --------- --------- ----------------
100.00    1.599266                 42765      1386 total


SUSE 10
Process 11342 detached
% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 49.58    1.006722           1   1191090   1189103 read
 49.44    1.003873           1   1194607           ioctl
 0.95     0.019285          11      1698           write
 0.02     0.000453           0      1152       551 select
 0.00     0.000038          13         3           munmap
 0.00     0.000015           0      9230           gettimeofday
 0.00     0.000000           0         1         1 open
 0.00     0.000000           0        11           alarm
 0.00     0.000000           0      
 0.00     0.000000           0       793       624 sigreturn
 0.00     0.000000           0         6           sched_yield
 0.00     0.000000           0         2           rt_sigaction
 0.00     0.000000           0      2303           rt_sigprocmask
------ ----------- ----------- --------- --------- ----------------
100.00    2.030386               2400896   1190279 total
BTW, the SUSE 10 machine runs on newer hardware with on board Intel HDA Sound (Realtek ALC262). 

Any thoughts on what causes so many read failures? Could this be
hardware/driver related? There is nothing fancy about this sound card,
its a regular on board card. It would be great if someone can
confirm their experience with this card.

Any suggestions are also most welcome...

Thanks for the help.--
Rahul Iyer
