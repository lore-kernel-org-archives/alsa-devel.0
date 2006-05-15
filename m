From: Juan Carlos Castro y Castro <jcastro@instant.com.br>
Subject: Re: Doubt on implementing .readi and .readn methods
Date: Mon, 15 May 2006 18:29:33 -0300
Message-ID: <4468F2BD.70208@instant.com.br>
References: <4464E1B7.6070601@instant.com.br> <s5hac9jws8q.wl%tiwai@suse.de>	 <4468DF11.4000000@instant.com.br> <1147725511.13948.29.camel@mindpipe>	 <4468EB0C.6030909@instant.com.br> <1147727959.13948.40.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1147727959.13948.40.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:

>>OK, but anyway you got me curious. If one of my apps wasn't proprietary, 
>>and I decided to alter both to use JACK instead of ALSA, you say I could 
>>do acoustic coupling?
>>    
>>
>Yes, it's exactly what JACK was designed for.
>
>There are some things JACK isn't suitable for (like VOIP due to the lack of resampling).
>  
>
Which the file plugin does wonderfully well (for output at least.) Or, 
rather, it isn't the file plugin that does this, it's the... plug 
plugin, right? The .asoundrc below works well for output but I don't 
fully grok it.

------------------------------------------------------------
pcm.fileout {
        type file
        file /home/jcastro/alsaout.raw
        slave.pcm null
}

pcm_slave.sl3 {
    pcm "fileout"
    format S16_LE
    channels 1
    rate 48000
}

pcm.complex_convert {
    type plug
    slave sl3
}
------------------------------------------------------------



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
