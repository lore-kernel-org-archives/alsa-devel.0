From: Paul Davis <pbd@Op.Net>
Subject: Re: stupid question about pcm devices
Date: Fri, 08 Feb 2002 09:48:58 -0500
Message-ID: <200202081449.JAA27593@renoir.op.net>
In-reply-to: Your message of "Fri, 08 Feb 2002 07:24:44 +0100."
             <XFMail.020208072444.guenther.sohler@newlogic.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Guenther Sohler <guenther.sohler@newlogic.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>I have seen that alsa provides nice pcm devices in /dev/snd directory
>
>*They are split in playback and capture devices :) nice idea.
>In Oss I was able to pipe data from and to them and therfore was
>recording/playing back at a certain sample rate.
>With alsa this is not possible anymore. it says the descriptor was in a bad
>state. Is it possible ???

jaroslav answered this in one way. i'd like to add this:

under OSS, most people understand that cat > /dev/dspN requires that
the data match the "default" format for the "dsp" device. any mismatch
will result in noise. the same is true for ALSA.

however, under ALSA, the devices are not that simple. specifically,
OSS required opening+closing devices to reset the parameters, whereas
ALSA instead allows the devices to remain open, but stopped,
reconfigured, then restarted. these are all done by ioctl(2) calls.

this means that, in terms of system calls, there is always at least
one ioctl(2) call required to get the device started after it is
opened. as a result of this, "cat > /dev/snd/pcmC0D0" or equivalent
will never work, since cat merely calls open(2) on the device - it
does not start it (i.e. make the ioctl(2) call).

i suspect that some people in the kernel community will object to this
design, noting that it violates The Unix Way. however, there are many
devices that require ioctl(2)'s to get them set up for use, so ALSA
will not be the first. i doubt, for example, if "cat > /dev/scanner"
will work, and "cat > /dev/modem" normally results in garbage
someplace. 

>*Is there something like aconnect for pcm devices ????
>
>when I do a sfxload, it operates on /dev/sequencer, which makes the seq-oss
>module automatically to load. Is there a way to load the patches in native als
>a
>???

rewrite sfxload.

--p

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
