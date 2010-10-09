From: Valentine Sinitsyn <valentine.sinitsyn@gmail.com>
Subject: Re: Mic + Headphone Problem in Samsung R540
Date: Sat, 09 Oct 2010 11:46:27 +0600
Message-ID: <4CB001B3.807@gmail.com>
References: <87aams5t14.fsf@alamut.ozu.edu.tr>	<87vd5cew6b.fsf@alamut.ozu.edu.tr>
	<4CAF104F.30201@gmail.com> <87y6a8de30.fsf_-_@alamut.ozu.edu.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 7548B103871
	for <alsa-devel@alsa-project.org>;
	Sat,  9 Oct 2010 07:46:32 +0200 (CEST)
Received: by ewy8 with SMTP id 8so955165ewy.38
	for <alsa-devel@alsa-project.org>; Fri, 08 Oct 2010 22:46:32 -0700 (PDT)
In-Reply-To: <87y6a8de30.fsf_-_@alamut.ozu.edu.tr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Volkan YAZICI <yazicivo@ttmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

> Can you say anything about the headphone problem? Plugging -in/-out
> headphones doesn't have any effect.
It's not easy to say anything definite without having similar laptop at 
hands, but at the first glance it looks like the model you've selected 
for your soundcard (model=basic) attaches headphones to the wrong pin 
complex (Node 0x15 in the output [1]). Node 0x21 seems to be correct one 
for me, but it is just a guess which you can check by downloading HDA 
Analyzer GUI tool (python and pygtk are required) from ALSA website [2] 
and unmuting Node 0x21 output amplifiers manually, without using 
alsamixer or any other ALSA tool. This wouldn't help to fix your problem 
once and forever, but may help to see if the guess is correct. If it is, 
try another model for your soundcard (my impression is that 
autodetection, i.e. removing model= part altogether usually gives good 
results - you can even try to do it in a first place, without resorting 
to HDA Analyzer, and see if that helps). If it's not, try to loop 
through other pin widgets (0x1a is another suspect) in HDA Analyzer and 
unmute them while trying to play something in your headphones.

[1] 
http://www.alsa-project.org/db/?f=3571a643ab90e53100fa319edaa32b8b0dabfd00
[2] http://www.alsa-project.org/main/index.php/HDA_Analyzer

Regards,
Valentine
