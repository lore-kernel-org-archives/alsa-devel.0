From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: PCM parameters in file plugin
Date: Mon, 05 Jan 2009 21:54:45 +0100
Message-ID: <49627395.1090506@insite.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailserver.bobrnet.net (bobrnet.cust.inethome.cz [88.146.180.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 9466E103841
	for <alsa-devel@alsa-project.org>; Mon,  5 Jan 2009 21:54:51 +0100 (CET)
Received: from [192.168.105.213] (ap-dustin.bobrnet.cz [10.109.8.38])
	by mailserver.bobrnet.net (8.13.8/8.13.8/Debian-3) with ESMTP id
	n05Kso4u010378
	for <alsa-devel@alsa-project.org>; Mon, 5 Jan 2009 21:54:50 +0100
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

Hello,

I am working on a file plugin patch to allow adding PCM parameters 
(rate, format) to  the name of the file created (plus the ability to run 
an external command via popen, such as upsampling with sox). I got stuck 
in trying to obtain these parameters in pcm_file.c:_snd_pcm_file_open(). 
Is it actually possible or the information is not available at the time 
of opening the file (and the whole patch is thus nonsense)?

Thanks a lot for help.

Pavel.
