From: Florian Bomers <Florian.Bomers@sun.com>
Subject: xrun recovery
Date: Wed, 02 Oct 2002 17:14:23 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D9B8BDF.B58785EC@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: ALSA devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

I was wondering for the example xrun_recovery function:

http://www.alsa-project.org/alsa-doc/alsa-lib/_2test_2pcm_8c-example.html#a15

In the ESTRPIPE case, it repeats to resume until it does not return EAGAIN
anymore. Then it calls snd_pcm_prepare only if snd_pcm_resume returned a
negative error code - why is that ? I would assume that if snd_pcm_resume
returns a negative non-EAGAIN value, there is some kind of problem. For me,
calling snd_pcm_prepare only makes sense if the snd_pcm_resume was successful. 

i.e. in the line following "sleep(1)": instead of "if (err < 0)", use "if (err
== 0)". 
Is that correct ?

Thanks,
Florian


-- 
Florian Bomers
Java Sound
Java Software/Sun Microsystems, Inc.
http://java.sun.com/products/java-media/sound/


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
