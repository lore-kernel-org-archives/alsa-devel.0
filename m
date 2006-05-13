From: Gerald Grabner <gerald.grabner@gmx.net>
Subject: quit snd_pcm_readi, retrieve pending frames
Date: Sat, 13 May 2006 13:06:51 +0200
Message-ID: <4465BDCB.7010900@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hi,

I'm experimenting with the ALSA PCM API and was wondering whether
there is a simple way to exit a record loop by stopping the pcm, but
without loosing pending frames.

Initially, I was thinking of something like this, where I would call
snd_pcm_drop(pcm) from some other thread:

   while ( true )
     {
       r = snd_pcm_readi (pcm, data, frames);
       fwrite (data, 2, 2*r, file);
       if ( r != frames )
         break;
     }

However, snd_pcm_drain(pcm) doesn't work here; the loop continues.
snd_pcm_drop(pcm) breaks the loop, but pending frames are lost, and
r=-EBADFD.

Is there an easy way to stop snd_pcm_readi in a way that I can
retrieve the residual frames? Do I need to set any parameters for
that purpose?

Many thanks,
Gerald

BTW: I'm using alsa 1.0.11 on gentoo.


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
