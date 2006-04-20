From: James Stafford <jstafford@ampltd.com>
Subject: Re: AUDIO2000 and DShare plugin
Date: Thu, 20 Apr 2006 16:27:01 +0100
Message-ID: <4.2.2.20060420160712.02ab55f8@192.168.1.6>
References: <4.2.2.20060418153155.0514e5d0@192.168.1.6>
 <4.2.2.20060418153155.0514e5d0@192.168.1.6> <s5hfyk8b8n4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hfyk8b8n4.wl%tiwai@suse.de>
References: <4.2.2.20060418153155.0514e5d0@192.168.1.6>
 <4.2.2.20060418153155.0514e5d0@192.168.1.6>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


>
>Could you try with ALSA 1.0.11?

I tried with 1.0.11rc5 and still had the problem (I don't currently have 
the hardware setup to try 1.0.11).
In the end I solved the seg fault by changing from using dshare to dmix.
The entries in .asoundrc ended up as follows

pcm.dshare2{
         type dmix
         ipc_key 2048
         slave {
                 pcm "hw:0"
                 format S32_LE
                 channels 6
         }
         bindings {
                 0 0
                 1 1
                 2 4
                 3 5
                 4 2
                 5 3
         }
}

pcm.frontl {
         type plug
         slave {
                 pcm "dshare2"
                 channels 6
         }
         ttable.0.0 1
}

etc

This probably isn't the most elegant solution but worked.

--
James Stafford


mailto:jstafford@ampltd.com

Advanced Micro Peripherals Ltd
Unit 1
Harrier House
Sedgeway Business Park
Witchford
Cambridge
CB6 2HY

Fax:+44 1353 659 600




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
