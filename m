From: "Nikhil Rao" <nikhil_p_rao@hotmail.com>
Subject: Bug with PCM plug layer with mmap emulation=true ?
Date: Mon, 3 Apr 2006 16:26:57 -0700
Message-ID: <BAY111-DAV2D085846867FCF9E71A4EC2D50@phx.gbl>
References: <20060403204202.9304C12C9C@sc8-sf-spam2.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

I have observed that the using pcm plug layer with mmap emulation=true in 
alsa.conf, causes the first period of data to be sent twice to the driver. I 
also verified this by dumping the PCM data to a file (using the copy 
callback)

I have tried experiments using the ALSA driver (ver 1.0.10) written by me 
for  my development system (an SoC)
and also the intelx80 driver on a Suse 10.0 system (ALSA ver 1.0.9b). I 
modified the intelx80 driver so that it only supports 48Khz and then used 
the plughw device to playout a 44Khz sample. There is a distinct stutter 
audible at the beginning of the clip caused by the first period being 
presented twice to the hardware.

Is this a known problem ? if so, is a workaround available (my development 
platform does not support mmap currently).

Thanks,
Nikhil 


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
