From: Friedrich.Ewaldt@gmx.de
Subject: Re: [PATCH] capture bug in cs46xx driver ...
Date: Tue, 6 Aug 2002 11:07:41 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <17001.1028624861@www44.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mx0.gmx.net (mx0.gmx.net [213.165.64.100])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id LAA11792
	for <alsa-devel@alsa-project.org>; Tue, 6 Aug 2002 11:08:21 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Benny Sjostrand <gorm@cucumelo.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

>> I've sucessfully managed  to record some stuff with a microphone so I 
>> believe
>> the capture part works again.

the cvs versions now works for me (Terratec XFire), too :-)

>> 
>> This patch is against current today CVS, includes:
>> - capture fix, DSP was using same buffer for output as for input + some 
>> minor cleanups.
>> - Santa Cruz secondary CODEC rear output support (cucumalative to my 
>> previous patch)
>
>thanks, applied to cvs now.
>
>
>ciao,
>
>Takashi

many thanks Benny,
fritz_e

-- 
GMX - Die Kommunikationsplattform im Internet.
http://www.gmx.net



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
