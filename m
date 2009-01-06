From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Re: PCM parameters in file plugin
Date: Tue, 06 Jan 2009 10:51:17 +0100
Message-ID: <49632995.9000109@insite.cz>
References: <49627395.1090506@insite.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.insite.cz (cable.insite.cz [84.242.84.93])
	by alsa0.perex.cz (Postfix) with ESMTP id B80762414F
	for <alsa-devel@alsa-project.org>; Tue,  6 Jan 2009 10:51:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by server.insite.cz (Postfix) with ESMTP id CC78910240AB
	for <alsa-devel@alsa-project.org>; Tue,  6 Jan 2009 10:51:31 +0100 (CET)
Received: from server.insite.cz ([127.0.0.1])
	by localhost (server.insite.cz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K6P+VzqMX49u for <alsa-devel@alsa-project.org>;
	Tue,  6 Jan 2009 10:51:31 +0100 (CET)
Received: from [192.168.1.20] (sara.insite.cz [192.168.1.20])
	by server.insite.cz (Postfix) with ESMTP id A4393101FDB8
	for <alsa-devel@alsa-project.org>; Tue,  6 Jan 2009 10:51:16 +0100 (CET)
In-Reply-To: <49627395.1090506@insite.cz>
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

Pavel Hofman napsal(a):
> Hello,
> 
> I am working on a file plugin patch to allow adding PCM parameters 
> (rate, format) to  the name of the file created (plus the ability to run 
> an external command via popen, such as upsampling with sox). I got stuck 
> in trying to obtain these parameters in pcm_file.c:_snd_pcm_file_open(). 
> Is it actually possible or the information is not available at the time 
> of opening the file (and the whole patch is thus nonsense)?
> 
> Thanks a lot for help.
> 

I am now opening the output file in pcm_file.c:snd_pcm_file_write_bytes.
Surprisingly it seems to work fine. Could such hack be accepted as a
patch to the plugin (if coded properly)? Is there a better place to open 
the file?

Thanks,

Pavel.


-- 
-----------------

inSITE, s.r.o.

Rubesova 29, 326 00 Plzen
Tel. +420 377 449 358
Fax  +420 222 745 553
GSM: +420 603 163 973
Email: pavel.hofman@insite.cz

www.educity.cz, www.jobcity.cz
www.meetings.cz, www.hrzive.cz
www.comben.cz, www.insite.cz

-------------------------------
Navstivte www.educity.cz, server
s nejvetsi nabidkou profesniho
vzdelavani na ceskem internetu.
