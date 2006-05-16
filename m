From: Juan Carlos Castro y Castro <jcastro@instant.com.br>
Subject: Re: Another asinine question
Date: Tue, 16 May 2006 15:44:34 -0300
Message-ID: <446A1D92.3020600@instant.com.br>
References: <4464A474.6070604@instant.com.br> <s5h3bfa3x9e.wl%tiwai@suse.de> <4469E2B2.4040800@instant.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4469E2B2.4040800@instant.com.br>
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

Juan Carlos Castro y Castro wrote:

> By the way, my pcm_file extensions DO work! It's the "plug" plugin 
> that's not passing the reads! Stay tuned...

I'm pretty sure now the problem lies with the plug plugin -- I am either 
not using it right (more likely) or I need to use a different plugin 
entirely (less likely) or more hacking will be needed (unlikely).

Current status is: with my changes, if I use the file PCM as microphone 
input (and use capture parameters that match the raw input file format), 
capture works. The "plug" PCM is for format conversion, and it doesn't 
work for input, only for output. Here's my current .asoundrc:

------------------------------------------------------------
pcm.fileout {
        type file
        file /home/jcastro/alsaout.raw
        infile /home/jcastro/alsain.raw
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
