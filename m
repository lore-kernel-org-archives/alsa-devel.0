From: Elisavet Vorgia <elisavet_vorgia@yahoo.gr>
Subject: Multiple sound problems with ALC888 (1025:013f) on
	Acer Aspire 5930
Date: Wed, 30 Mar 2011 11:54:10 +0300
Message-ID: <4D92EFB2.7090209@yahoo.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm14.bullet.mail.ne1.yahoo.com (nm14.bullet.mail.ne1.yahoo.com
	[98.138.90.77]) by alsa0.perex.cz (Postfix) with SMTP id C1C2A2447E
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Mar 2011 10:54:14 +0200 (CEST)
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

Hi All,

I have sound issues with my laptop, I cannot get 5.1 sound and jack 
sensing does not work (but works on Windows 7; dual-boot).

I have an Acer Aspire 5930 (chipset: ALC888) running Ubuntu 10.10 (64-bit).
I have tested with Alsa 1.0.23 (which comes with Ubuntu 10.10) and also
compiled Alsa 1.0.24.
Here is the Alsa-info with Alsa 1.0.24 (latest), and "model=auto",
http://www.alsa-project.org/db/?f=2cbab ... 31dc6a7d70 
<http://www.alsa-project.org/db/?f=2cbab995516f4b56a7faecf537f61f31dc6a7d70>

Here is alsa-info with "model=acer-aspire-6530g",
http://www.alsa-project.org/db/?f=40992 ... 17160cde64 
<http://www.alsa-project.org/db/?f=409923a3d8f042804e61f21c7b8ae917160cde64>

However, on Linux,
1. the sound volume is too low compared to Windows 7. For example,
     50% on the volume bar in Ubuntu is roughly equivalent to 10% in 
Windows 7.
2. the subwoofer control bar in Sound Preferences Settings seems to 
control the master volume bar.
3. it seems that only 2 speakers actually work (Front Left and Front 
Right) as tested with speaker-test -c6 -twav
4. when I plug in the headphones jack the internal speakers don't get 
muted, instead I have combined sound output.

I tried to change the model from auto to "acer" (tested all the acer and 
the 6stack-dig models
and settled down to acer-aspire-6530g as a popular suggestion) but it 
didn't change much.
(You'll find the alsa-info.txt as an attachment to this message.)

Is there any possible solution or suggestion for this problem?
I am happy to try out patches.

Thanks,
Elisavet
