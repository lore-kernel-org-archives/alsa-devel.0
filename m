From: Dolevo Jay <cmst@live.com>
Subject: How to apply rate conversion in asound.conf
Date: Wed, 6 Nov 2013 15:02:33 +0000
Message-ID: <DUB122-W45C29A2FD0EE3B2FC1A459AAF00@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dub0-omc3-s2.dub0.hotmail.com (dub0-omc3-s2.dub0.hotmail.com
 [157.55.2.11]) by alsa0.perex.cz (Postfix) with ESMTP id A521C261AA6
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2013 16:02:34 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi experts,

I am currently using the following asound.conf, which is pretty much
copy-paste from the link below.

asound.conf
-------------------------------------
pcm.!default {
	type plug
	slave.pcm multi
}

pcm.multi {
        type multi;
        slaves.a.pcm "hw:0,1";
        slaves.a.channels 2;
        slaves.b.pcm "hw:1,1";
        slaves.b.channels 2;

        bindings.0.slave a;
        bindings.0.channel 0;
        bindings.1.slave a;
        bindings.1.channel 1;
        bindings.2.slave b;
        bindings.2.channel 0;
        bindings.3.slave b;
        bindings.3.channel 1;
}
-------------------------------------

http://www.alsa-project.org/main/index.php/Asoundrc#Virtual_multi_channel_devices
-------------------------------------

My purpose is to apply rate conversion to the "hw:1,1" and have 44100 rate
out. There is a sample conversion like: 

pcm.rate_convert {
	type rate
	slave sl2
}

but how can I attach this rate_convert code to the multi code?

Thanks. 		 	   		  
