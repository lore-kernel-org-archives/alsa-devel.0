From: Frank Barknecht <fbar@footils.org>
Subject: Quattro woes or: What does "SNDRV_PCM_IOCTL_START failed" mean?
Date: Mon, 10 Mar 2003 23:33:22 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030310223321.GA10836@fliwatut.scifi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hallo,

I have to apologize first for asking a probably totally ignorant
question, but I really have no clue of ALSA-programming :(

But I need/want to get Pd running on my Laptop with a Quattro USB for
the LAD conference next weekend, and this requires, that I somehow
debug what goes wrong in Pd with ALSA.

I keep getting the following error, when starting Pd in ALSA mode with
"hw:0,0" or any other ALSA device (like the ones Patrick set up in his
.asoundrc on alsa-project.org):

ALSA lib pcm_hw:454(snd_pcm_hw_start) SNDRV_PCM_IOCTL_START failed:
Broken pipe

Responsible for ALSA in Pd is the file s_linux.c, that can be seen
at our sourceforge-CVS: 

http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/pure-data/pd/src/s_linux.c?rev=1.1.1.2.2.7&only_with_tag=devel_0_36&content-type=text/vnd.viewcvs-markup

It obviously fails somewhere around:
    
    if (outchans)
    {
	err = snd_pcm_start(alsa_device.outhandle);
	check_error(err, "snd_pcm_start");
    }

Now, what makes this the real problem, is that the same code works on
another machine just fine, all with alsa-0.9rc7 and the same binary
and the same source.

Because of that I somehow doubt (but cannot judge it) that the reason
is a wrong handling of the asound API in Pd's s_linux.c, but something
else, something machine dependent. Also on both machines, ALSA in
general is working fine, I can play music with alsaplayer and all
that.

So now I'm quite clueless with this. Maybe someone here can shed a
light on the question: 
 What are typical reasons for snd_pcm_start failing this way?

Thank you in advance.

Regards,
-- 
 Frank Barknecht                               _ ______footils.org__


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
