From: David Van Duzer <david@tennica.net>
Subject: ALC655/658 patch breaks stereo output
Date: Wed, 14 Jan 2004 21:50:38 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040115045038.GA10935@arecibo.tennica.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Greetings -

I have an ABIT AN7 motherboard with an nForce2 audio controller.  The
AC97 chip is an ALC658, and the patch from ac97_patch.c from 1.30 to
1.31 in CVS seems to have broken standard stereo output.  I can get some
sound output from my speakers if I enable Line-In As Surround and
Duplicate Front, but it is very faint.  Without these features enabled,
I don't get any audio output from any of the analog output jacks.

I've looked at the code, for patch_alc655() as compared to
patch_alc650() but I'm not proficient enough to figure out what to
change to make it work, so I've simply modified ac97_codec.c to use
patch_alc650() for my ALC658.  There seem to be other people on the
alsa-users list with a similar problem, and I'd be happy to help try and
diagnose the problem further, but I'm not sure what other information
will be helpful.

TIA
David Van Duzer


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
