From: Ed Wildgoose <lists@wildgooses.com>
Subject: Re: rme 9632 crackling when sound > 0db
Date: Mon, 12 Apr 2004 11:07:39 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <407A6A6B.2070201@wildgooses.com>
References: <407A5F99.4040201@wildgooses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from xunil.mail.wildgooses.com (xunil.mail.wildgooses.com [81.6.236.5])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id MAA19720
	for <alsa-devel@alsa-project.org>; Mon, 12 Apr 2004 12:07:50 +0200
Received: from localhost (Xunil [127.0.0.1])
	by xunil.mail.wildgooses.com (Postfix) with ESMTP id E4FB51707E2
	for <alsa-devel@alsa-project.org>; Mon, 12 Apr 2004 11:07:40 +0100 (BST)
Received: from wildgooses.com (unknown [192.168.105.1])
	by xunil.mail.wildgooses.com (Postfix) with ESMTP id A7F811707E1
	for <alsa-devel@alsa-project.org>; Mon, 12 Apr 2004 11:07:40 +0100 (BST)
In-Reply-To: <407A5F99.4040201@wildgooses.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


>
> You can also simulate this simply by turning up the mixer controls so 
> that normal music starts to clip.  Same effect.



At risk of creating noise.  Further experimentation shows that you need 
to set the output levels to +4db in hdspconf for this crackling to 
occur.  So in fairness this could really be an overdriven output...?

The -10dbv output level is significantly quieter than any other 
equipment that I own (I know it's what they call consumer output device 
level, but still...)

Ed W


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
