From: Doug McLain <nostar@comcast.net>
Subject: return value of snd_pcm_hw_params_set_rate_near
Date: Mon, 01 Mar 2004 02:21:51 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4042E48F.8090009@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

According to the alsa documentation, the return value of 
snd_hw_params_set_rate_near is the 'approximate chosen rate', and the 
3rd arg being type 'int'.  The two tutorials at the documentation 
section of the alsa-project website both hold true to this with code like:

exact_rate = snd_pcm_hw_params_set_rate_near(pcm_handle, hwparams, rate, &dir);
    if (dir != 0) {
      fprintf(stderr, "The rate %d Hz is not supported by your hardware.\n 
                       ==> Using %d Hz instead.\n", rate, exact_rate);
    }



After unsuccesful attempts at using this function this way (I'm learning 
linux audio software devel starting with alsa drivers and user 
interface), I went into the aplay source and found the version that 
tests a before and after version of arg 3 (which is a pointer to int 
that gets changed to the result rate by the function) and tests the 
return only for err. I assume this function changed?  Im at the learning 
stage so I'm probably stating the obvious, but when your new sometimes 
reassurance from someone that knows helps.  Is the documentaion just 
behind, or did this slip by unnoticed?  Curious...

---

http://nostar.isa-geek.com




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
